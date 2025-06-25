import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';

class WeightScrollingWidget extends StatefulWidget {
  const WeightScrollingWidget({super.key, required this.isLbs});
  final bool isLbs;

  @override
  State<WeightScrollingWidget> createState() => _WeightScrollingWidgetState();
}

class _WeightScrollingWidgetState extends State<WeightScrollingWidget> {
  final CarouselController _scrollController = CarouselController(
    initialItem: 60,
  );
  int currentWeight = 60;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 2,
            children: [
              Text(
                "$currentWeight",
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontSize: 110, height: 0.83),
              ),
              Text(
                widget.isLbs ? "lbs" : "kg",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 36,
                ),
              ),
            ],
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200, maxWidth: 400),
          child: CarouselView.weighted(
            controller: _scrollController,
            itemSnapping: true,
            enableSplash: false,
            padding: const EdgeInsets.all(0),
            flexWeights: _flexWeights,
            children: List.generate(widget.isLbs ? 661 : 301, (index) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  bool isDivisible = index % 5 == 0;
                  bool isMiddle = constraints.maxWidth > 24;
                  isMiddle ? currentWeight = index : null;
                  return Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical:
                              isMiddle
                                  ? 20
                                  : isDivisible
                                  ? 70
                                  : 85,
                          horizontal: isDivisible ? 0 : 2,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth:
                                isMiddle
                                    ? 26
                                    : isDivisible
                                    ? 9
                                    : 4,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    isMiddle
                                        ? theme
                                            .extension<CustomColors>()!
                                            .greenAccent
                                        : Colors.transparent,

                                width: 6,
                              ),
                              color:
                                  isMiddle
                                      ? theme.extension<CustomColors>()!.green
                                      : theme.colorScheme.primary.withAlpha(
                                        isDivisible ? 120 : 60,
                                      ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                      if (isDivisible && !isMiddle)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15, left: 20),
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: OverflowBox(
                              alignment: Alignment.bottomLeft,
                              maxWidth: 60,
                              maxHeight: 100,
                              child: Text(
                                "$index",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.primary.withAlpha(
                                    120,
                                  ),
                                  fontSize: 18,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              );
            }),
          ),
        ),
      ],
    );
  }
}

final List<int> _flexWeights = [
  ...List.filled(11, 1),
  2,
  ...List.filled(11, 1),
];
