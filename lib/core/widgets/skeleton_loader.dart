import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/utils/animation_constants.dart';

/// Reusable skeleton loader widget with shimmer effect
class SkeletonLoader extends StatelessWidget {
  final SkeletonType type;
  final double? width;
  final double? height;
  final int count;

  const SkeletonLoader({
    super.key,
    required this.type,
    this.width,
    this.height,
    this.count = 1,
  });

  /// Card skeleton loader
  const SkeletonLoader.card({
    super.key,
    this.width,
    this.height = 120,
  })  : type = SkeletonType.card,
        count = 1;

  /// List item skeleton loader
  const SkeletonLoader.listItem({
    super.key,
    this.width,
    this.height = 80,
    this.count = 3,
  }) : type = SkeletonType.listItem;

  /// Text line skeleton loader
  const SkeletonLoader.text({
    super.key,
    this.width,
    this.height = 16,
    this.count = 1,
  }) : type = SkeletonType.text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    return Column(
      children: List.generate(
        count,
        (index) => Padding(
          padding: EdgeInsets.only(
            bottom: index < count - 1 ? SizesManager.padding : 0,
          ),
          child: _buildSkeletonItem(colors),
        ),
      ),
    );
  }

  Widget _buildSkeletonItem(CustomColors colors) {
    switch (type) {
      case SkeletonType.card:
        return _buildCardSkeleton(colors);
      case SkeletonType.listItem:
        return _buildListItemSkeleton(colors);
      case SkeletonType.text:
        return _buildTextSkeleton(colors);
    }
  }

  Widget _buildCardSkeleton(CustomColors colors) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: SizesManager.padding),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(SizesManager.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _shimmerBox(
              width: 120,
              height: 20,
              colors: colors,
            ),
            const SizedBox(height: SizesManager.hPadding),
            _shimmerBox(
              width: double.infinity,
              height: 14,
              colors: colors,
            ),
            const SizedBox(height: SizesManager.hPadding),
            _shimmerBox(
              width: 200,
              height: 14,
              colors: colors,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItemSkeleton(CustomColors colors) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: SizesManager.padding),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(SizesManager.cardCircularBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(SizesManager.padding),
        child: Row(
          children: [
            _shimmerBox(
              width: 48,
              height: 48,
              colors: colors,
              borderRadius: 24,
            ),
            const SizedBox(width: SizesManager.vPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _shimmerBox(
                    width: 150,
                    height: 16,
                    colors: colors,
                  ),
                  const SizedBox(height: SizesManager.hPadding),
                  _shimmerBox(
                    width: 100,
                    height: 12,
                    colors: colors,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextSkeleton(CustomColors colors) {
    return _shimmerBox(
      width: width ?? double.infinity,
      height: height ?? 16,
      colors: colors,
    );
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    required CustomColors colors,
    double? borderRadius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colors.onPrimaryContainer.withOpacity(0.1),
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
      ),
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .shimmer(
          duration: Duration(milliseconds: AnimationConstants.shimmerDuration),
          color: colors.primary.withOpacity(0.1),
        );
  }
}

/// Skeleton type enum
enum SkeletonType {
  card,
  listItem,
  text,
}
