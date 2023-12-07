part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class SLoginFail extends LoginState {}

final class SLoginSuccess extends LoginState {}

final class SLoginLoading extends LoginState {}
