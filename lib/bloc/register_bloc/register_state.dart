part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterLoadedState extends RegisterState {
  final Registerusermodel registerdata;

  RegisterLoadedState({required this.registerdata});
}

final class RegisterErrorState extends RegisterState {
  final String errormessage;

  RegisterErrorState({required this.errormessage});
}
