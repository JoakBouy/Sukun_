import 'package:flutter/material.dart';
import 'package:freud_ai/core/helpers/page_view_helper.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key, required this.index});
  final int index;
  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SizesManager.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  textAlign: TextAlign.center,
                  PageViewHelper.getTitle(widget.index),
                  style: theme.textTheme.titleLarge,
                ),
              ),
              if (![13, 14].contains(widget.index))
                SizedBox(height: SizesManager.dhPadding),
              PageViewHelper.getPage(widget.index),
            ],
          ),
        ),
      ),
    );
  }
}
