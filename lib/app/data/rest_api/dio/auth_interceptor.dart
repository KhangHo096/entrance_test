import 'package:dio/dio.dart' as dio;
import 'package:entrance_test/app/data/utils/storage_utils.dart';
import 'package:get/get.dart';

class AuthInterceptor extends dio.Interceptor {
  @override
  void onRequest(
    dio.RequestOptions options,
    dio.RequestInterceptorHandler handler,
  ) {
    final requestUrl = options.uri.toString();
    if (!requestUrl.contains('signup') && !requestUrl.contains('signin')) {
      String accessToken = Get.find<StorageUtils>().getAccessToken();
      if (accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }
    options.receiveDataWhenStatusError = true;
    super.onRequest(options, handler);
  }
}
