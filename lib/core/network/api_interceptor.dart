import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'Content-Type': 'application/json',
    });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        print("Connection timeout, please try again later");
        break;
      case DioExceptionType.connectionError:
        print("No internet connection");
        break;
      case DioExceptionType.badResponse:
        print("Server error: ${err.response?.statusCode}");
        break;
      case DioExceptionType.cancel:
        print("Request was cancelled");
        break;
      default:
        print("Unexpected error occurred");
        break;
    }
    super.onError(err, handler);
  }
}

class ApiService {
  final Dio _dio;

  ApiService(this._dio) {
    _dio.interceptors.add(ApiInterceptor());
  }

  Future<Response> getRequest(String path,
      {Map<String, dynamic>? queryParams}) async {
    try {
      return await _dio.get(path, queryParameters: queryParams);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postRequest(String path, dynamic data) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> patchRequest(String path, dynamic data) async {
    try {
      return await _dio.patch(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteRequest(String path) async {
    try {
      return await _dio.delete(path);
    } catch (e) {
      rethrow;
    }
  }
}
