part of 'settings_bloc.dart';

/// States for the [SettingsBloc].
sealed class SettingsState {
  const SettingsState({this.locale, this.appTheme, this.textScale});

  /// Application locale.
  final Locale? locale;

  /// Data class used to represent the state of theme.
  final AppTheme? appTheme;

  /// Application text scale
  final double? textScale;

  /// Idle state for the [SettingsBloc].
  const factory SettingsState.idle({
    Locale? locale,
    AppTheme? appTheme,
    double? textScale,
  }) = _IdleSettingsState;

  /// Processing state for the [SettingsBloc].
  const factory SettingsState.processing({
    Locale? locale,
    AppTheme? appTheme,
    double? textScale,
  }) = _ProcessingSettingsState;

  /// Error state for the [SettingsBloc].
  const factory SettingsState.error({
    required Object cause,
    Locale? locale,
    AppTheme? appTheme,
    double? textScale,
  }) = _ErrorSettingsState;
}

final class _IdleSettingsState extends SettingsState {
  const _IdleSettingsState({super.locale, super.appTheme, super.textScale});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _IdleSettingsState &&
        other.locale == locale &&
        other.appTheme == appTheme &&
        other.textScale == textScale;
  }

  @override
  int get hashCode => Object.hash(locale, appTheme, textScale);

  @override
  String toString() => 'SettingsState.idle('
      'locale: $locale, '
      'appTheme: $appTheme, '
      'textScale: $textScale'
      ')';
}

final class _ProcessingSettingsState extends SettingsState {
  const _ProcessingSettingsState({
    super.locale,
    super.appTheme,
    super.textScale,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ProcessingSettingsState &&
        other.locale == locale &&
        other.appTheme == appTheme &&
        other.textScale == textScale;
  }

  @override
  int get hashCode => Object.hash(locale, appTheme, textScale);

  @override
  String toString() => 'SettingsState.processing('
      'locale: $locale, '
      'appTheme: $appTheme, '
      'textScale: $textScale'
      ')';
}

final class _ErrorSettingsState extends SettingsState {
  const _ErrorSettingsState({
    required this.cause,
    super.locale,
    super.appTheme,
    super.textScale,
  });

  /// The cause of the error.
  final Object cause;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ErrorSettingsState &&
        other.cause == cause &&
        other.locale == locale &&
        other.appTheme == appTheme &&
        other.textScale == textScale;
  }

  @override
  int get hashCode => Object.hash(cause, locale, appTheme, textScale);

  @override
  String toString() => 'SettingsState.error('
      'cause: $cause, '
      'locale: $locale, '
      'appTheme: $appTheme, '
      'textScale: $textScale'
      ')';
}
