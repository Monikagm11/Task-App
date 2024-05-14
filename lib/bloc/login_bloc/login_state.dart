part of 'login_bloc.dart';


sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginLoadedState extends LoginState {
  final Loginusermodel loginData;

  LoginLoadedState({required this.loginData});
}

final class LoginErrorState extends LoginState {
  final String errormessage;

  LoginErrorState({required this.errormessage});

}
