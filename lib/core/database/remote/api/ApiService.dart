import 'package:civixapp/core/database/remote/api/ApiConstant.dart';
import 'package:civixapp/core/database/remote/api/ApiConsumer.dart';
import 'package:civixapp/core/database/remote/api/ApihanderDioExcp.dart';
import 'package:dio/dio.dart';

class Apiservice extends Apiconsumer {
  late Dio dio;

  Apiservice() {
    dio = Dio(
      BaseOptions(
        baseUrl: Apiconstant.baseurl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  @override
  get({required Object body, Map? queryprams}) async {
    // TODO: implement GET if needed
  }

  @override
  post({
    required Object body,
    Map<String, dynamic>? queryprams,
    required String path,
  }) async {
    try {
      Response response = await dio.post(
        path,
        data: body,
        queryParameters: queryprams,
      );
      return response.data;
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }
}
