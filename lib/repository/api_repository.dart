import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';

class ApiRepository {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.get("API_URL"),
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  // GET request
  static Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? query,
    bool setBarer = false,
    bool setTempToken = false,
  }) async {
    await _setBearerToken(setBarer, setTempToken);
    return await _dio.get(endpoint, queryParameters: query);
  }

  // POST request
  static Future<Response> post(
    String endpoint, {
    Map<String, dynamic>? jsonBody,
    FormData? formDataBody,
    bool setBarer = false,
    bool setTempToken = false,
  }) async {
    await _setBearerToken(setBarer, setTempToken);
    return await _dio.post(
      endpoint,
      data: formDataBody ?? jsonBody,
      options: Options(
        contentType:
            formDataBody != null ? "multipart/form-data" : "application/json",
      ),
    );
  }

  // PUT request
  static Future<Response> put(
    String endpoint, {
    Map<String, dynamic>? jsonBody,
    bool setBarer = false,
    bool setTempToken = false,
  }) async {
    await _setBearerToken(setBarer, setTempToken);
    return await _dio.put(endpoint, data: jsonBody);
  }

  // PATCH request
  static Future<Response> patch(
    String endpoint, {
    Map<String, dynamic>? jsonBody,

    bool setBarer = false,
    bool setTempToken = false,
  }) async {
    await _setBearerToken(setBarer, setTempToken);
    return await _dio.patch(endpoint, data: jsonBody);
  }

  // DELETE request
  static Future<Response> delete(
    String endpoint, {
    Map<String, dynamic>? jsonBody,
    bool setBarer = false,
    bool setTempToken = false,
  }) async {
    await _setBearerToken(setBarer, setTempToken);
    return await _dio.delete(endpoint, data: jsonBody);
  }

  static Future<void> _setBearerToken(bool userToken, bool setTempToken) async {
    if (userToken) {
      // Purpose : user verification
      if (setTempToken) {
        final tempToken = await AppPreferences.getTempAccessToken();

        if (tempToken.isNotEmpty) {
          _dio.options.headers['Authorization'] = 'Bearer $tempToken';
        } else {
          _dio.options.headers.remove('Authorization');
        }
      } else {
        final accessToken = await AppPreferences.getAccessToken();

        if (accessToken.isNotEmpty) {
          _dio.options.headers['Authorization'] = 'Bearer $accessToken';
        } else {
          _dio.options.headers.remove('Authorization');
        }
      }
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }
}
