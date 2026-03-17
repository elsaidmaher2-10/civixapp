import 'dart:math';

import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/database/remote/api/ApiConstant.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final Dio _refreshDio;

  bool _isRefreshing = false;
  final List<({RequestOptions opts, ErrorInterceptorHandler handler})> _queue =
      [];

  AuthInterceptor(this.dio)
    : _refreshDio = Dio(
        BaseOptions(
          baseUrl: Apiconstant.baseurl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = PrefrenceManager().getstring(Constantmanger.accessToken);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    debugPrint('🚀 ${options.method} → ${options.path}');
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    if (error.response?.statusCode != 401) {
      debugPrint('❌ Token refresh failed: ${error.error.toString()}');

      return handler.next(error);
    }

    if (error.requestOptions.extra['retry'] == true) {
      _handleLogout();
      return handler.next(error);
    }

    final refreshToken = PrefrenceManager().getstring(
      Constantmanger.refreshToken,
    );
    if (refreshToken == null || refreshToken.isEmpty) {
      _handleLogout();
      return handler.next(error);
    }

    if (_isRefreshing) {
      _queue.add((opts: error.requestOptions, handler: handler));
      return;
    }

    _isRefreshing = true;
    final refreshed = await _fetchNewAccessToken(refreshToken);
    _isRefreshing = false;

    if (!refreshed) {
      _handleLogout();
      for (final item in _queue) item.handler.next(error);
      _queue.clear();
      return handler.next(error);
    }

    await _retryRequest(error.requestOptions, handler);
    for (final item in _queue) {
      await _retryRequest(item.opts, item.handler);
    }
    _queue.clear();
  }

  Future<void> _retryRequest(
    RequestOptions opts,
    ErrorInterceptorHandler handler,
  ) async {
    final newToken = PrefrenceManager().getstring(Constantmanger.accessToken);

    final headers = Map<String, dynamic>.from(opts.headers)
      ..['Authorization'] = 'Bearer $newToken';
    final extra = Map<String, dynamic>.from(opts.extra)..['retry'] = true;

    try {
      final response = await dio.request(
        opts.path,
        options: Options(
          method: opts.method,
          headers: headers,
          extra: extra,
          responseType: opts.responseType,
          contentType: opts.contentType,
        ),
        data: opts.data,
        queryParameters: opts.queryParameters,
      );
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  Future<bool> _fetchNewAccessToken(String refreshToken) async {
    try {
      final response = await _refreshDio.post(
        '/Account/refresh-token',
        data: {'refreshToken': refreshToken},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final newToken = response.data[Constantmanger.accessToken];
        if (newToken != null) {
          PrefrenceManager().setstring(Constantmanger.accessToken, newToken);
          return true;
        }
      }
      return false;
    } catch (e) {
      debugPrint('❌ Token refresh failed: $e');
      return false;
    }
  }

  void _handleLogout() {
    PrefrenceManager().remove(Constantmanger.accessToken);
    PrefrenceManager().remove(Constantmanger.refreshToken);
    final context = navigatorKey.currentContext;
    if (context != null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.login,
        (route) => false,
      );
    }
  }
}
