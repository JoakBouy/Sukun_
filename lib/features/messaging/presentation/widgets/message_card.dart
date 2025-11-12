import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class MessageCard extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;

  const MessageCard({
    super.key,
    required this.message,
    this.isMe = false,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final CustomColors colors = theme.extension<CustomColors>()!;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: SizesManager.hPadding),
        padding: const EdgeInsets.symmetric(
          horizontal: SizesManager.padding,
          vertical: SizesManager.hPadding,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isMe ? colors.primary : colors.background,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isMe ? Colors.white : colors.onBackground,
              ),
            ),
            const SizedBox(height: SizesManager.tinyPadding),
            Text(
              time,
              style: theme.textTheme.labelSmall?.copyWith(
                color: isMe ? Colors.white70 : colors.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

