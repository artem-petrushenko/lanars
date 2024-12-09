part of 'settings_bloc.dart';

/// Events for the [SettingsBloc].
sealed class SettingsEvent {
  const SettingsEvent();

  /// Event to update theme.
  const factory SettingsEvent.updateTheme({required AppTheme appTheme}) = _UpdateThemeSettingsEvent;

  /// Event to update the text scale.
  const factory SettingsEvent.updateTextScale({required double textScale}) = _UpdateTextScaleSettingsEvent;
}

final class _UpdateThemeSettingsEvent extends SettingsEvent {
  const _UpdateThemeSettingsEvent({required this.appTheme});

  /// The theme to update.
  final AppTheme appTheme;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _UpdateThemeSettingsEvent && other.appTheme == appTheme;
  }

  @override
  int get hashCode => appTheme.hashCode;

  @override
  String toString() => 'SettingsEvent.updateTheme(appTheme: $appTheme)';
}

final class _UpdateTextScaleSettingsEvent extends SettingsEvent {
  const _UpdateTextScaleSettingsEvent({required this.textScale});

  final double textScale;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _UpdateTextScaleSettingsEvent && other.textScale == textScale;
  }

  @override
  int get hashCode => textScale.hashCode;

  @override
  String toString() => 'SettingsEvent.updateTextScale(scale: $textScale)';
}
