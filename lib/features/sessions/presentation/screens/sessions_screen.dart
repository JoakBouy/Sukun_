import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/core/widgets/custom_button.dart';
import 'package:freud_ai/features/sessions/presentation/widgets/session_card.dart';

class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key});

  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> with SingleTickerProviderStateMixin {
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
        title: const Text(StringsManager.sessionsTitle),
        elevation: 0,
        backgroundColor: Colors.transparent,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: StringsManager.upcomingSessions),
            Tab(text: StringsManager.pastSessions),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Upcoming Sessions
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(SizesManager.padding),
                  itemCount: 3, // Mock data
                  itemBuilder: (context, index) {
                    return SessionCard(
                      therapistName: 'Dr. Sarah Johnson',
                      date: 'March ${15 + index}, 2024',
                      time: '${10 + index}:00 AM',
                      type: index % 2 == 0 ? StringsManager.virtualSession : StringsManager.inPersonSession,
                      isUpcoming: true,
                      onTap: () {
                        // Navigate to session details
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(SizesManager.padding),
                child: CustomButton(
                  text: StringsManager.bookNewSession,
                  onPressed: () {
                    // Navigate to book session
                  },
                  icon: '',
                ),
              ),
            ],
          ),
          // Past Sessions
          ListView.builder(
            padding: const EdgeInsets.all(SizesManager.padding),
            itemCount: 5, // Mock data
            itemBuilder: (context, index) {
              return SessionCard(
                therapistName: 'Dr. Michael Chen',
                date: 'March ${10 - index}, 2024',
                time: '${2 + index}:00 PM',
                type: index % 2 == 0 ? StringsManager.virtualSession : StringsManager.inPersonSession,
                isUpcoming: false,
                onTap: () {
                  // Navigate to session details
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

