import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lanars/src/core/theme/theme_helper.dart';

/// {@template app_theme}
/// An immutable class that holds properties needed
/// to build a [ThemeData] for the app.
/// {@endtemplate}
@immutable
final class AppTheme with Diagnosticable {
  /// {@macro app_theme}
  AppTheme({required this.mode});

  /// The type of theme to use.
  final ThemeMode mode;

  /// The dark [ThemeData] for this [AppTheme].
  final ThemeData darkTheme = createDarkTheme;

  /// The light [ThemeData] for this [AppTheme].
  final ThemeData lightTheme = createLightTheme;

  /// The [ThemeData] for this [AppTheme].
  /// This is computed based on the [mode].
  ThemeData computeTheme() {
    switch (mode) {
      case ThemeMode.light:
        return lightTheme;
      case ThemeMode.dark:
        return darkTheme;
      case ThemeMode.system:
        return PlatformDispatcher.instance.platformBrightness == Brightness.dark ? darkTheme : lightTheme;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<ThemeMode>('type', mode));
    properties.add(DiagnosticsProperty<ThemeData>('lightTheme', lightTheme));
    properties.add(DiagnosticsProperty<ThemeData>('darkTheme', darkTheme));
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppTheme && mode == other.mode;

  @override
  int get hashCode => Object.hash(mode, lightTheme, darkTheme);
}
