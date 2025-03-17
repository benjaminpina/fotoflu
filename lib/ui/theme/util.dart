import 'package:flutter/material.dart';

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  
  // Use local font family instead of Google Fonts
  TextTheme textTheme = baseTextTheme.copyWith(
    displayLarge: baseTextTheme.displayLarge?.copyWith(fontFamily: displayFontString),
    displayMedium: baseTextTheme.displayMedium?.copyWith(fontFamily: displayFontString),
    displaySmall: baseTextTheme.displaySmall?.copyWith(fontFamily: displayFontString),
    headlineLarge: baseTextTheme.headlineLarge?.copyWith(fontFamily: displayFontString),
    headlineMedium: baseTextTheme.headlineMedium?.copyWith(fontFamily: displayFontString),
    headlineSmall: baseTextTheme.headlineSmall?.copyWith(fontFamily: displayFontString),
    titleLarge: baseTextTheme.titleLarge?.copyWith(fontFamily: displayFontString),
    titleMedium: baseTextTheme.titleMedium?.copyWith(fontFamily: displayFontString),
    titleSmall: baseTextTheme.titleSmall?.copyWith(fontFamily: displayFontString),
    bodyLarge: baseTextTheme.bodyLarge?.copyWith(fontFamily: bodyFontString),
    bodyMedium: baseTextTheme.bodyMedium?.copyWith(fontFamily: bodyFontString),
    bodySmall: baseTextTheme.bodySmall?.copyWith(fontFamily: bodyFontString),
    labelLarge: baseTextTheme.labelLarge?.copyWith(fontFamily: bodyFontString),
    labelMedium: baseTextTheme.labelMedium?.copyWith(fontFamily: bodyFontString),
    labelSmall: baseTextTheme.labelSmall?.copyWith(fontFamily: bodyFontString),
  );
  
  return textTheme;
}
