import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<EProfilePageLogout>(logout);
  }

  FutureOr<void> logout(
      EProfilePageLogout event, Emitter<ProfileState> emit) async {
    emit(SProfilePageLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      emit(SProfilePageLogoutSuccess());
    } catch (e) {
      emit(SProfilePageLogoutErorr());
    }
  }
}
