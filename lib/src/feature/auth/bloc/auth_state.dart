part of 'auth_bloc.dart';

/// States for [AuthBloc]
sealed class AuthState {
  const AuthState({required this.user});

  /// Status of the authentication
  final UserEntity user;

  /// Idle state, state machine is doing nothing
  const factory AuthState.idle({
    required UserEntity user,
  }) = _AuthStateIdle;

  const factory AuthState.processing({
    required UserEntity user,
  }) = _AuthStateProcessing;

  const factory AuthState.failure({
    required UserEntity user,
    required Object error,
  }) = _AuthStateFailure;

  /// Get error if state is error
  Object? get error => switch (this) {
        final _AuthStateFailure e => e.error,
        _ => null,
      };

  /// Get loading is state is processing
  bool get isLoading => this is _AuthStateProcessing;
}

final class _AuthStateIdle extends AuthState {
  const _AuthStateIdle({required super.user});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _AuthStateIdle && other.user == user;
  }

  @override
  int get hashCode => Object.hashAll([user]);

  @override
  String toString() => '_AuthStateIdle(user: $user)';
}

final class _AuthStateProcessing extends AuthState {
  const _AuthStateProcessing({required super.user});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _AuthStateProcessing && other.user == user;
  }

  @override
  int get hashCode => Object.hashAll([user]);

  @override
  String toString() => '_AuthStateProcessing(user: $user)';
}

final class _AuthStateFailure extends AuthState {
  @override
  final Object error;

  const _AuthStateFailure({
    required this.error,
    required super.user,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _AuthStateFailure && other.user == user && other.error == error;
  }

  @override
  int get hashCode => Object.hashAll([user, error]);

  @override
  String toString() => '_AuthStateError(status: $user, message: $error)';
}
