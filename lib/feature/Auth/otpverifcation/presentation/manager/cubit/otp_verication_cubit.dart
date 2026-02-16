import 'package:civixapp/core/database/remote/api/ApiService.dart';
import 'package:civixapp/feature/Auth/otpverifcation/data/models/otpmodel.dart';
import 'package:civixapp/feature/Auth/otpverifcation/data/repo/OtpRepo.dart';
import 'package:civixapp/feature/Auth/otpverifcation/presentation/manager/cubit/otp_verication_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpVericationCubit extends Cubit<OtpVericationState> {
  OtpVericationCubit() : super(OtpVericationInitial());

  final OtpRepo otpRepo = OtpRepo(Apiservice(Dio()));

  Future<void> verifyOtp(OtpModel otp, {required bool isReset}) async {
    emit(OtpVericationLoading());

    final result = await otpRepo.OtPVerification(otp, isReset);

    result.fold((failure) => emit(OtpVericationFailure(failure)), (success) {
      if (isReset) {
        emit(OtpVericationSucces(success.toString()));
      } else {
        emit(OtpVericationSucces(success));
      }
    });
  }

  Future<void> sendOtp(String email) async {
    final result = await otpRepo.SendOtP(email);

    result.fold(
      (failure) => print(failure.errors),
      (success) => print(success),
    );
  }
}
