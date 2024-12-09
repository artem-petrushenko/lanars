import 'package:lanars/src/feature/auth/logic/auth_interceptor.dart';

/// Data source for authentication
abstract interface class AuthDataSource {
  /// Sign in with email and password
  Future<Token> signInWithEmailAndPassword(String email, String password);

  /// Sign out
  Future<void> signOut();
}

/// Auth data source that interacts with backend
/// and interprets the response as [Token] or throws [AuthenticationException]
final class AuthDataSourceNetwork implements AuthDataSource {

  /// Create an [AuthDataSourceNetwork]
  const AuthDataSourceNetwork();

  @override
  Future<Token> signInWithEmailAndPassword(String email,
      String password,) async {
    throw UnimplementedError();
    // final body = await _client.post(
    //   'auth/v1/token',
    //   queryParams: {
    //     'grant_type': 'password',
    //   },
    //   body: {
    //     'email': email,
    //     'password': password,
    //   },
    // );
    //
    // Check if response is an error
    // if (body
    //     case {
    //       'error': {
    //         optional message provided by the server
    //         'message': final String message,
    // system error code
    // 'code': final int code,
    // }
    // }) {
    // throw switch (code) {
    //   _ => UnknownAuthenticationException(code: code, error: message),
    // };
    // }
    //
    // Check if response contains access_token and refresh_token
    // if (body
    //     case {
    //       'access_token': final String accessToken,
    //       'refresh_token': final String refreshToken,
    //     }) {
    //   return Token(accessToken, refreshToken);
    // }
    //
    // If we can't understand the response, throw a format exception
    // throw FormatException(
    //   'Returned response is not understood by the application',
    //   body,
    // );
    }


  @override
  Future<void> signOut() async {}

}

/// Exception thrown when the authentication fails
base class AuthenticationException implements Exception {
  /// Create a [AuthenticationException]
  const AuthenticationException();
}

/// Unknown authentication exception
final class UnknownAuthenticationException implements AuthenticationException {
  /// System error code, that is not understood
  final int? code;

  /// Error message
  final Object error;

  /// Create a [UnknownAuthenticationException]
  const UnknownAuthenticationException({
    required this.error,
    this.code,
  });
}
