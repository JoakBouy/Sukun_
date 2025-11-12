import 'package:flutter/material.dart';
import 'package:freud_ai/features/journal/presentation/widgets/journal_prompt_card.dart';
import 'package:freud_ai/features/journal/presentation/widgets/journal_entry_card.dart';
import 'package:freud_ai/features/journal/presentation/widgets/quick_action_button.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> with TickerProviderStateMixin {
  late TabController _tabController;

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
          labelColor: const Color(0xFF4B3425),
          unselectedLabelColor: const Color(0xFF7A6F5C),
          indicatorColor: const Color(0xFF9BB068),
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
        onPressed: () => _showNewEntryDialog(context),
        backgroundColor: const Color(0xFF9BB068),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildWriteTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // Welcome section
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF9BB068).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF9BB068).withOpacity(0.3),
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
                  color: const Color(0xFF4B3425),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Express your thoughts, feelings, and experiences. Choose how you want to journal today.',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xFF7A6F5C),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Quick actions
        Text(
          'Start Journaling',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF4B3425),
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
            color: const Color(0xFF4B3425),
          ),
        ),
        const SizedBox(height: 16),

        JournalPromptCard(
          prompt: 'What made you smile today?',
          category: 'Gratitude',
          color: const Color(0xFF9BB068),
          onTap: () => _startTextJournalWithPrompt('What made you smile today?'),
        ),

        const SizedBox(height: 12),

        JournalPromptCard(
          prompt: 'What\'s something you\'re looking forward to?',
          category: 'Hope',
          color: const Color(0xFFFFCE5B),
          onTap: () => _startTextJournalWithPrompt('What\'s something you\'re looking forward to?'),
        ),

        const SizedBox(height: 12),

        JournalPromptCard(
          prompt: 'How did you handle a challenge today?',
          category: 'Reflection',
          color: const Color(0xFFBDA193),
          onTap: () => _startTextJournalWithPrompt('How did you handle a challenge today?'),
        ),

        const SizedBox(height: 12),

        JournalPromptCard(
          prompt: 'What are you grateful for right now?',
          category: 'Gratitude',
          color: const Color(0xFFFE804B),
          onTap: () => _startTextJournalWithPrompt('What are you grateful for right now?'),
        ),
      ],
    );
  }

  Widget _buildHistoryTab() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // Stats header
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
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
                  color: const Color(0xFF9BB068).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.book,
                  color: Color(0xFF9BB068),
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
                        color: const Color(0xFF4B3425),
                      ),
                    ),
                    Text(
                      'Journals this year',
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color(0xFF7A6F5C),
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
            color: const Color(0xFF4B3425),
          ),
        ),
        const SizedBox(height: 16),

        // Sample journal entries
        JournalEntryCard(
          title: 'I\'m grateful for my life. Truly',
          preview: 'Today, I just had a revelation. It was that simple moments...',
          mood: 'Happy',
          moodColor: const Color(0xFF9BB068),
          date: 'Today',
          type: JournalType.text,
          onTap: () {},
        ),

        const SizedBox(height: 12),

        JournalEntryCard(
          title: 'Feeling overwhelmed',
          preview: 'Work has been really stressful lately. I need to find...',
          mood: 'Anxious',
          moodColor: const Color(0xFFFE804B),
          date: 'Yesterday',
          type: JournalType.voice,
          onTap: () {},
        ),

        const SizedBox(height: 12),

        JournalEntryCard(
          title: 'A peaceful morning',
          preview: 'Woke up early and went for a walk. The sunrise was...',
          mood: 'Calm',
          moodColor: const Color(0xFFA18EFF),
          date: '2 days ago',
          type: JournalType.text,
          onTap: () {},
        ),
      ],
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
    // TODO: Navigate to voice journal screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Voice journal coming soon!')),
    );
  }

  void _startTextJournal(BuildContext context) {
    // TODO: Navigate to text journal screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Text journal coming soon!')),
    );
  }

  void _startTextJournalWithPrompt(String prompt) {
    // TODO: Navigate to text journal with pre-filled prompt
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Journal with prompt: $prompt')),
    );
  }
}
