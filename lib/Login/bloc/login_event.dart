// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginEvent {}

class ELoginLogin extends LoginEvent {
  String email;
  String password;
  ELoginLogin({
    required this.email,
    required this.password,
  });
  
}
