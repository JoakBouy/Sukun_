import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/widgets/custom_button.dart';

class MoodTrackingScreen extends StatefulWidget {
  const MoodTrackingScreen({super.key});

  @override
  State<MoodTrackingScreen> createState() => _MoodTrackingScreenState();
}

class _MoodTrackingScreenState extends State<MoodTrackingScreen> {
  String? _selectedMood;
  final TextEditingController _noteController = TextEditingController();

  final List<Map<String, dynamic>> _moods = [
    {'emoji': '😊', 'label': 'Great', 'color': Colors.green},
    {'emoji': '🙂', 'label': 'Good', 'color': Colors.lightGreen},
    {'emoji': '😐', 'label': 'Okay', 'color': Colors.yellow},
    {'emoji': '😔', 'label': 'Down', 'color': Colors.orange},
    {'emoji': '😢', 'label': 'Very Low', 'color': Colors.red},
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _saveMood() {
    if (_selectedMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a mood')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mood saved successfully')),
    );
    setState(() {
      _selectedMood = null;
      _noteController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final CustomColors colors = theme.extension<CustomColors>()!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsManager.moodTitle),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Navigate to mood history
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(SizesManager.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              StringsManager.howAreYouFeeling,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: SizesManager.hPadding),
            Text(
              StringsManager.selectMood,
              style: theme.textTheme.titleMedium?.copyWith(
                color: colors.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: SizesManager.dPadding),
            // Mood Selector
            Wrap(
              spacing: SizesManager.padding,
              runSpacing: SizesManager.padding,
              alignment: WrapAlignment.center,
              children: _moods.map((mood) {
                final isSelected = _selectedMood == mood['label'];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedMood = mood['label'];
                    });
                  },
                  child: Container(
                    width: 80,
                    height: 100,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (mood['color'] as Color).withOpacity(0.2)
                          : colors.background,
                      borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
                      border: Border.all(
                        color: isSelected ? mood['color'] as Color : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          mood['emoji'],
                          style: const TextStyle(fontSize: 32),
                        ),
                        const SizedBox(height: SizesManager.tinyPadding),
                        Text(
                          mood['label'],
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: isSelected ? mood['color'] as Color : colors.onBackground,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: SizesManager.dPadding),
            // Note Input
            TextField(
              controller: _noteController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: StringsManager.addNote,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
                ),
                filled: true,
                fillColor: colors.background,
              ),
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: SizesManager.dPadding),
            // Save Button
            CustomButton(
              text: StringsManager.saveMood,
              onPressed: _saveMood,
              icon: '',
            ),
            const SizedBox(height: SizesManager.dPadding),
            // Mood History Chart Placeholder
            Card(
              child: Padding(
                padding: const EdgeInsets.all(SizesManager.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringsManager.moodHistory,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: SizesManager.padding),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: colors.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Mood chart will appear here',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

