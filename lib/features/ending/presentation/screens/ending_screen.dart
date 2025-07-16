import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freud_ai/core/managers/custom_assets.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/navigation_manager.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';
import 'package:freud_ai/core/widgets/custom_button.dart';
import 'package:vector_graphics/vector_graphics.dart';

class EndingScreen extends StatelessWidget {
  const EndingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.extension<CustomColors>()!.orange,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SizesManager.padding,
            ),
            child: SizedBox(
              width: 600,
              child: Column(
                spacing: 40,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture(
                    AssetBytesLoader(
                      theme.extension<CustomAssets>()!.iconWhite,
                    ),
                  ),
                  Text(
                    '\"This was my try at Freud AI UI kit Implementation, I hope you enjoyed it, Thank you for trying it 🫶\"',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '- MOAZ SALEM',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: SizesManager.bottomSheetButtonPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                text: "Go Back To Start",
                color: theme.extension<CustomColors>()!.orangeAccent,
                textColor: theme.colorScheme.onSurface,
                icon: "",
                onPressed:
                    () => Navigator.popUntil(
                      context,
                      ModalRoute.withName(NavigationManager.onboardingScreen),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
