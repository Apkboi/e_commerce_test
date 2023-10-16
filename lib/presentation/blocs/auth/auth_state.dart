part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}



class LoginLoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class LoginFailureState extends AuthState {
  final String error;

  const LoginFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}

class LoginSuccessState extends AuthState {
  @override
  List<Object?> get props => [];
}
