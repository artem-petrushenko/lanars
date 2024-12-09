import 'package:lanars/src/feature/auth/bloc/auth_bloc.dart';
import 'package:lanars/src/feature/settings/bloc/settings_bloc.dart';

/// {@template dependencies}
/// Composed dependencies from the [CompositionRoot].
///
/// This class is used to pass dependencies to the application.
///
/// {@macro composition_process}
/// {@endtemplate}
base class Dependencies {
  /// {@macro dependencies}
  const Dependencies({
    required this.settingsBloc,
    // required this.authBloc,
  });

  /// [SettingsBloc] instance, used to manage theme and locale.
  final SettingsBloc settingsBloc;

  /// [AuthBloc] instance, used to manage authentication.
  // final AuthBloc authBloc;
}

/// {@template composition_result}
/// Result of composition
///
/// {@macro composition_process}
/// {@endtemplate}
final class CompositionResult {
  /// {@macro composition_result}
  const CompositionResult({
    required this.dependencies,
    required this.msSpent,
  });

  /// The dependencies
  final Dependencies dependencies;

  /// The number of milliseconds spent
  final int msSpent;

  @override
  String toString() => '$CompositionResult('
      'dependencies: $dependencies, '
      'msSpent: $msSpent'
      ')';
}
