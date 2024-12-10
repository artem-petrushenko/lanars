import 'package:lanars/src/feature/auth/data/data_provider/auth_data_source.dart';
import 'package:lanars/src/feature/auth/data/data_provider/user_storage_sp.dart';
import 'package:lanars/src/feature/auth/data/entity/user_entity.dart';

/// AuthRepository
abstract interface class AuthRepository {
  /// Sign in with email and password
  Future<AuthenticatedUserEntity> signInWithEmailAndPassword(String email, String password);

  /// Sign out
  Future<void> signOut();
}

/// AuthRepositoryImpl
final class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;
  final UserStorage _storage;

  /// Create an [AuthRepositoryImpl]
  const AuthRepositoryImpl({
    required AuthDataSource dataSource,
    required UserStorage storage,
  })  : _dataSource = dataSource,
        _storage = storage;

  @override
  Future<AuthenticatedUserEntity> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final result = await _dataSource.signInWithEmailAndPassword(data: {
      'email': email,
      'password': password,
    });
    final user = result.results.first;
    await _storage.save(user);

    return user;
  }

  @override
  Future<void> signOut() async {
    // await _dataSource.signOut();
    await _storage.clear();
  }
}
