import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';
import 'package:freud_ai/core/utils/animation_utils.dart';
import 'package:freud_ai/features/journal/presentation/widgets/journal_prompt_card.dart';
import 'package:freud_ai/features/journal/presentation/widgets/journal_entry_card.dart';
import 'package:freud_ai/features/journal/presentation/widgets/quick_action_button.dart';
import 'package:vibration/vibration.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  // Search and Filter state
  final TextEditingController _searchController = TextEditingController();
  String _selectedMoodFilter = 'All';
  DateTime? _startDate;
  DateTime? _endDate;
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Write'),
            Tab(text: 'History'),
          ],
          labelColor: Theme.of(context).extension<CustomColors>()!.primary,
          unselectedLabelColor: Theme.of(context).extension<CustomColors>()!.onPrimaryContainer,
          indicatorColor: Theme.of(context).extension<CustomColors>()!.green,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildWriteTab(),
          _buildHistoryTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Vibration.vibrate(duration: 50);
          _showNewEntryDialog(context);
        },
        backgroundColor: Theme.of(context).extension<CustomColors>()!.green,
        child: Icon(Icons.add, color: Theme.of(context).extension<CustomColors>()!.primaryContainer),
      ),
    );
  }

  Widget _buildWriteTab() {
    return RefreshIndicator(
      onRefresh: _refreshJournalEntries,
      color: Theme.of(context).extension<CustomColors>()!.green,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Welcome section
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).extension<CustomColors>()!.greenAccent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).extension<CustomColors>()!.green.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to your journal',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).extension<CustomColors>()!.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Express your thoughts, feelings, and experiences. Choose how you want to journal today.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).extension<CustomColors>()!.onPrimaryContainer,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: AnimationUtils.normal).slide(begin: const Offset(0, 0.1)),

          const SizedBox(height: 32),

          // Quick actions
          Text(
            'Start Journaling',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).extension<CustomColors>()!.primary,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: QuickActionButton(
                  title: 'Voice Journal',
                  subtitle: 'Speak your thoughts',
                  icon: Icons.mic,
                  color: const Color(0xFF9BB068),
                  onTap: () => _startVoiceJournal(context),
                ).animateCardEntrance(
                  delay: const Duration(milliseconds: 100),
                  index: 0,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: QuickActionButton(
                  title: 'Text Journal',
                  subtitle: 'Write your thoughts',
                  icon: Icons.edit,
                  color: const Color(0xFFA18EFF),
                  onTap: () => _startTextJournal(context),
                ).animateCardEntrance(
                  delay: const Duration(milliseconds: 100),
                  index: 1,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Guided prompts
          Text(
            'Need Inspiration?',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).extension<CustomColors>()!.primary,
            ),
          ),
          const SizedBox(height: 16),

          JournalPromptCard(
            prompt: 'What made you smile today?',
            category: 'Gratitude',
            color: const Color(0xFF9BB068),
            onTap: () => _startTextJournalWithPrompt('What made you smile today?'),
          ).animateCardEntrance(
            delay: const Duration(milliseconds: 200),
            index: 0,
          ),

          const SizedBox(height: 12),

          JournalPromptCard(
            prompt: 'What\'s something you\'re looking forward to?',
            category: 'Hope',
            color: const Color(0xFFFFCE5B),
            onTap: () => _startTextJournalWithPrompt('What\'s something you\'re looking forward to?'),
          ).animateCardEntrance(
            delay: const Duration(milliseconds: 200),
            index: 1,
          ),

          const SizedBox(height: 12),

          JournalPromptCard(
            prompt: 'How did you handle a challenge today?',
            category: 'Reflection',
            color: const Color(0xFFBDA193),
            onTap: () => _startTextJournalWithPrompt('How did you handle a challenge today?'),
          ).animateCardEntrance(
            delay: const Duration(milliseconds: 200),
            index: 2,
          ),

          const SizedBox(height: 12),

          JournalPromptCard(
            prompt: 'What are you grateful for right now?',
            category: 'Gratitude',
            color: const Color(0xFFFE804B),
            onTap: () => _startTextJournalWithPrompt('What are you grateful for right now?'),
          ).animateCardEntrance(
            delay: const Duration(milliseconds: 200),
            index: 3,
          ),
        ],
      ),
    );
  }

  Future<void> _refreshJournalEntries() async {
    // Simulate refresh delay - in real app, this would fetch new data
    await Future.delayed(const Duration(seconds: 2));

    // Show success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Journal entries refreshed'),
          backgroundColor: Theme.of(context).extension<CustomColors>()!.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildHistoryTab() {
    // Simulate loading state - in real app, this would come from a state management solution
    final isLoading = false; // Change to true to test loading state
    final hasEntries = true; // Change to false to test empty state

    if (isLoading) {
      return _buildLoadingState();
    }

    if (!hasEntries) {
      return _buildEmptyHistoryState();
    }

    return Column(
      children: [
        // Search and Filter Bar
        _buildSearchAndFilterBar(),

        // Content
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              // Stats header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).extension<CustomColors>()!.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).extension<CustomColors>()!.greenAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.book,
                        color: Theme.of(context).extension<CustomColors>()!.green,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '34/365',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).extension<CustomColors>()!.primary,
                            ),
                          ),
                          Text(
                            'Journals this year',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).extension<CustomColors>()!.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Recent entries
              Text(
                'Recent Entries',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).extension<CustomColors>()!.primary,
                ),
              ),
              const SizedBox(height: 16),

              // Sample journal entries
              JournalEntryCard(
                title: 'I\'m grateful for my life. Truly',
                preview: 'Today, I just had a revelation. It was that simple moments...',
                mood: 'Happy',
                moodColor: Theme.of(context).extension<CustomColors>()!.green,
                date: 'Today',
                type: JournalType.text,
                onTap: () {},
              ).animateCardEntrance(index: 0),

              const SizedBox(height: 12),

              JournalEntryCard(
                title: 'Feeling overwhelmed',
                preview: 'Work has been really stressful lately. I need to find...',
                mood: 'Anxious',
                moodColor: Theme.of(context).extension<CustomColors>()!.orange,
                date: 'Yesterday',
                type: JournalType.voice,
                onTap: () {},
              ).animateCardEntrance(index: 1),

              const SizedBox(height: 12),

              JournalEntryCard(
                title: 'A peaceful morning',
                preview: 'Woke up early and went for a walk. The sunrise was...',
                mood: 'Calm',
                moodColor: Theme.of(context).extension<CustomColors>()!.violet,
                date: '2 days ago',
                type: JournalType.text,
                onTap: () {},
              ).animateCardEntrance(index: 2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    final colors = Theme.of(context).extension<CustomColors>()!;
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // Stats header skeleton
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: colors.onPrimaryContainer.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.book,
                  color: colors.onPrimaryContainer.withOpacity(0.3),
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 24,
                      decoration: BoxDecoration(
                        color: colors.onPrimaryContainer.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 120,
                      height: 16,
                      decoration: BoxDecoration(
                        color: colors.onPrimaryContainer.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Recent entries title skeleton
        Container(
          width: 140,
          height: 24,
          decoration: BoxDecoration(
            color: colors.onPrimaryContainer.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 16),

        // Journal entry skeletons
        ...List.generate(3, (index) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: colors.onPrimaryContainer.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: colors.onPrimaryContainer.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                height: 16,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colors.onPrimaryContainer.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 16,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  color: colors.onPrimaryContainer.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildEmptyHistoryState() {
    final colors = Theme.of(context).extension<CustomColors>()!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: colors.greenAccent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.book_outlined,
                color: colors.green,
                size: 60,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Start your journaling journey',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Your journal entries will appear here. Start by writing your first entry to begin tracking your thoughts and feelings.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colors.onPrimaryContainer,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Vibration.vibrate(duration: 50);
                _startTextJournal(context);
              },
              icon: const Icon(Icons.add),
              label: const Text('Write Your First Entry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.green,
                foregroundColor: colors.primaryContainer,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNewEntryDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'New Journal Entry',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildEntryTypeButton(
                    context,
                    'Voice',
                    Icons.mic,
                    const Color(0xFF9BB068),
                    () {
                      Navigator.pop(context);
                      _startVoiceJournal(context);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildEntryTypeButton(
                    context,
                    'Text',
                    Icons.edit,
                    const Color(0xFFA18EFF),
                    () {
                      Navigator.pop(context);
                      _startTextJournal(context);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildEntryTypeButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startVoiceJournal(BuildContext context) {
    Navigator.pushNamed(
      context,
      NavigationManager.voiceJournalingScreen,
    );
  }

  void _startTextJournal(BuildContext context) {
    Navigator.pushNamed(
      context,
      NavigationManager.textJournalEditorScreen,
    );
  }

  void _startTextJournalWithPrompt(String prompt) {
    Navigator.pushNamed(
      context,
      NavigationManager.textJournalEditorScreen,
      arguments: {
        'initialPrompt': prompt,
      },
    );
  }

  Widget _buildSearchAndFilterBar() {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>()!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: colors.onPrimaryContainer.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Search bar
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search journal entries...',
              prefixIcon: Icon(
                Icons.search,
                color: colors.onPrimaryContainer.withOpacity(0.6),
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: colors.onPrimaryContainer.withOpacity(0.6),
                      ),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: colors.onPrimaryContainer.withOpacity(0.2),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: colors.onPrimaryContainer.withOpacity(0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: colors.primary,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: colors.primaryContainer.withOpacity(0.3),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),

          const SizedBox(height: 12),

          // Filter toggle and active filters
          Row(
            children: [
              // Filter toggle button
              TextButton.icon(
                onPressed: () {
                  setState(() => _showFilters = !_showFilters);
                },
                icon: Icon(
                  _showFilters ? Icons.filter_list_off : Icons.filter_list,
                  color: colors.primary,
                ),
                label: Text(
                  'Filters',
                  style: TextStyle(
                    color: colors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: colors.primary.withOpacity(0.3),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Active filter indicators
              if (_selectedMoodFilter != 'All')
                Chip(
                  label: Text(
                    _selectedMoodFilter,
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 12,
                    ),
                  ),
                  deleteIcon: Icon(
                    Icons.close,
                    size: 16,
                    color: colors.primary,
                  ),
                  onDeleted: () {
                    setState(() => _selectedMoodFilter = 'All');
                  },
                  backgroundColor: colors.primaryContainer.withOpacity(0.5),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),

              if (_startDate != null || _endDate != null)
                Chip(
                  label: Text(
                    'Date Range',
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 12,
                    ),
                  ),
                  deleteIcon: Icon(
                    Icons.close,
                    size: 16,
                    color: colors.primary,
                  ),
                  onDeleted: () {
                    setState(() {
                      _startDate = null;
                      _endDate = null;
                    });
                  },
                  backgroundColor: colors.primaryContainer.withOpacity(0.5),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),

              // Clear all filters
              if (_selectedMoodFilter != 'All' || _startDate != null || _endDate != null)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedMoodFilter = 'All';
                      _startDate = null;
                      _endDate = null;
                      _searchController.clear();
                    });
                  },
                  child: Text(
                    'Clear All',
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),

          // Expanded filters
          if (_showFilters)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: _showFilters ? null : 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Mood filter
                  Text(
                    'Filter by Mood',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      'All',
                      'Happy',
                      'Sad',
                      'Anxious',
                      'Calm',
                      'Angry',
                      'Excited',
                    ].map((mood) {
                      final isSelected = _selectedMoodFilter == mood;
                      return FilterChip(
                        label: Text(
                          mood,
                          style: TextStyle(
                            color: isSelected ? colors.primaryContainer : colors.primary,
                            fontSize: 12,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedMoodFilter = selected ? mood : 'All';
                          });
                        },
                        backgroundColor: colors.primaryContainer.withOpacity(0.3),
                        selectedColor: colors.primary,
                        checkmarkColor: colors.primaryContainer,
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16),

                  // Date range filter
                  Text(
                    'Filter by Date',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: _startDate ?? DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) {
                              setState(() => _startDate = picked);
                            }
                          },
                          icon: Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: colors.primary,
                          ),
                          label: Text(
                            _startDate != null
                                ? '${_startDate!.month}/${_startDate!.day}/${_startDate!.year}'
                                : 'Start Date',
                            style: TextStyle(
                              color: colors.primary,
                              fontSize: 12,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            side: BorderSide(
                              color: colors.primary.withOpacity(0.3),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: _endDate ?? DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) {
                              setState(() => _endDate = picked);
                            }
                          },
                          icon: Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: colors.primary,
                          ),
                          label: Text(
                            _endDate != null
                                ? '${_endDate!.month}/${_endDate!.day}/${_endDate!.year}'
                                : 'End Date',
                            style: TextStyle(
                              color: colors.primary,
                              fontSize: 12,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            side: BorderSide(
                              color: colors.primary.withOpacity(0.3),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
