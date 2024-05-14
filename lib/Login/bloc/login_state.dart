part of 'login_bloc.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

class SLoginFail extends LoginState {
  String message;
  SLoginFail({required this.message});
}

final class SLoginSuccess extends LoginState {}

final class SLoginLoading extends LoginState {}
