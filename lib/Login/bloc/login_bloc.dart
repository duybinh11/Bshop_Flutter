import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:do_an2_1/Api/ApiAuth.dart';
import 'package:do_an2_1/Model/UserModel.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ApiAuth apiAuth = ApiAuth();
  UserModel? userModel;
  LoginBloc() : super(LoginInitial()) {
    on<ELoginLogin>(login);
  }

  FutureOr<void> login(ELoginLogin event, Emitter<LoginState> emit) async {
    emit(SLoginLoading());
    dynamic result =
        await apiAuth.login(email: event.email, password: event.password);
    if (result is UserModel) {
      userModel = result;
      emit(SLoginSuccess());
    } else if (result is String) {
      emit(SLoginFail(message: result));
    }
  }
}
