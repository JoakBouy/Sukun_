import 'package:flutter/material.dart';
import 'package:freud_ai/core/widgets/ref/ref_header.dart';
import 'package:freud_ai/features/community/presentation/widgets/community_post_card.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RefHeader(
        title: 'Community',
        onBack: () => Navigator.of(context).pop(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          CommunityPostCard(
            userName: 'Sarah Johnson',
            userImage: 'https://placehold.co/100x100',
            timeAgo: '2 hours ago',
            content: 'Just finished my first week of daily meditation! Feeling so much more centered and calm. Highly recommend starting with just 5 minutes a day.',
            tags: ['meditation', 'mindfulness', 'growth'],
            likes: 24,
            comments: 5,
            isVerified: true,
          ),
          CommunityPostCard(
            userName: 'Michael Chen',
            userImage: 'https://placehold.co/100x100',
            timeAgo: '5 hours ago',
            content: 'Does anyone have tips for dealing with anxiety before public speaking? I have a big presentation coming up next week.',
            tags: ['anxiety', 'advice', 'support'],
            likes: 12,
            comments: 8,
          ),
          CommunityPostCard(
            userName: 'Emma Davis',
            userImage: 'https://placehold.co/100x100',
            timeAgo: '1 day ago',
            content: 'The new breathing exercises in the app are amazing. Really helped me sleep better last night.',
            tags: ['sleep', 'breathing', 'wellness'],
            likes: 45,
            comments: 12,
            isVerified: true,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        tooltip: 'Create post',
      ),
    );
  }
}
