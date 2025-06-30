import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/strings_manager.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/ninth_page/data/models/grid_item_model.dart';
import 'package:freud_ai/features/health_assessment/presentation/widgets/ninth_page/widgets/grid_item.dart';

class NinthPage extends StatefulWidget {
  const NinthPage({super.key});

  @override
  State<NinthPage> createState() => _NinthPageState();
}

class _NinthPageState extends State<NinthPage> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<GridItemModel> gridItems = [
      GridItemModel(
        title: StringsManager.gridItem1,
        icon: theme.extension<CustomAssets>()!.gridIcon1,
      ),
      GridItemModel(
        title: StringsManager.gridItem2,
        icon: theme.extension<CustomAssets>()!.gridIcon2,
      ),
      GridItemModel(
        title: StringsManager.gridItem3,
        icon: theme.extension<CustomAssets>()!.gridIcon3,
      ),
      GridItemModel(
        title: StringsManager.gridItem4,
        icon: theme.extension<CustomAssets>()!.gridIcon4,
      ),
    ];
    return SizedBox(
      width: 400,
      height: 400,
      child: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          childAspectRatio: 1.0,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          ...List.generate(
            gridItems.length,
            (index) => GridItem(
              isSelected: selectedIndex == index,
              icon: gridItems[index].icon,
              title: gridItems[index].title,
              onTap: () => setState(() => selectedIndex = index),
              theme: theme,
            ),
          ),
        ],
      ),
    );
  }
}
