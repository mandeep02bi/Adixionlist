import 'package:dio/dio.dart';
import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Core/helper/token_storage_service.dart';
import 'package:doctor/Core/networking/api_const.dart';
import 'package:doctor/Presentation/AuthScreen/LoginSC.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  DioFactory._();
  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!.options.connectTimeout = timeOut;
      dio!.options.receiveTimeout = timeOut;
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptor() {
    dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          const publicEndpoints = [
            ApiConst.registerEndpoint,
            ApiConst.loginEndpoint,
            ApiConst.forgotPasswordEndpoint,
            ApiConst.verifyOtpEndpoint,
            ApiConst.resetPasswordEndpoint,
          ];

          // Check if request is not for a public endpoint
          if (!publicEndpoints.any((endpoint) => options.path.contains(endpoint))) {
            final token = await getIt<TokenStorageService>().getAccessToken();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            // clear tokens using dynamic token service
            await getIt<TokenStorageService>().clearAll();
            // navigate to login screen
            Get.offAll(() => const Loginsc());
          }
          return handler.next(e);
        },
      ),
    );
    dio!.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
    );
  }
}
