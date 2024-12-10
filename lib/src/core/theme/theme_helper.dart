import 'package:flutter/material.dart';

ThemeData _createThemeData(
  ColorScheme colorScheme,
) =>
    ThemeData(
      // useMaterial3: false,
      colorScheme: colorScheme,
      appBarTheme:  AppBarTheme(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: colorScheme.background,
        surfaceTintColor: colorScheme.background,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.onSurface,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.primary,
          ),
        ),
        enabledBorder: const OutlineInputBorder(),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.error,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.outline,
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );

ThemeData get createDarkTheme => _createThemeData(darkColorScheme);

ThemeData get createLightTheme => _createThemeData(lightColorScheme);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF0061A6),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFD2E4FF),
  onPrimaryContainer: Color(0xFF001C37),
  secondary: Color(0xFF535F70),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD7E3F8),
  onSecondaryContainer: Color(0xFF101C2B),
  tertiary: Color(0xFF6B5778),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFF3DAFF),
  onTertiaryContainer: Color(0xFF251431),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF410002),
  outline: Color(0xFF73777F),
  background: Color(0xFFFDFCFF),
  onBackground: Color(0xFF1A1C1E),
  surface: Color(0xFFFAF9FC),
  onSurface: Color(0xFF1A1C1E),
  surfaceVariant: Color(0xFFDFE2EB),
  onSurfaceVariant: Color(0xFF43474E),
  inverseSurface: Color(0xFF2F3033),
  onInverseSurface: Color(0xFFF1F0F4),
  inversePrimary: Color(0xFFA0CAFF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF0061A6),
  outlineVariant: Color(0xFFC3C6CF),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFA0CAFF),
  onPrimary: Color(0xFF003259),
  primaryContainer: Color(0xFF00497E),
  onPrimaryContainer: Color(0xFFD2E4FF),
  secondary: Color(0xFFBBC7DB),
  onSecondary: Color(0xFF253141),
  secondaryContainer: Color(0xFF3C4858),
  onSecondaryContainer: Color(0xFFD7E3F8),
  tertiary: Color(0xFFD7BEE4),
  onTertiary: Color(0xFF3B2947),
  tertiaryContainer: Color(0xFF533F5F),
  onTertiaryContainer: Color(0xFFF3DAFF),
  error: Color(0xFFFFB4AB),
  onError: Color(0xFF690005),
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  outline: Color(0xFF8D9199),
  background: Color(0xFF1A1C1E),
  onBackground: Color(0xFFE3E2E6),
  surface: Color(0xFF121316),
  onSurface: Color(0xFFC6C6CA),
  surfaceVariant: Color(0xFF43474E),
  onSurfaceVariant: Color(0xFFC3C6CF),
  inverseSurface: Color(0xFFE3E2E6),
  onInverseSurface: Color(0xFF1A1C1E),
  inversePrimary: Color(0xFF0061A6),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFA0CAFF),
  outlineVariant: Color(0xFF43474E),
  scrim: Color(0xFF000000),
);
