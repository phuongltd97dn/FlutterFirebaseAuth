part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStateChangeEvent extends AuthEvent {
  final fb_auth.User? user;

  const AuthStateChangeEvent({this.user});

  @override
  List<Object?> get props => [user];
}

class SignoutRequestedEvent extends AuthEvent {}
