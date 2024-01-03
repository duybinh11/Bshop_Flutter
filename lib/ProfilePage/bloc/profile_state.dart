part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class SProfilePageLoading extends ProfileState {}

final class SProfilePageLogoutErorr extends ProfileState {}

final class SProfilePageLogoutSuccess extends ProfileState {}
