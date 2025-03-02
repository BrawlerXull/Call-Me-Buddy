import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ShadAppTheme {

  static const String lightMode = 'blue';
  
  static const String darkMode = 'slate';

  static final lightTheme = ShadThemeData(
    brightness: Brightness.light,
    colorScheme: ShadColorScheme.fromName(
      lightMode,
      brightness: Brightness.light,
    ),
  );

  static final darkTheme = ShadThemeData(
    brightness: Brightness.dark,
    colorScheme: ShadColorScheme.fromName(
      darkMode,
      brightness: Brightness.dark,
    ),
  );
}
