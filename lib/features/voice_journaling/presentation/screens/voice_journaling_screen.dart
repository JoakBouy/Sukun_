import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/widgets/custom_button.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/widgets/reusable_animation.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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
            // Recording UI based on ThirteenthPage
            Center(
              child: GestureDetector(
                onTap: _toggleRecording,
                child: Column(
                  children: [
                    Text(
                      _isRecording ? 'Listening...' : 'Tap to Record',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 236,
                      height: 236,
                      child: _isRecording
                          ? ReusableAnimation(
                              assetPath: theme.extension<CustomAssets>()!.page13,
                              fit: BoxFit.contain,
                            )
                              .animate(onPlay: (controller) => controller.repeat(reverse: true))
                              .scaleXY(end: 1.05, duration: 1000.ms)
                          : ReusableAnimation(
                              assetPath: theme.extension<CustomAssets>()!.page13,
                              fit: BoxFit.contain,
                            ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Record/Stop Button
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      decoration: ShapeDecoration(
                        color: _isRecording ? Colors.red.shade400 : theme.extension<CustomColors>()!.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        shadows: [
                          BoxShadow(
                            color: (_isRecording ? Colors.red : theme.extension<CustomColors>()!.orange).withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _isRecording ? Icons.stop_rounded : Icons.mic_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _isRecording ? 'Stop Recording' : 'Start Recording',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ).animate(target: _isRecording ? 1 : 0)
                     .shimmer(duration: 1500.ms, color: Colors.white.withOpacity(0.2)),
                  ],
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

