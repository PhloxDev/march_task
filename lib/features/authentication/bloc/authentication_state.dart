part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final String email;
  const AuthenticationSuccess({required this.email});

  @override
  List<Object> get props => [email];
}

class AuthenticationFailure extends AuthenticationState {}
