import 'package:civixapp/core/database/remote/api/ApiConstant.dart';
import 'package:civixapp/core/database/remote/api/ApiService.dart';
import 'package:civixapp/core/database/remote/error/ServerExciptionmodel.dart';
import 'package:civixapp/core/database/remote/error/failureResponse.dart';
import 'package:civixapp/feature/Auth/register/data/models/usermodel.dart';
import 'package:dartz/dartz.dart';

// /api/Account/signup
class Signuprepo {
  Signuprepo(this.service);
  Apiservice service;
  Future<Either<FailureResponse, String>> signup(Usermodel user) async {
    try {
      final response = await service.post(
        path: Apiconstant.signupendpoint,
        body: {
          "nationalId": user.nationalId,
          "fullName": user.firstName + user.lastName,
          "email": user.email,
          "phoneNumber": user.phone,
          "password": user.password,
          "address": user.address,

          "dateOfBirth": user.dateOfBirth,

          "role": user.role,
        },
      );

      return right(response);
    } on Serverexciptionmodel catch (e) {
      if (e.errors is Map?) {
        final d = FailureResponse.fromJson(e.errors);
        return left(d);
      } else {
        return left(
          FailureResponse(
            errors: [e.errors.toString()],
            statusCode: e.statuscode,
          ),
        );
      }
    } catch (e) {
      return left(FailureResponse(errors: [e.toString()], statusCode: 500));
    }
  }
}
