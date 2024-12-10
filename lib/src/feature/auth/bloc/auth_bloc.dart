import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars/src/core/utils/emitter_mixin.dart';
import 'package:lanars/src/feature/auth/data/entity/user_entity.dart';
import 'package:lanars/src/feature/auth/data/repository/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

/// AuthBloc
final class AuthBloc extends Bloc<AuthEvent, AuthState> with SetStateMixin {
  final AuthRepository _authRepository;

  /// Create an [AuthBloc]
  ///
  /// This specializes required initialState as it should be preloaded.
  AuthBloc(
    super.initialState, {
    required AuthRepository authRepository,
  }) : _authRepository = authRepository {
    on<AuthEvent>(
      (event, emit) => switch (event) {
        final _SignInWithEmailAndPassword e => _signInWithEmailAndPassword(e, emit),
        final _SignOut e => _signOut(e, emit),
      },
    );
  }

  Future<void> _signOut(
    _SignOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.processing(user: state.user));

    try {
      await _authRepository.signOut();
      emit(AuthState.idle(user: UserEntity.notAuthenticated()));
    } on Object catch (e, stackTrace) {
      emit(
        AuthState.failure(
          user: UserEntity.notAuthenticated(),
          error: e,
        ),
      );
      onError(e, stackTrace);
    }
  }

  Future<void> _signInWithEmailAndPassword(
    _SignInWithEmailAndPassword event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.processing(user: state.user));

    try {
      final user = await _authRepository.signInWithEmailAndPassword(
        event.email,
        event.password,
      );
      emit(AuthState.idle(user: user));
    } on Object catch (e, stackTrace) {
      emit(
        AuthState.failure(
          user: UserEntity.notAuthenticated(),
          error: e,
        ),
      );
      onError(e, stackTrace);
    }
  }
}
