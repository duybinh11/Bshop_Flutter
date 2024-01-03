// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class ERegisterPageRegister extends RegisterEvent {
  String email;
  String username;
  String phone;
  String pass;
  String address;
  ERegisterPageRegister({
    required this.email,
    required this.username,
    required this.phone,
    required this.pass,
    required this.address,
  });
}
