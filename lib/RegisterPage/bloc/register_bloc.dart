import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:do_an2_1/Api/ApiAuth.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  ApiAuth apiAuth = ApiAuth();
  RegisterBloc() : super(RegisterInitial()) {
    on<ERegisterPageRegister>(registerAccount);
  }

  FutureOr<void> registerAccount(
      ERegisterPageRegister event, Emitter<RegisterState> emit) async {
    emit(SRegisterLoading());
    dynamic result = await apiAuth.RegisterAccount(
        event.email, event.pass, event.phone, event.address, event.username);
    if (result is bool) {
      result ? emit(SRegisterSuccess()) : emit(SRegisterErorr(erorr: 'sd'));
    } else if (result is String) {
      emit(SRegisterErorr(erorr: result));
    }
  }
}
