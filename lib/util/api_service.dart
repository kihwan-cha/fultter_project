import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com", // API 기본 URL
    connectTimeout: Duration(seconds: 5), // 연결 타임아웃
    receiveTimeout: Duration(seconds: 5), // 응답 타임아웃
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  // ✅ GET 요청 함수
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      Response response = await _dio.get(endpoint, queryParameters: queryParams);
      return response.data; // JSON 데이터 반환
    } catch (e) {
      return _handleError(e);
    }
  }

  // ✅ POST 요청 함수
  Future<dynamic> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      Response response = await _dio.post(endpoint, data: data);
      return response.data;
    } catch (e) {
      return _handleError(e);
    }
  }

  // ✅ 에러 핸들링 함수
  dynamic _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return "⏳ Connection timeout!";
        case DioExceptionType.receiveTimeout:
          return "📶 Receive timeout!";
        case DioExceptionType.badResponse:
          return "❌ Server error: ${error.response?.statusCode}";
        case DioExceptionType.cancel:
          return "⚠️ Request cancelled!";
        case DioExceptionType.unknown:
          return "🚨 Unknown error!";
        default:
          return "⚡ Something went wrong!";
      }
    }
    return "⚡ Unexpected error: $error";
  }
}
