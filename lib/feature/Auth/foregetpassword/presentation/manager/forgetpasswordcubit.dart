import 'package:civixapp/core/database/remote/api/ApiService.dart';
import 'package:civixapp/core/service/networkchecker.dart';
import 'package:civixapp/feature/Auth/foregetpassword/data/repo/ForgetpasswordRepo.dart';
import 'package:civixapp/feature/Auth/foregetpassword/presentation/manager/ForgetpasswordState.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Forgetpasswordcubit extends Cubit<Forgetpasswordstate> {
  Forgetpasswordcubit() : super(ForgetpasswordstatecontrollerInitial());
  Forgetpasswordrepo forgetpasswordrepo = Forgetpasswordrepo(
    Apiservice(Dio()),
    InternetChecker(),
  );
  forgetpassword({required email}) async {
    emit(ForgetpasswordstatecontrollerLoading());
    await Future.delayed(Duration(seconds: 3));
    final result = await forgetpasswordrepo.SendOtP(email: email);

    result.fold(
      (e) => emit(
        ForgetpasswordstatecontrollerFailure(message: e.errors.join("-")),
      ),
      (r) => emit(ForgetpasswordstatecontrollerSuccess(r)),
    );
  }
}
