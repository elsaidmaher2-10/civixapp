import 'dart:convert';
import 'dart:io';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/database/remote/api/ApiConstant.dart';
import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/database/remote/error/ServerExciptionmodel.dart';
import 'package:citifix/core/database/remote/error/failureResponse.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:citifix/feature/Profile/data/Models/UserProfileModel/userProfile.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Userprofilerepos {
  Userprofilerepos(this.service, this.internetChecker);
  Apiservice service;
  InternetChecker internetChecker;
  Future<Either<FailureResponse, UserProfile>> getuserInfo() async {
    try {
      String? cachedUser = PrefrenceManager().getstring("user_profile_data");
      if (cachedUser != null) {
        return Right(UserProfile.fromJson(jsonDecode(cachedUser)));
      }

      if (!await internetChecker.checkInternet()) {
        return left(
          FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
        );
      }

      final response = await service.get(path: Apiconstant.getUserProfile);
      final user = UserProfile.fromJson(response);

      PrefrenceManager().setstring(
        "user_profile_data",
        jsonEncode(user.toJson()),
      );

      return right(user);
    } on Serverexciptionmodel catch (e) {
      return left(_handleServerException(e));
    } catch (e) {
      return left(FailureResponse(errors: [e.toString()], statusCode: 500));
    }
  }

  Future<Either<FailureResponse, UserProfile>> updateuserImage(
    File image,
  ) async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }

    try {
      FormData formData = FormData.fromMap({
        "File": await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      final response = await service.patch(
        path: Apiconstant.updateiamge,
        body: formData,
      );

      final updatedUser = UserProfile.fromJson(response);

      PrefrenceManager().setstring(
        "user_profile_data",
        jsonEncode(updatedUser.toJson()),
      );
      return right(updatedUser);
    } on Serverexciptionmodel catch (e) {
      return left(_handleServerException(e));
    } catch (e) {
      return left(FailureResponse(errors: [e.toString()], statusCode: 500));
    }
  }

  FailureResponse _handleServerException(Serverexciptionmodel e) {
    if (e.errors is Map?) {
      return FailureResponse.fromJson(e.errors);
    }
    return FailureResponse(
      errors: [e.errors.toString()],
      statusCode: e.statuscode,
    );
  }
}
