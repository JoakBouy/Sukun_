import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/widgets/ref/ref_header.dart';

class AiChatbotScreen extends StatefulWidget {
  const AiChatbotScreen({super.key});

  @override
  State<AiChatbotScreen> createState() => _AiChatbotScreenState();
}

class _AiChatbotScreenState extends State<AiChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  final List<Map<String, dynamic>> _messages = [];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'message': _controller.text,
        'isUser': true,
        'timestamp': _formatTime(DateTime.now()),
      });
      _controller.clear();
      _isTyping = true;
    });

    _scrollToBottom();

    // Simulate AI response
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add({
            'message': _getAiResponse(),
            'isUser': false,
            'timestamp': _formatTime(DateTime.now()),
          });
        });
        _scrollToBottom();
      }
    });
  }

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
  }

  String _getAiResponse() {
    final responses = [
      "I understand how you're feeling. It's completely normal to experience these emotions.",
      "Thank you for sharing that with me. Would you like to explore some coping strategies?",
      "I'm here to listen. Take your time and tell me more about what's on your mind.",
      "That sounds challenging. Remember, it's okay to take things one step at a time.",
      "Your feelings are valid. Let's work through this together.",
    ];
    return responses[DateTime.now().second % responses.length];
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: RefHeader(
        title: 'Dr. Freud AI',
        onBack: () => Navigator.of(context).pop(),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? _buildEmptyState(colors)
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length + (_isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _messages.length && _isTyping) {
                        return _buildTypingIndicator(colors);
                      }
                      final msg = _messages[index];
                      return _buildMessageBubble(msg, colors, index);
                    },
                  ),
          ),
          _buildInputBar(colors),
        ],
      ),
    );
  }

  Widget _buildEmptyState(CustomColors colors) {
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
                gradient: LinearGradient(
                  colors: [colors.orange.withOpacity(0.2), colors.orange.withOpacity(0.1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.psychology,
                size: 60,
                color: colors.orange,
              ),
            ).animate().scale(duration: const Duration(milliseconds: 600), curve: Curves.elasticOut),
            const SizedBox(height: 32),
            Text(
              'Talk to Dr. Freud AI',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: colors.primary,
                fontFamily: 'urbanist',
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 200)),
            const SizedBox(height: 12),
            Text(
              'Start a new conversation and get supportive guidance for your mental wellness journey.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: colors.onBackground.withOpacity(0.6),
                fontFamily: 'urbanist',
                height: 1.5,
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 400)),
            const SizedBox(height: 32),
            // Quick prompts
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _buildQuickPrompt('I feel anxious', colors),
                _buildQuickPrompt('Help me relax', colors),
                _buildQuickPrompt('I need motivation', colors),
              ],
            ).animate().fadeIn(delay: const Duration(milliseconds: 600)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickPrompt(String text, CustomColors colors) {
    return GestureDetector(
      onTap: () {
        _controller.text = text;
        _sendMessage();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: colors.orange.withOpacity(0.3)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colors.primary,
            fontFamily: 'urbanist',
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> msg, CustomColors colors, int index) {
    final isUser = msg['isUser'] as bool;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser)
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colors.orange, colors.orange.withOpacity(0.8)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.psychology, size: 18, color: Colors.white),
            ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: isUser
                    ? LinearGradient(
                        colors: [colors.orange, colors.orange.withOpacity(0.9)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isUser ? null : colors.primaryContainer,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isUser ? 20 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isUser ? colors.orange : Colors.black).withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    msg['message'],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: isUser ? Colors.white : colors.primary,
                      fontFamily: 'urbanist',
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    msg['timestamp'],
                    style: TextStyle(
                      fontSize: 11,
                      color: (isUser ? Colors.white : colors.onBackground).withOpacity(0.6),
                      fontFamily: 'urbanist',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ).animate().fadeIn(duration: const Duration(milliseconds: 300)).slideX(
            begin: isUser ? 0.1 : -0.1,
            curve: Curves.easeOut,
          ),
    );
  }

  Widget _buildTypingIndicator(CustomColors colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colors.orange, colors.orange.withOpacity(0.8)],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.psychology, size: 18, color: Colors.white),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: colors.grey,
                    shape: BoxShape.circle,
                  ),
                ).animate(
                  onPlay: (controller) => controller.repeat(),
                ).fadeIn(
                  delay: Duration(milliseconds: index * 200),
                  duration: const Duration(milliseconds: 400),
                ).fadeOut(
                  delay: Duration(milliseconds: 600 + index * 200),
                  duration: const Duration(milliseconds: 400),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar(CustomColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                      color: colors.grey,
                      fontFamily: 'urbanist',
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'urbanist',
                    color: colors.primary,
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.orange, colors.orange.withOpacity(0.8)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: colors.orange.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
