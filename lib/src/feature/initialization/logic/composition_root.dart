import 'package:dio/dio.dart';
import 'package:lanars/src/core/utils/logger/refined_logger.dart';
import 'package:lanars/src/core/utils/rest_api/base_rest_api.dart';
import 'package:lanars/src/feature/auth/bloc/auth_bloc.dart';
import 'package:lanars/src/feature/auth/data/data_provider/auth_data_source.dart';
import 'package:lanars/src/feature/auth/data/data_provider/user_storage_sp.dart';
import 'package:lanars/src/feature/auth/data/entity/user_entity.dart';
import 'package:lanars/src/feature/auth/data/repository/auth_repository.dart';
import 'package:lanars/src/feature/initialization/model/dependencies.dart';
import 'package:lanars/src/feature/settings/bloc/settings_bloc.dart';
import 'package:lanars/src/feature/settings/data/text_scale_datasource.dart';
import 'package:lanars/src/feature/settings/data/text_scale_repository.dart';
import 'package:lanars/src/feature/settings/data/theme_datasource.dart';
import 'package:lanars/src/feature/settings/data/theme_mode_codec.dart';
import 'package:lanars/src/feature/settings/data/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template composition_root}
/// A place where all dependencies are initialized.
/// {@endtemplate}
///
/// {@template composition_process}
/// Composition of dependencies is a process of creating and configuring
/// instances of classes that are required for the application to work.
///
/// It is a good practice to keep all dependencies in one place to make it
/// easier to manage them and to ensure that they are initialized only once.
/// {@endtemplate}
final class CompositionRoot {
  /// {@macro composition_root}
  const CompositionRoot();

  /// Composes dependencies and returns result of composition.
  Future<CompositionResult> compose() async {
    final stopwatch = Stopwatch()..start();

    logger.info('Initializing dependencies...');
    // initialize dependencies
    final dependencies = await _initDependencies();
    logger.info('Dependencies initialized');

    stopwatch.stop();
    final result = CompositionResult(
      dependencies: dependencies,
      msSpent: stopwatch.elapsedMilliseconds,
    );
    return result;
  }

  Future<Dependencies> _initDependencies() async {
    final dio = Dio();
    final sharedPreferences = await SharedPreferences.getInstance();
    final settingsBloc = await _initSettingsBloc(sharedPreferences);
    final storage = UserStorageSP(sharedPreferences: sharedPreferences);
    final user = await storage.load();
    final authRepository = await _initAuthRepository(
      client: dio,
      storage: storage,
    );
    final authBloc = await _initAuthBloc(
      authRepository: authRepository,
      user: user,
    );
    return Dependencies(
      settingsBloc: settingsBloc,
      authBloc: authBloc,
    );
  }

  Future<SettingsBloc> _initSettingsBloc(SharedPreferences prefs) async {
    final themeRepository = ThemeRepositoryImpl(
      themeDataSource: ThemeDataSourceLocal(
        sharedPreferences: prefs,
        codec: const ThemeModeCodec(),
      ),
    );

    final textScaleRepository = TextScaleRepositoryImpl(
      textScaleDataSource: TextScaleDatasourceLocal(sharedPreferences: prefs),
    );

    final theme = await themeRepository.getTheme();
    final textScale = await textScaleRepository.getScale();

    final initialState = SettingsState.idle(
      appTheme: theme,
      textScale: textScale,
    );

    final settingsBloc = SettingsBloc(
      themeRepository: themeRepository,
      textScaleRepository: textScaleRepository,
      initialState: initialState,
    );
    return settingsBloc;
  }

  Future<AuthBloc> _initAuthBloc({
    required AuthRepository authRepository,
    required UserEntity user,
  }) async {
    final authBloc = AuthBloc(
      AuthState.idle(user: user),
      authRepository: authRepository,
    );
    return authBloc;
  }

  Future<AuthRepository> _initAuthRepository({
    required Dio client,
    required UserStorage storage,
  }) async {
    final dataSource = AuthDataSource(
      client,
      baseUrl: BaseRestApi.authBaseUrl,
    );
    final authRepository = AuthRepositoryImpl(
      dataSource: dataSource,
      storage: storage,
    );
    return authRepository;
  }
}
