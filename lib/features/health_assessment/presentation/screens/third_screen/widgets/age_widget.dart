import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';

class AgeWidget extends StatelessWidget {
  const AgeWidget({super.key, required this.controller});
  final CarouselController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      width: 450,
      child: CarouselView.weighted(
        controller: controller,
        scrollDirection: Axis.vertical,
        flexWeights: [2, 3, 7, 3, 2],
        itemSnapping: true,
        backgroundColor: Colors.transparent,
        enableSplash: false,
        children: List<Widget>.generate(
          100,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return constraints.maxHeight > 108
                    ? Card(
                      margin: const EdgeInsets.symmetric(horizontal: 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                        side: BorderSide(
                          color: Theme.of(
                            context,
                          ).extension<CustomColors>()!.green.withAlpha(80),
                          width: 4,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                      elevation: 0,
                      color: Theme.of(context).extension<CustomColors>()!.green,
                      child: Center(
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(
                            fontSize: 130,
                            fontWeight: FontWeight.w900,
                            height: 0.6,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                    : Transform.scale(
                      scale: 1.4,
                      child: Center(
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(
                            fontSize: (constraints.maxHeight / 1.2).clamp(
                              28,
                              85,
                            ),
                            fontWeight: FontWeight.w900,
                            height: 0.8,
                            color: Theme.of(
                              context,
                            ).colorScheme.secondary.withAlpha(
                              (constraints.maxHeight / 0.6).toInt().clamp(
                                0,
                                255,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
              },
            ),
          ),
        ),
      ),
    );
  }
}
