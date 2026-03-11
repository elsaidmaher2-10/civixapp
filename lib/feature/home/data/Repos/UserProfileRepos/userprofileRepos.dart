import 'package:citifix/core/database/remote/api/ApiConstant.dart';
import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/database/remote/error/ServerExciptionmodel.dart';
import 'package:citifix/core/database/remote/error/failureResponse.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:citifix/feature/home/data/Models/UserProfileModel/userProfile.dart';
import 'package:dartz/dartz.dart';

class Userprofilerepos {
  Userprofilerepos(this.service, this.internetChecker);
  Apiservice service;
  InternetChecker internetChecker;
  Future<Either<FailureResponse, UserProfile>> getuserInfo() async {
    if (!await internetChecker.checkInternet()) {
      return left(
        FailureResponse(errors: [Constantmanger.nointernet], statusCode: 1),
      );
    }
    try {
      final response = await service.get(path: Apiconstant.getUserProfile);
      return right(UserProfile.fromJson(response));
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

 



//Elsaidmaher@@500 d45549048a@webxio.pro