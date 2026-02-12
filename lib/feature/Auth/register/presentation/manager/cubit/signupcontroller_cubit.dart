
import 'package:civixapp/feature/Auth/register/presentation/manager/cubit/signupcontroller_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupcontrollerCubit extends Cubit<SignupcontrollerState> {
  SignupcontrollerCubit() : super(SignupcontrollerInitial());
  // Signuprepo repo = getIt<Signuprepo>();
  // void signupfunc(Usermodel user) async {
  //   emit(Signupcontrollerloading());
  //   await Future.delayed(Duration(seconds: 2));
  //   Either<Failuerresponse, Userresponsemodel> response = await repo.signup(
  //     user,
  //   );
  //   response.fold((e) {
  //     return emit(Signupcontrollerfailure(message: errorvalidator(e)));
  //   }, (r) => emit(Signupcontrollersucess()));
  // }
}
