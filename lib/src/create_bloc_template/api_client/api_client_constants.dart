import 'package:project_manager/src/utils.dart';

class ApiClientConstants{
  static String apiUtils= """
import 'package:dio/dio.dart';
import 'package:{{package_name}}/model/api_models/api_error.dart';

class ApiUtils {
  ApiUtils._();

  static ApiError getApiError(DioError error) {
    final response = error.response;
    if (response != null) {
      final data = response.data;
      if (data != null) {
        return ApiError.fromJson(data);
      } else {
        return ApiError();
      }
    } else {
      return ApiError.fromMessage(error.message);
    }
  }
}
  """;

  static String dioClient = """
import 'package:dio/dio.dart';
import 'package:{{package_name}}/preferences/preferences_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    const _baseUrl = 'http://restapi.adequateshop.com/api';  // TODO: paste your API's baseUrl here...
    final BaseOptions _options = BaseOptions(
        sendTimeout: 30000,
        connectTimeout: 30000,
        receiveTimeout: 30000,
        baseUrl: _baseUrl,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });

    _dio = Dio(_options);
    _dio.interceptors.add(AuthorizationInterceptor());
    _dio.interceptors.add(LoggingInterceptor());
  }

  Dio getDio() => _dio;
}

class AuthorizationInterceptor extends InterceptorsWrapper {
  final _preferences = GetIt.I<PreferencesManager>();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Send user token in headers if it is available
    final token = await _preferences.getUserToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer <token>';  /// TODO: add your token 
    }

    super.onRequest(options, handler);
  }
}

class LoggingInterceptor extends InterceptorsWrapper {
  // todo disable for release builds
  final _logger = GetIt.I<Logger>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d(options.path);
    _logger.d(options.queryParameters.toString());
    _logger.d(options.headers.toString());
    _logger.d(options.data);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d(response.data);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final errorMessage = err.message;
    final errorData = err.response?.data;
    _logger.e(errorMessage);
    if (errorData != null) {
      _logger.e(errorData);
    }
    super.onError(err, handler);
  }
}
  """;
}
