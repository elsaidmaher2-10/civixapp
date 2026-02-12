import 'package:civixapp/feature/Auth/Login/data/models/loginsuccesresponse.dart';
import 'package:civixapp/feature/Auth/Login/data/repo/Loginrepo.dart';
import 'package:civixapp/feature/Auth/Login/presentation/manager/cubit/loginmanger_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginmangerCubit extends Cubit<LogincontrollerState> {
  LoginmangerCubit() : super(LogincontrollerInitial());
  // Loginrepo loginrepo;

  login({required email, required password}) async {
    emit(LogincontrollerLoading());
    await Future.delayed(Duration(seconds: 3));
    // final result = await loginrepo.login(email: email, password: password);

    // result.fold(
    //   (e) => emit(LogincontrollerFailure(message: "")),
    //   (Loginsuccesresponse r) => emit(LogincontrollerSuccess(r)),
    // );
  }
}
