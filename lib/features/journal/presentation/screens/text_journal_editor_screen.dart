import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';
import 'package:freud_ai/core/widgets/custom_app_bar.dart';
import 'package:freud_ai/core/data/local/database_helper.dart';
import 'package:freud_ai/core/providers/connectivity_provider.dart';
import 'package:freud_ai/core/utils/validators.dart';
import 'package:freud_ai/core/widgets/error_banner.dart';
import 'package:freud_ai/core/widgets/confirmation_dialog.dart';
import 'package:provider/provider.dart';

class TextJournalEditorScreen extends StatefulWidget {
  final String? initialPrompt;
  final String? existingTitle;
  final String? existingContent;

  const TextJournalEditorScreen({
    super.key,
    this.initialPrompt,
    this.existingTitle,
    this.existingContent,
  });

  @override
  State<TextJournalEditorScreen> createState() => _TextJournalEditorScreenState();
}

class _TextJournalEditorScreenState extends State<TextJournalEditorScreen> {
  late TextEditingController _titleController;
  late QuillController _quillController;
  late FocusNode _titleFocusNode;

  String? _selectedMood;
  final List<Map<String, dynamic>> _moods = [
    {'label': 'Happy', 'icon': '😊', 'color': CustomColors.light.green},
    {'label': 'Sad', 'icon': '😢', 'color': CustomColors.light.orange},
    {'label': 'Anxious', 'icon': '😰', 'color': CustomColors.light.yellow},
    {'label': 'Calm', 'icon': '😌', 'color': CustomColors.light.violet},
    {'label': 'Angry', 'icon': '😠', 'color': CustomColors.light.grey},
    {'label': 'Excited', 'icon': '🤩', 'color': CustomColors.light.yellow},
  ];

  int _wordCount = 0;
  bool _isSaving = false;
  bool _hasUnsavedChanges = false;
  DateTime? _lastAutoSave;
  bool _showToolbar = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existingTitle ?? '');

    // Initialize Quill controller with existing content or initial prompt
    final initialContent = widget.existingContent ?? (widget.initialPrompt != null ? '${widget.initialPrompt}\n\n' : '');
    _quillController = QuillController(
      document: Document()..insert(0, initialContent),
      selection: const TextSelection.collapsed(offset: 0),
    );

    _titleFocusNode = FocusNode();

    _quillController.addListener(_updateWordCount);
    _quillController.addListener(_onContentChanged);
    _titleController.addListener(_onContentChanged);
    _updateWordCount();

    // Auto-save every 30 seconds
    _startAutoSaveTimer();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _quillController.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  void _updateWordCount() {
    final text = _quillController.document.toPlainText().trim();
    final words = text.isEmpty ? 0 : text.split(RegExp(r'\s+')).length;
    setState(() => _wordCount = words);
  }

  void _onContentChanged() {
    if (!_hasUnsavedChanges) {
      setState(() => _hasUnsavedChanges = true);
    }
  }

  void _startAutoSaveTimer() {
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted && _hasUnsavedChanges) {
        _autoSave();
      }
      _startAutoSaveTimer(); // Restart timer
    });
  }

  Future<void> _autoSave() async {
    if (_titleController.text.trim().isEmpty && _quillController.document.toPlainText().trim().isEmpty) {
      return; // Don't auto-save empty entries
    }

    try {
      if (kIsWeb) return; // Skip local save on web

      // Save to local database
      final dbHelper = DatabaseHelper.instance;
      final now = DateTime.now();
      
      await dbHelper.insertJournalEntry({
        'id': 'journal_${now.millisecondsSinceEpoch}',
        'title': _titleController.text.trim(),
        'content': _quillController.document.toPlainText(),
        'mood': _selectedMood ?? '',
        'created_at': now.millisecondsSinceEpoch,
        'updated_at': now.millisecondsSinceEpoch,
        'is_synced': 0, // Will be synced when online
        'word_count': _wordCount,
      });

      if (mounted) {
        setState(() {
          _hasUnsavedChanges = false;
          _lastAutoSave = DateTime.now();
        });

        // Show subtle auto-save indicator
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Auto-saved locally'),
            duration: const Duration(seconds: 1),
            backgroundColor: Theme.of(context).extension<CustomColors>()!.green.withOpacity(0.8),
          ),
        );
      }
    } catch (e) {
      // Handle error silently for auto-save
    }
  }

  Future<void> _saveEntry() async {
    // Validate title
    final titleError = Validators.validateRequired(
      _titleController.text,
      fieldName: 'Title',
    );

    // Validate content
    final contentText = _quillController.document.toPlainText().trim();
    final contentError = Validators.validateMinLength(
      contentText,
      10,
      fieldName: 'Content',
    );

    // Show validation errors
    if (titleError != null) {
      ErrorBanner.show(
        context: context,
        type: ErrorType.validation,
        message: titleError,
      );
      return;
    }

    if (contentError != null) {
      ErrorBanner.show(
        context: context,
        type: ErrorType.validation,
        message: contentError,
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      if (kIsWeb) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Local saving is not supported on Web demo')),
          );
          Navigator.pop(context);
        }
        setState(() => _isSaving = false);
        return;
      }

      // Save to local database
      final dbHelper = DatabaseHelper.instance;
      final now = DateTime.now();
      
      await dbHelper.insertJournalEntry({
        'id': 'journal_${now.millisecondsSinceEpoch}',
        'title': _titleController.text.trim(),
        'content': _quillController.document.toPlainText(),
        'mood': _selectedMood ?? '',
        'created_at': now.millisecondsSinceEpoch,
        'updated_at': now.millisecondsSinceEpoch,
        'is_synced': 0, // Will be synced when online
        'word_count': _wordCount,
      });

      setState(() => _isSaving = false);

      if (mounted) {
        final isOnline = context.read<ConnectivityProvider>().isOnline;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isOnline 
                ? 'Journal entry saved successfully!' 
                : 'Saved locally. Will sync when online.',
            ),
            backgroundColor: Theme.of(context).extension<CustomColors>()!.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() => _isSaving = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving entry: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>()!;
    final isOnline = context.watch<ConnectivityProvider>().isOnline;

    return Scaffold(
      appBar: customAppBar(
        theme: theme,
        title: widget.existingTitle != null ? 'Edit Entry' : 'New Entry',
        actions: [
          // Offline indicator
          if (!isOnline)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange, width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cloud_off, size: 14, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        'Offline',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (_isSaving)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _saveEntry,
              tooltip: 'Save',
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(SizesManager.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title field
                  _buildTitleField(theme),
                  const SizedBox(height: SizesManager.padding),

                  // Mood selector
                  _buildMoodSelector(theme),
                  const SizedBox(height: SizesManager.dPadding),

                  // Content field
                  _buildContentField(theme),
                ],
              ),
            ),
          ),

          // Bottom toolbar
          _buildBottomToolbar(theme, colors),
        ],
      ),
    );
  }

  Widget _buildTitleField(ThemeData theme) {
    final colors = theme.extension<CustomColors>()!;
    return TextField(
      controller: _titleController,
      focusNode: _titleFocusNode,
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: colors.primary,
      ),
      decoration: InputDecoration(
        hintText: 'Entry title...',
        hintStyle: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: colors.primary.withOpacity(0.3),
        ),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      maxLines: 2,
      textCapitalization: TextCapitalization.sentences,
    ).animate().fadeIn(duration: AnimationUtils.normal).slide(begin: const Offset(0, 0.1));
  }

  Widget _buildMoodSelector(ThemeData theme) {
    final colors = theme.extension<CustomColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How are you feeling?',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colors.primary,
          ),
        ).animate().fadeIn(delay: const Duration(milliseconds: 100)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _moods.asMap().entries.map((entry) {
            final index = entry.key;
            final mood = entry.value;
            final isSelected = _selectedMood == mood['label'];

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedMood = isSelected ? null : mood['label'] as String;
                });
              },
              child: AnimatedContainer(
                duration: AnimationUtils.fast,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (mood['color'] as Color).withOpacity(0.15)
                      : colors.primaryContainer.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? (mood['color'] as Color)
                        : colors.onPrimaryContainer.withOpacity(0.3),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      mood['icon'] as String,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      mood['label'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected
                            ? (mood['color'] as Color)
                            : colors.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ).animateCardEntrance(
              delay: const Duration(milliseconds: 200),
              index: index,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildContentField(ThemeData theme) {
    final colors = theme.extension<CustomColors>()!;
    return Column(
      children: [
        // Formatting toolbar toggle
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() => _showToolbar = !_showToolbar);
              },
              icon: Icon(
                _showToolbar ? Icons.format_bold : Icons.text_format,
                color: colors.primary,
              ),
              tooltip: _showToolbar ? 'Hide formatting' : 'Show formatting',
            ),
            if (_showToolbar)
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => _quillController.formatSelection(Attribute.bold),
                          icon: const Icon(Icons.format_bold, size: 20),
                          tooltip: 'Bold',
                        ),
                        IconButton(
                          onPressed: () => _quillController.formatSelection(Attribute.italic),
                          icon: const Icon(Icons.format_italic, size: 20),
                          tooltip: 'Italic',
                        ),
                        IconButton(
                          onPressed: () => _quillController.formatSelection(Attribute.underline),
                          icon: const Icon(Icons.format_underline, size: 20),
                          tooltip: 'Underline',
                        ),
                        IconButton(
                          onPressed: () => _quillController.formatSelection(Attribute.ul),
                          icon: const Icon(Icons.format_list_bulleted, size: 20),
                          tooltip: 'Bullet List',
                        ),
                        IconButton(
                          onPressed: () => _quillController.formatSelection(Attribute.ol),
                          icon: const Icon(Icons.format_list_numbered, size: 20),
                          tooltip: 'Numbered List',
                        ),
                        IconButton(
                          onPressed: () => _quillController.formatSelection(Attribute.blockQuote),
                          icon: const Icon(Icons.format_quote, size: 20),
                          tooltip: 'Quote',
                        ),
                        IconButton(
                          onPressed: () => _quillController.undo(),
                          icon: const Icon(Icons.undo, size: 20),
                          tooltip: 'Undo',
                        ),
                        IconButton(
                          onPressed: () => _quillController.redo(),
                          icon: const Icon(Icons.redo, size: 20),
                          tooltip: 'Redo',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),

        // Quill Editor
        GestureDetector(
          onTap: () {
            // Request focus when tapped
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            constraints: const BoxConstraints(minHeight: 300),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: colors.onPrimaryContainer.withOpacity(0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: QuillEditor.basic(
              controller: _quillController,
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: const Duration(milliseconds: 300)).slide(begin: const Offset(0, 0.1));
  }

  Widget _buildBottomToolbar(ThemeData theme, CustomColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SizesManager.padding,
        vertical: SizesManager.vPadding,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: colors.onPrimaryContainer.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            '$_wordCount words',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onPrimaryContainer,
            ),
          ),
          const Spacer(),
          if (_lastAutoSave != null)
            Text(
              'Auto-saved ${_formatLastSaveTime(_lastAutoSave!)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.green,
                fontSize: 12,
              ),
            )
          else if (_hasUnsavedChanges)
            Text(
              'Unsaved changes',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.orange,
                fontSize: 12,
              ),
            ),
          const Spacer(),
          Text(
            DateTime.now().toString().split(' ')[0],
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  String _formatLastSaveTime(DateTime lastSave) {
    final now = DateTime.now();
    final difference = now.difference(lastSave);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else {
      return '${difference.inHours}h ago';
    }
  }
}
