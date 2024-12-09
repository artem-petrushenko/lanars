import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars/src/core/theme/theme_helper.dart';
import 'package:lanars/src/core/utils/extensions/context_extension.dart';
import 'package:lanars/src/feature/app/model/app_theme.dart';
import 'package:lanars/src/feature/settings/bloc/settings_bloc.dart';

/// {@template theme_scope_controller}
/// A controller that holds and operates the app theme.
/// {@endtemplate}
abstract interface class ThemeScopeController {
  /// Get the current [AppTheme].
  AppTheme get theme;

  /// Set the theme mode to [themeMode].
  void setThemeMode(ThemeMode themeMode);
}

/// {@template text_scale_scope_controller}
/// A controller that holds and operates the app text scale.
/// {@endtemplate}
abstract interface class TextScaleScopeController {
  /// Get the current [textScale]
  double get textScale;

  /// Set text scale to [textScale].
  void setTextScale(double textScale);
}

/// {@template settings_scope_controller}
/// A controller that holds and operates the app settings.
/// {@endtemplate}
abstract interface class SettingsScopeController implements ThemeScopeController, TextScaleScopeController {}

enum _SettingsScopeAspect {
  /// The theme aspect.
  theme,

  /// The textScale aspect.
  textScale;
}

/// {@template settings_scope}
/// Settings scope is responsible for handling settings-related stuff.
///
/// For example, it holds facilities to change
/// - theme seed color
/// - theme mode
/// - locale
/// {@endtemplate}
class SettingsScope extends StatefulWidget {
  /// {@macro settings_scope}
  const SettingsScope({
    required this.child,
    required this.settingsBloc,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// The [SettingsBloc] instance.
  final SettingsBloc settingsBloc;

  /// Get the [SettingsScopeController] of the closest [SettingsScope] ancestor.
  static SettingsScopeController of(
    BuildContext context, {
    bool listen = true,
  }) =>
      context.inhOf<_InheritedSettingsScope>(listen: listen).controller;

  /// Get the [ThemeScopeController] of the closest [SettingsScope] ancestor.
  static ThemeScopeController themeOf(BuildContext context) => context
      .inheritFrom<_SettingsScopeAspect, _InheritedSettingsScope>(
        aspect: _SettingsScopeAspect.theme,
      )
      .controller;

  /// Get the [TextScaleScopeController] ofthe closest [SettingsScope]
  /// ancestor.
  static TextScaleScopeController textScaleOf(BuildContext context) => context
      .inheritFrom<_SettingsScopeAspect, _InheritedSettingsScope>(
        aspect: _SettingsScopeAspect.textScale,
      )
      .controller;

  @override
  State<SettingsScope> createState() => _SettingsScopeState();
}

/// State for widget SettingsScope
class _SettingsScopeState extends State<SettingsScope> implements SettingsScopeController {
  @override
  void setThemeMode(ThemeMode themeMode) => widget.settingsBloc.add(
        SettingsEvent.updateTheme(
          appTheme: AppTheme(mode: themeMode),
        ),
      );

  @override
  void setTextScale(double textScale) {
    widget.settingsBloc.add(SettingsEvent.updateTextScale(textScale: textScale));
  }

  @override
  AppTheme get theme => widget.settingsBloc.state.appTheme ?? AppTheme(mode: ThemeMode.light);

  @override
  double get textScale => widget.settingsBloc.state.textScale ?? 1;

  @override
  Widget build(BuildContext context) => BlocBuilder<SettingsBloc, SettingsState>(
        bloc: widget.settingsBloc,
        builder: (context, state) => _InheritedSettingsScope(
          controller: this,
          state: state,
          child: widget.child,
        ),
      );
}

class _InheritedSettingsScope extends InheritedModel<_SettingsScopeAspect> {
  const _InheritedSettingsScope({
    required this.controller,
    required this.state,
    required super.child,
  });

  final SettingsScopeController controller;
  final SettingsState state;

  @override
  bool updateShouldNotify(_InheritedSettingsScope oldWidget) => state != oldWidget.state;

  @override
  bool updateShouldNotifyDependent(
    covariant _InheritedSettingsScope oldWidget,
    Set<_SettingsScopeAspect> dependencies,
  ) {
    var shouldNotify = false;

    if (dependencies.contains(_SettingsScopeAspect.theme)) {
      shouldNotify = shouldNotify || state.appTheme != oldWidget.state.appTheme;
    }

    if (dependencies.contains(_SettingsScopeAspect.textScale)) {
      shouldNotify = shouldNotify || state.textScale != oldWidget.state.textScale;
    }

    return shouldNotify;
  }
}
