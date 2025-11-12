import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/widgets/custom_button.dart';

class VoiceJournalingScreen extends StatefulWidget {
  const VoiceJournalingScreen({super.key});

  @override
  State<VoiceJournalingScreen> createState() => _VoiceJournalingScreenState();
}

class _VoiceJournalingScreenState extends State<VoiceJournalingScreen> {
  bool _isRecording = false;
  final TextEditingController _textController = TextEditingController();
  String _transcribedText = '';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
      if (!_isRecording) {
        // Simulate transcription
        _transcribedText = 'This is a placeholder for transcribed text. In a real implementation, this would contain the voice-to-text transcription.';
        _textController.text = _transcribedText;
      } else {
        _transcribedText = '';
        _textController.clear();
      }
    });
  }

  void _saveJournal() {
    if (_textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add some content to your journal entry')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Journal entry saved successfully')),
    );
    // Clear the text after saving
    _textController.clear();
    setState(() {
      _transcribedText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final CustomColors colors = theme.extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsManager.journalTitle),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(SizesManager.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              StringsManager.journalSubtitle,
              style: theme.textTheme.titleMedium?.copyWith(
                color: colors.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: SizesManager.dPadding),
            // Recording Button
            Center(
              child: GestureDetector(
                onTap: _toggleRecording,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: _isRecording ? Colors.red : colors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (_isRecording ? Colors.red : colors.primary).withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    _isRecording ? Icons.stop : Icons.mic,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),
            ),
            const SizedBox(height: SizesManager.padding),
            Center(
              child: Text(
                _isRecording ? StringsManager.recording : StringsManager.tapToStart,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: colors.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(height: SizesManager.dPadding),
            // Text Editor
            TextField(
              controller: _textController,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Your thoughts will appear here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
                ),
                filled: true,
                fillColor: colors.background,
              ),
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: SizesManager.padding),
            // AI Insights Section
            if (_textController.text.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(SizesManager.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.auto_awesome, color: colors.violet),
                          const SizedBox(width: SizesManager.hPadding),
                          Text(
                            StringsManager.aiInsights,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: SizesManager.hPadding),
                      Text(
                        'AI-powered insights will appear here based on your journal entry.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: SizesManager.dPadding),
            // Save Button
            CustomButton(
              text: StringsManager.saveJournal,
              onPressed: _saveJournal,
              icon: '',
            ),
          ],
        ),
      ),
    );
  }
}

