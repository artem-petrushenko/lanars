import 'package:lanars/src/feature/auth/data/data_provider/auth_data_source.dart';
import 'package:lanars/src/feature/auth/data/data_provider/token_storage_sp.dart';
import 'package:lanars/src/feature/auth/logic/auth_interceptor.dart';

/// AuthRepository
abstract interface class AuthRepository implements AuthStatusSource {
  /// Sign in with email and password
  Future<Token> signInWithEmailAndPassword(String email, String password);

  /// Sign out
  Future<void> signOut();
}

/// AuthRepositoryImpl
final class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;
  final TokenStorage _storage;

  /// Create an [AuthRepositoryImpl]
  const AuthRepositoryImpl({
    required AuthDataSource dataSource,
    required TokenStorage storage,
  })  : _dataSource = dataSource,
        _storage = storage;

  @override
  Future<Token> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final token = await _dataSource.signInWithEmailAndPassword(email, password);
    await _storage.save(token);

    return token;
  }

  @override
  Future<void> signOut() async {
    await _dataSource.signOut();
    await _storage.clear();
  }

  @override
  Stream<AuthenticationStatus> get authStatus => _storage.getStream().map(
        (token) => token != null ? AuthenticationStatus.authenticated : AuthenticationStatus.unauthenticated,
      );
}
