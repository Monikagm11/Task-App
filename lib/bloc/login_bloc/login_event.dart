part of 'login_bloc.dart';


sealed class LoginEvent {}

class LoginButtonClickedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginButtonClickedEvent({required this.email, required this.password});
}
