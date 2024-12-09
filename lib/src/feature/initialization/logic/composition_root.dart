import 'package:lanars/src/core/utils/logger/refined_logger.dart';
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
    // const baseUrl = 'https://sndrosycldxwwasrweoe.supabase.co';
    // final baseClient = Client();
    final sharedPreferences = await SharedPreferences.getInstance();
    final settingsBloc = await _initSettingsBloc(sharedPreferences);
    // final storage = TokenStorageSP(sharedPreferences: sharedPreferences);
    // final token = await storage.load();
    //
    // final packageInfo = await PackageInfo.fromPlatform();
    // AppConfig(packageInfo.packageName);
    //
    // final clientWithoutInterceptor = RestClientHTTP(
    //   baseUrl: baseUrl,
    //   client: baseClient,
    // );
    //
    // final authInterceptor = AuthInterceptor(
    //   tokenStorage: storage,
    //   authorizationClient: JWTAuthorizationClient(clientWithoutInterceptor),
    //   retryClient: baseClient,
    //   token: token,
    // );
    //
    // final interceptedClient = InterceptedClient(
    //   inner: baseClient,
    //   interceptors: [authInterceptor],
    // );
    //
    // final clientWithAuthInterceptor = RestClientHTTP(
    //   baseUrl: baseUrl,
    //   client: interceptedClient,
    // );
    //
    // final authRepository = await _initAuthRepository(
    //   client: clientWithoutInterceptor,
    //   storage: storage,
    // );
    // final authBloc = await _initAuthBloc(
    //   token: token,
    //   authRepository: authRepository,
    // );
    //
    // final userBloc = await _initUserBloc(
    //   storage: storage,
    //   client: clientWithAuthInterceptor,
    //   authRepository: authRepository,
    //   token: token,
    // );
    //
    // final pokemonRepository = PokemonRepositoryImpl(
    //   PokemonDataSourceNetwork(client: clientWithAuthInterceptor),
    // );
    //
    // final boardingRepository = BoardingRepositoryImpl(
    //   firstRunAppStorage: FirstRunAppStorageSP(
    //     sharedPreferences: sharedPreferences,
    //   ),
    // );
    return Dependencies(
      settingsBloc: settingsBloc,
      // authBloc: authBloc,
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

  // Future<AuthBloc> _initAuthBloc({
  //   required AuthRepository authRepository,
  //   Token? token,
  // }) async {
  //   final authBloc = AuthBloc(
  //     AuthState.idle(
  //       status: token != null ? AuthenticationStatus.authenticated : AuthenticationStatus.unauthenticated,
  //     ),
  //     authRepository: authRepository,
  //   );
  //   return authBloc;
  // }
  //
  // Future<UserBloc> _initUserBloc({
  //   required TokenStorage storage,
  //   required RestClient client,
  //   required AuthRepository authRepository,
  //   Token? token,
  // }) async {
  //   final userRepository = UserRepositoryImpl(
  //     dataSource: UserDataSourceNetwork(
  //       client: client,
  //     ),
  //   );
  //   UserEntity user = UserEntity.notAuthenticated();
  //   try {
  //     if (token != null) user = await userRepository.fetchUser();
  //   } on Object catch (e, st) {
  //     logger.error(
  //       'Failed to fetch user',
  //       error: e,
  //       stackTrace: st,
  //     );
  //   }
  //   final userBloc = UserBloc(
  //     user: user,
  //     authRepository: authRepository,
  //     userRepository: userRepository,
  //   );
  //   return userBloc;
  // }
  //
  // Future<AuthRepository> _initAuthRepository({
  //   required RestClient client,
  //   required TokenStorage storage,
  // }) async {
  //   final dataSource = AuthDataSourceNetwork(client: client);
  //   final authRepository = AuthRepositoryImpl(
  //     dataSource: dataSource,
  //     storage: storage,
  //   );
  //   return authRepository;
  // }
}
