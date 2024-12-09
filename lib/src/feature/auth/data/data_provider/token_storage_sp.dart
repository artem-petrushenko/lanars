import 'dart:async';

import 'package:lanars/src/core/utils/preferences_dao.dart';
import 'package:lanars/src/feature/auth/logic/auth_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template token_storage_sp}
/// Implementation of [TokenStorage] that uses [TypedEntry] to store
/// the authorization info.
/// {@endtemplate}


/// [TokenStorage] stores and manages the Auth token.
abstract interface class TokenStorage {
  /// Load the Auth token from the storage.
  ///
  /// If this returns null, the client should assume that the user is not
  /// authenticated.
  Future<Token?> load();

  /// Save the Auth token to the storage.
  ///
  /// This is used to persist the token pair after:
  ///  - A successful sign-in
  ///  - A successful token refresh
  ///
  /// Note, that this method should not be called when user logs out -
  /// use [clear] for that.
  Future<void> save(Token tokenPair);

  /// Clears the Auth token.
  ///
  /// This can be used to clear the token pair, for example, when the user logs
  /// out or token pair is revoked / expired.
  Future<void> clear();

  /// Returns a stream of the Auth token.
  ///
  /// Every time the Auth token changes, the new value will be added to the
  /// stream.
  ///
  /// This is especially useful as [TokenStorage] can be used from
  /// different places and the token can be changed from any of them.
  /// For example, when user logs out, we need to update the value in
  /// the interceptor as well as in the bloc that holds the authentication
  /// state.
  Stream<Token?> getStream();

  /// Closes the storage.
  ///
  /// After this method is called, the storage should not be used anymore.
  Future<void> close();
}
final class TokenStorageSP implements TokenStorage {
  /// {@macro token_storage_sp}
  TokenStorageSP({required SharedPreferences sharedPreferences})
      : _accessToken = TypedEntry(
          sharedPreferences: sharedPreferences,
          key: 'authorization.access_token',
        ),
        _refreshToken = TypedEntry(
          sharedPreferences: sharedPreferences,
          key: 'authorization.refresh_token',
        );

  late final PreferencesEntry<String> _accessToken;
  late final PreferencesEntry<String> _refreshToken;
  final _streamController = StreamController<Token?>.broadcast();

  @override
  Future<Token?> load() async {
    final accessToken = _accessToken.read();
    final refreshToken = _refreshToken.read();

    if (accessToken == null || refreshToken == null) {
      return null;
    }

    return Token(accessToken, refreshToken);
  }

  @override
  Future<void> save(Token tokenPair) async {
    await (
      _accessToken.set(tokenPair.accessToken),
      _refreshToken.set(tokenPair.refreshToken)
    ).wait;
    _streamController.add(tokenPair);
  }

  @override
  Future<void> clear() async {
    await (_accessToken.remove(), _refreshToken.remove()).wait;
    _streamController.add(null);
  }

  @override
  Stream<Token?> getStream() => _streamController.stream;

  @override
  Future<void> close() => _streamController.close();
}
