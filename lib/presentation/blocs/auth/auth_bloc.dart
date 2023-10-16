import 'dart:async';

import 'package:e_commerce_test/data/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
    });
    on<LoginEvent>(_mapLoginEventToState);
  }

  FutureOr<void> _mapLoginEventToState(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());

    try {
      var result = await authRepository.login(event.username, event.password);

      result.fold(
          (errorModel) =>
              emit(LoginFailureState(error: errorModel.errorMessage)),
          (response) {
        emit(LoginSuccessState());
      });
    } on Exception catch (e, stack) {
      debugPrintStack(stackTrace: stack);
      emit(LoginFailureState(error: e.toString()));
    }
  }
}
