import 'package:civixapp/core/database/remote/api/ApiService.dart';
import 'package:civixapp/core/database/remote/error/failureResponse.dart';
import 'package:civixapp/feature/Auth/register/data/models/usermodel.dart';
import 'package:civixapp/feature/Auth/register/data/repo/SignupRepo.dart';
import 'package:civixapp/feature/Auth/register/presentation/manager/cubit/signupcontroller_state.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupcontrollerCubit extends Cubit<SignupcontrollerState> {
  SignupcontrollerCubit() : super(SignupcontrollerInitial());
  Signuprepo repo = Signuprepo(Apiservice(Dio()));
  void signupfunc(Usermodel user) async {
    emit(Signupcontrollerloading());
    await Future.delayed(Duration(seconds: 2));
    Either<FailureResponse, String> response = await repo.signup(user);
    response.fold((e) {
      return emit(Signupcontrollerfailure(message: e.errors.join("-")));
    }, (r) => emit(Signupcontrollersucess(r)));
  }
}
