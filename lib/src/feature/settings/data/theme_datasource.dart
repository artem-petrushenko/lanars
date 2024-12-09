import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart' show Color, ThemeMode;
import 'package:lanars/src/core/utils/persisted_entry.dart';
import 'package:lanars/src/feature/app/model/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template theme_datasource}
/// [ThemeDataSource] is a data source that provides theme data.
///
/// This is used to set and get theme.
/// {@endtemplate}
abstract interface class ThemeDataSource {
  /// Set theme
  Future<void> setTheme(AppTheme theme);

  /// Get current theme from cache
  Future<AppTheme?> getTheme();
}

/// {@macro theme_datasource}
final class ThemeDataSourceLocal implements ThemeDataSource {
  /// {@macro theme_datasource}
  ThemeDataSourceLocal({
    required this.sharedPreferences,
    required this.codec,
  });

  /// The instance of [SharedPreferences] used to read and write values.
  final SharedPreferences sharedPreferences;

  /// Codec for [ThemeMode]
  final Codec<ThemeMode, String> codec;

  late final _themeMode = StringPreferencesEntry(
    sharedPreferences: sharedPreferences,
    key: 'theme.mode',
  );

  @override
  Future<void> setTheme(AppTheme theme) async {
    await _themeMode.setIfNullRemove(codec.encode(theme.mode));
  }

  @override
  Future<AppTheme?> getTheme() async {
    final type = await _themeMode.read();

    if (type == null) return null;

    return AppTheme(mode: codec.decode(type));
  }
}
