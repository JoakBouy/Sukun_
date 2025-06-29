import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/seventh_page/widgets/yes_no_card.dart';

class SeventhPage extends StatefulWidget {
  const SeventhPage({super.key});

  @override
  State<SeventhPage> createState() => _SeventhPageState();
}

class _SeventhPageState extends State<SeventhPage> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        YesNoCard(
          onTap: (_) => setState(() => selected = !selected),
          selected: selected,
          title: StringsManager.yesCardTitle,
          subtitle: StringsManager.yesCardSubtitle,
          icon: Theme.of(context).extension<CustomAssets>()!.yes,
        ),
        YesNoCard(
          onTap: (_) => setState(() => selected = !selected),
          selected: !selected,
          title: StringsManager.noCardTitle,
          subtitle: StringsManager.noCardSubtitle,
          icon: Theme.of(context).extension<CustomAssets>()!.no,
        ),
      ],
    );
  }
}
