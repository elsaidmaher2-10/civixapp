import 'package:citifix/feature/Auth/confirmpassword/data/repo/confirmpasswordrepo.dart';
import 'package:citifix/feature/Auth/confirmpassword/presentation/manager/ConfirmPasswordState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmPasswordController extends Cubit<ConfirmPasswordControllerState> {
  ConfirmPasswordController(this.confirmpasswordrepo)
    : super(ConfirmPasswordControllerInitial());
  final Confirmpasswordrepo confirmpasswordrepo;
  Future<void> createnewpassword({
    required String email,
    required String newPassword,
    required String otp,
  }) async {
    emit(ConfirmPasswordControllerLoading());
    final result = await confirmpasswordrepo.createnewpassword(
      email: email,
      confirmPassword: newPassword,
      otp: otp,
    );
    result.fold(
      (e) =>
          emit(ConfirmPasswordControllerFailure(message: e.errors.join("-"))),
      (r) => emit(ConfirmPasswordControllerSuccess(r)),
    );
  }
}
