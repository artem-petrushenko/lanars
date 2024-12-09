import 'dart:ui' show Locale;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars/src/feature/app/model/app_theme.dart';
import 'package:lanars/src/feature/settings/data/text_scale_repository.dart';
import 'package:lanars/src/feature/settings/data/theme_repository.dart';

part 'settings_state.dart';

part 'settings_event.dart';

/// {@template settings_bloc}
/// A [Bloc] that handles the settings.
/// {@endtemplate}
final class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  /// {@macro settings_bloc}
  SettingsBloc({
    required ThemeRepository themeRepository,
    required TextScaleRepository textScaleRepository,
    required SettingsState initialState,
  })  : _themeRepo = themeRepository,
        _textScaleRepo = textScaleRepository,
        super(initialState) {
    on<SettingsEvent>(
      (event, emit) => switch (event) {
        final _UpdateThemeSettingsEvent e => _updateTheme(e, emit),
        final _UpdateTextScaleSettingsEvent e => _updateTextScale(e, emit),
      },
    );
  }

  final ThemeRepository _themeRepo;
  final TextScaleRepository _textScaleRepo;

  Future<void> _updateTheme(
    _UpdateThemeSettingsEvent event,
    Emitter<SettingsState> emitter,
  ) async {
    try {
      emitter(
        SettingsState.processing(
          appTheme: state.appTheme,
          locale: state.locale,
          textScale: state.textScale,
        ),
      );
      await _themeRepo.setTheme(event.appTheme);

      emitter(
        SettingsState.idle(
          appTheme: event.appTheme,
          locale: state.locale,
          textScale: state.textScale,
        ),
      );
    } on Object catch (e, stackTrace) {
      emitter(
        SettingsState.error(
          appTheme: state.appTheme,
          locale: state.locale,
          textScale: state.textScale,
          cause: e,
        ),
      );
      onError(e, stackTrace);
    }
  }

  Future<void> _updateTextScale(
    _UpdateTextScaleSettingsEvent event,
    Emitter<SettingsState> emitter,
  ) async {
    try {
      emitter(
        SettingsState.processing(
          appTheme: state.appTheme,
          locale: state.locale,
          textScale: state.textScale,
        ),
      );
      await _textScaleRepo.setScale(event.textScale);

      emitter(
        SettingsState.idle(
          appTheme: state.appTheme,
          locale: state.locale,
          textScale: event.textScale,
        ),
      );
    } on Object catch (e, stackTrace) {
      emitter(
        SettingsState.error(
          appTheme: state.appTheme,
          locale: state.locale,
          textScale: state.textScale,
          cause: e,
        ),
      );
      onError(e, stackTrace);
    }
  }
}

