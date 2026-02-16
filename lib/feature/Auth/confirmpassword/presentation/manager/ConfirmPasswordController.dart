import 'package:civixapp/feature/Auth/confirmpassword/data/repo/confirmpasswordrepo.dart';
import 'package:civixapp/feature/Auth/confirmpassword/presentation/manager/ConfirmPasswordState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmPasswordController extends Cubit<ConfirmPasswordControllerState> {
  ConfirmPasswordController(this.confirmpasswordrepo)
    : super(ConfirmPasswordControllerInitial());
  final Confirmpasswordrepo confirmpasswordrepo;
  bool isAsync = false;

  Future<void> createnewpassword({
    required String email,
    required String newPassword,
    required String token,
    required String otp,
  }) async {
    emit(ConfirmPasswordControllerLoading());
    isAsync = true;
    await Future.delayed(const Duration(seconds: 3));
    final result = await confirmpasswordrepo.createnewpassword(
      email: email,
      confirmPassword: newPassword,
      token: token,
      otp: otp,
    );
    isAsync = false;
    result.fold(
      (e) =>
          emit(ConfirmPasswordControllerFailure(message: e.errors.join("-"))),
      (r) => emit(ConfirmPasswordControllerSuccess(r)),
    );
  }
}
