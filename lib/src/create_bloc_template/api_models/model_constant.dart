class ModelConstant{
  static String apiError = """
class ApiError {
  final String? error;

  ApiError({this.error});

  String? getFirstErrorFromList(List<String>? error) {
    if (error == null || error.isEmpty) return null;
    return error.first;
  }

  factory ApiError.fromMessage(String message) {
    return ApiError(error: message);
  }

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(error: json['error']);
  }
}
  """;

  static String apiResponse = """
import 'api_error.dart';
import 'api_status.dart';

class ApiResponse<T> {
  ApiStatus status;   
  ApiError? error;
  T? data;

  ApiResponse({required this.status, this.error, this.data});

  ApiResponse.success({this.status = ApiStatus.success, this.data});

  ApiResponse.error({this.status = ApiStatus.error, this.error});
}
  """;

  static String apiStatus = """
enum ApiStatus { success, error } 
  """;
}