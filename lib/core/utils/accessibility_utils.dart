import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// Accessibility utilities for improved app accessibility
class AccessibilityUtils {
  /// Minimum touch target size (48x48 logical pixels per Material Design)
  static const double minTouchTargetSize = 48.0;

  /// Announce a message to screen readers
  static void announce(BuildContext context, String message, {TextDirection? textDirection}) {
    SemanticsService.announce(
      message,
      textDirection ?? Directionality.of(context),
    );
  }

  /// Generate semantic label for a metric card
  static String metricLabel({
    required String title,
    required String value,
    String? trend,
    String? unit,
  }) {
    final buffer = StringBuffer();
    buffer.write('$title: $value');
    
    if (unit != null) {
      buffer.write(' $unit');
    }
    
    if (trend != null && trend.isNotEmpty) {
      buffer.write(', $trend');
    }
    
    return buffer.toString();
  }

  /// Generate semantic label for a mood selector
  static String moodLabel({
    required String mood,
    required bool isSelected,
  }) {
    return isSelected 
        ? '$mood, selected' 
        : '$mood, not selected, double tap to select';
  }

  /// Generate semantic label for a journal entry
  static String journalEntryLabel({
    required String title,
    required String date,
    String? mood,
    int? wordCount,
  }) {
    final buffer = StringBuffer();
    buffer.write('Journal entry: $title, ');
    buffer.write('created on $date');
    
    if (mood != null) {
      buffer.write(', mood: $mood');
    }
    
    if (wordCount != null) {
      buffer.write(', $wordCount words');
    }
    
    return buffer.toString();
  }

  /// Generate semantic label for a button with icon
  static String buttonLabel({
    required String action,
    String? context,
  }) {
    return context != null ? '$action $context' : action;
  }

  /// Check if a size meets minimum touch target requirements
  static bool meetsMinimumTouchTarget(Size size) {
    return size.width >= minTouchTargetSize && 
           size.height >= minTouchTargetSize;
  }

  /// Ensure minimum touch target size
  static Size ensureMinimumTouchTarget(Size size) {
    return Size(
      size.width < minTouchTargetSize ? minTouchTargetSize : size.width,
      size.height < minTouchTargetSize ? minTouchTargetSize : size.height,
    );
  }

  /// Request focus on a specific node
  static void requestFocus(FocusNode node) {
    if (!node.hasFocus) {
      node.requestFocus();
    }
  }

  /// Move focus to next focusable element
  static void focusNext(BuildContext context) {
    FocusScope.of(context).nextFocus();
  }

  /// Move focus to previous focusable element
  static void focusPrevious(BuildContext context) {
    FocusScope.of(context).previousFocus();
  }

  /// Unfocus current element
  static void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Generate semantic label for a progress indicator
  static String progressLabel({
    required String task,
    required double progress,
  }) {
    final percentage = (progress * 100).round();
    return '$task, $percentage percent complete';
  }

  /// Generate semantic label for a toggle
  static String toggleLabel({
    required String feature,
    required bool isEnabled,
  }) {
    return '$feature, ${isEnabled ? 'enabled' : 'disabled'}';
  }

  /// Generate semantic label for a slider
  static String sliderLabel({
    required String name,
    required double value,
    required double min,
    required double max,
    String? unit,
  }) {
    final unitText = unit ?? '';
    return '$name, $value$unitText, minimum $min$unitText, maximum $max$unitText';
  }

  /// Announce navigation change to screen reader
  static void announceNavigation(BuildContext context, String screenName) {
    announce(context, 'Navigated to $screenName');
  }

  /// Announce action completion to screen reader
  static void announceCompletion(BuildContext context, String action) {
    announce(context, '$action completed');
  }

  /// Announce error to screen reader
  static void announceError(BuildContext context, String error) {
    announce(context, 'Error: $error');
  }
}
