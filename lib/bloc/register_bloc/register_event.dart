part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterButtonClickedEvent extends RegisterEvent {
  final String first_name;
  final String last_name;
  final String email;
  final String address;
  final String phone;
  final String password;

  RegisterButtonClickedEvent(
      {required this.first_name,
      required this.last_name,
      required this.email,
      required this.address,
      required this.phone,
      required this.password});
}
