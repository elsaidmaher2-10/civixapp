import 'package:civixapp/core/database/remote/api/ApiService.dart';
import 'package:civixapp/core/database/remote/error/failureResponse.dart';
import 'package:civixapp/feature/Auth/otpverifcation/data/models/otpSuccessModel.dart';
import 'package:civixapp/feature/Auth/otpverifcation/data/models/otpmodel.dart';
import 'package:civixapp/feature/Auth/otpverifcation/data/repo/OtpRepo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_verication_state.dart';

class OtpVericationCubit extends Cubit<OtpVericationState> {
  OtpVericationCubit() : super(OtpVericationInitial());
  OtpRepo otpRepo = OtpRepo(Apiservice(Dio()));
  OtpVerication(OtpModel otp, {required isreset}) {
    emit(OtpVericationLoading());
    otpRepo.OtPVerification(otp, isreset).then(
      (onValue) => onValue.fold(
        (L) => emit(OtpVericationFailure(L)),
        (r) => emit(OtpVericationSucces(r)),
      ),
    );
  }

  SendOtP(String Email) async {
    await otpRepo.SendOtP(Email).then(
      (onValue) => onValue.fold(
        (ifLeft) => print(ifLeft.errors),
        (ifRight) => print(ifRight),
      ),
    );
  }
}
