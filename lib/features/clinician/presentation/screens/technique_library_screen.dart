import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

/// CBT and evidence-based therapy technique library for Primetel counsellors.
/// Fully offline — no network required.
class TechniqueLibraryScreen extends StatefulWidget {
  const TechniqueLibraryScreen({super.key});
  @override
  State<TechniqueLibraryScreen> createState() => _TechniqueLibraryScreenState();
}

class _TechniqueLibraryScreenState extends State<TechniqueLibraryScreen> {
  String _searchQuery = '';
  String _filter = 'All';

  final _techniques = [
    _Technique('Thought Records', 'CBT', 'Depression, Anxiety',
      'Help the client identify automatic thoughts, examine the evidence for and against them, and develop a balanced alternative thought.\n\n1. Identify the triggering situation\n2. Record the automatic thought\n3. Rate emotion intensity (0–100%)\n4. Examine evidence for the thought\n5. Examine evidence against the thought\n6. Develop balanced alternative thought\n7. Re-rate emotion intensity',
      Icons.edit_note, Color(0xFFC82828)),
    _Technique('Behavioural Activation', 'CBT', 'Depression',
      'Schedule and engage in pleasurable and meaningful activities to counteract the inactivity-depression cycle.\n\n1. Help client identify activities they used to enjoy\n2. Rate current mood (0–10)\n3. Plan one small activity for this week\n4. Review completion and mood change at next session\n5. Gradually increase activity range',
      Icons.directions_walk, Color(0xFF9BB068)),
    _Technique('Progressive Muscle Relaxation', 'Relaxation', 'Anxiety, Stress',
      'Tension-release exercise for reducing physical anxiety symptoms.\n\nInstructions to read aloud:\n"Tense each muscle group for 5 seconds, then release for 30 seconds. Start with feet, move upward through the body: calves, thighs, abdomen, hands, arms, shoulders, face."\n\nDuration: 15–20 minutes. Best done in a quiet seated position.',
      Icons.self_improvement, Color(0xFFED7E1C)),
    _Technique('Grounding — 5-4-3-2-1', 'Trauma', 'PTSD, Dissociation, Panic',
      'Sensory grounding technique to anchor client to the present moment during flashbacks or panic.\n\nSay to client:\n"Name 5 things you can SEE right now.\nName 4 things you can TOUCH.\nName 3 things you can HEAR.\nName 2 things you can SMELL.\nName 1 thing you can TASTE."\n\nRepeat until client reports feeling grounded.',
      Icons.anchor, Color(0xFFFFBD1A)),
    _Technique('Motivational Interviewing — OARS', 'MI', 'Substance use, Behaviour change',
      'Core MI communication skills:\n\nO — Open questions: "What brings you here today?"\nA — Affirmations: "It takes courage to come and talk about this."\nR — Reflective listening: "It sounds like you\'re feeling overwhelmed..."\nS — Summaries: "Let me check I\'ve understood you correctly..."\n\nAvoid confrontation. Roll with resistance. Support self-efficacy.',
      Icons.forum, Color(0xFFA694F5)),
    _Technique('Narrative Therapy — Externalizing', 'Narrative', 'Trauma, Depression, Self-esteem',
      'Separate the person from the problem to reduce shame and open space for change.\n\nKey questions:\n"How long has depression been part of your life?"\n"When did anxiety first show up for you?"\n"What does the problem want you to believe about yourself?"\n"What does it say about you as a person that you\'ve managed to resist this?"\n\nFocus on unique outcomes — times the problem didn\'t win.',
      Icons.auto_stories, Color(0xFF0B7B6B)),
    _Technique('Safety Planning', 'Crisis', 'Suicidal ideation, Self-harm',
      'Stanley-Brown Collaborative Safety Planning:\n\n1. Warning signs (personal triggers)\n2. Internal coping strategies (what client can do alone)\n3. Social distractions (people/places)\n4. People to reach out to for support\n5. Professionals and crisis lines\n6. Means restriction (remove access to lethal means)\n\nComplete collaboratively. Review at each session.',
      Icons.shield, Color(0xFFB71C1C)),
    _Technique('Culturally Sensitive Language (Swahili)', 'Cultural', 'All presentations',
      'Common Swahili idioms of distress and culturally appropriate responses:\n\n• "Moyo wangu unasumbuka" (My heart is troubled) → Validate: "Naelewa, hii ni ngumu sana."\n• "Kichwa kinanisumbua" (My head troubles me) → Often somatic expression of depression\n• "Niko peke yangu" (I am alone) → Key risk factor for suicide\n• Avoid direct translation of "mental illness" — use "msongo wa mawazo" (stress/mental burden)\n• Traditional healer visits are common — avoid shaming, explore what help they received',
      Icons.language, Color(0xFF9BB068)),
    _Technique('Psychoeducation — Depression', 'Education', 'PHQ-9 Mild–Moderate',
      'Key messages to share with client:\n\n• Depression is a medical condition, not a sign of weakness\n• It affects how the brain works — not just mood\n• Common in Tanzania and worldwide\n• It responds well to talking therapy and sometimes medication\n• Physical symptoms (fatigue, poor sleep, appetite changes) are part of depression\n• Recovery is possible — most people get better with support\n\nUseful analogy: "Depression is like diabetes — it needs ongoing attention, not willpower."',
      Icons.info_outline, Color(0xFFED7E1C)),
    _Technique('Psychoeducation — Anxiety', 'Education', 'GAD-7 Mild–Moderate',
      'Key messages for anxiety:\n\n• Anxiety is the body\'s natural alarm system\n• It becomes a problem when the alarm goes off too often\n• Physical symptoms (racing heart, sweating, shaking) are not dangerous\n• Avoiding feared situations makes anxiety worse over time\n• Breathing slowly activates the parasympathetic nervous system\n\nTip: Teach 4-7-8 breathing:\nInhale for 4 counts, hold for 7, exhale for 8.',
      Icons.air, Color(0xFFA694F5)),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;
    final theme = Theme.of(context);

    final categories = ['All', 'CBT', 'Trauma', 'Crisis', 'Education', 'Cultural', 'Relaxation', 'MI', 'Narrative'];
    final filtered = _techniques.where((t) {
      final matchesSearch = t.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          t.description.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _filter == 'All' || t.category == _filter;
      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('CBT & Therapy Library', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0, backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'Search techniques...',
                prefixIcon: const Icon(Icons.search, color: CustomColors.primetelRed),
                filled: true, fillColor: colors.primaryContainer,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (_, i) {
                final c = categories[i];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(c),
                    selected: _filter == c,
                    onSelected: (_) => setState(() => _filter = c),
                    selectedColor: CustomColors.primetelRedLight,
                    checkmarkColor: CustomColors.primetelRed,
                    labelStyle: TextStyle(
                      color: _filter == c ? CustomColors.primetelRed : colors.onBackground,
                      fontWeight: _filter == c ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              itemBuilder: (ctx, i) => _buildCard(filtered[i], colors, theme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(_Technique t, CustomColors colors, ThemeData theme) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      collapsedBackgroundColor: colors.primaryContainer,
      backgroundColor: colors.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      leading: Container(
        width: 44, height: 44,
        decoration: BoxDecoration(color: t.color.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
        child: Icon(t.icon, color: t.color, size: 22),
      ),
      title: Text(t.name, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: colors.primary)),
      subtitle: Text('${t.category} · ${t.indication}',
          style: theme.textTheme.labelSmall?.copyWith(color: colors.onBackground.withOpacity(0.5))),
      trailing: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: t.color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Text(t.category, style: TextStyle(color: t.color, fontSize: 10, fontWeight: FontWeight.bold)),
        ),
      ),
      children: [
        Text(t.description, style: theme.textTheme.bodySmall?.copyWith(color: colors.onBackground, height: 1.7)),
      ],
    ).marginBottom(8, colors);
  }
}

extension on Widget {
  Widget marginBottom(double margin, CustomColors colors) {
    return Padding(
      padding: EdgeInsets.only(bottom: margin),
      child: this,
    );
  }
}

class _Technique {
  final String name;
  final String category;
  final String indication;
  final String description;
  final IconData icon;
  final Color color;
  const _Technique(this.name, this.category, this.indication, this.description, this.icon, this.color);
}
