
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// class Signuprepo {
//   Signuprepo(this.service);
//   Apiservice service;
//   Future<Either<Failuerresponse, Userresponsemodel>> signup(
//     Usermodel user,
//   ) async {
//     try {
//       Map response = await service.post(
//         path: Apiconstant.apiendpoint,
//         data: FormData.fromMap({
//           "firstName": user.firstName,
//           "lastName": user.lastName,
//           "email": user.email,
//           "phone": user.phone,
//           "password": user.password,
//           "image": await MultipartFile.fromFile(
//             user.image.path,
//             filename: user.image.path.split("/").last,
//           ),
//         }),
//       );

//       return right(Userresponsemodel.fromjson(response));
//     } on Serverexpctionmodel catch (e) {
//       final d = Failuerresponse.fromjson(e.message as Map);
//       return left(Failuerresponse(error: d.error, statusCode: e.statuscode));
//     } catch (e) {
//       return left(Failuerresponse(error: [e.toString()], statusCode: 500));
//     }
//   }
// }
