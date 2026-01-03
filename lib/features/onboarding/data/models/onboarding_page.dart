import 'package:flutter/material.dart';

class OnboardingPageModel {
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;
  final List<String>? features;

  const OnboardingPageModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
    this.features,
  });
}
