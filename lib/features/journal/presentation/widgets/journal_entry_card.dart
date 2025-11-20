import 'package:flutter/material.dart';

enum JournalType { text, voice }

class JournalEntryCard extends StatefulWidget {
  final String title;
  final String preview;
  final String mood;
  final Color moodColor;
  final String date;
  final JournalType type;
  final VoidCallback onTap;

  const JournalEntryCard({
    super.key,
    required this.title,
    required this.preview,
    required this.mood,
    required this.moodColor,
    required this.date,
    required this.type,
    required this.onTap,
  });

  @override
  State<JournalEntryCard> createState() => _JournalEntryCardState();
}

class _JournalEntryCardState extends State<JournalEntryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: 8.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
    widget.onTap.call();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value / 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with type icon and date
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: widget.moodColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.type == JournalType.voice ? Icons.mic : Icons.edit,
                          color: widget.moodColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4B3425),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: widget.moodColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'MOOD: ${widget.mood.toUpperCase()}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: widget.moodColor,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  widget.date,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF7A6F5C),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      AnimatedRotation(
                        turns: _isPressed ? 0.125 : 0.0,
                        duration: const Duration(milliseconds: 150),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFD4C1B9),
                          size: 16,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Preview text
                  Text(
                    widget.preview,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF7A6F5C),
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),

                  // Type indicator
                  Row(
                    children: [
                      Icon(
                        widget.type == JournalType.voice ? Icons.mic : Icons.text_fields,
                        size: 14,
                        color: const Color(0xFF7A6F5C),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.type == JournalType.voice ? 'Voice Entry' : 'Text Entry',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF7A6F5C),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
