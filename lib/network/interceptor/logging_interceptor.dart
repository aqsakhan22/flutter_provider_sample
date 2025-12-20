import 'dart:convert';
import 'package:dio/dio.dart';

class AppLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("🔵 [REQUEST]");
    print("➡️ Method: ${options.method}");
    print("➡️ URL: ${options.uri}");
    print("➡️ Headers: ${jsonEncode(options.headers)}");

    if (options.data != null) {
      print("➡️ Body:");
      _prettyPrintJson(options.data);
    }

    if (options.queryParameters.isNotEmpty) {
      print("➡️ Query Params:");
      _prettyPrintJson(options.queryParameters);
    }

    print("────────────────────────────────────────────\n");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("🟢 [RESPONSE]");
    print("⬅️ Status: ${response.statusCode}");
    print("⬅️ URL: ${response.requestOptions.uri}");

    if (response.data != null) {
      print("⬅️ Data:");
      _prettyPrintJson(response.data);
    }

    print("────────────────────────────────────────────\n");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("🔴 [ERROR]");
    print("❌ Message: ${err.message}");
    print("❌ Type: ${err.type}");
    print("❌ URL: ${err.requestOptions.uri}");

    if (err.response?.data != null) {
      print("❌ Server Response:");
      _prettyPrintJson(err.response?.data);
    }

    print("────────────────────────────────────────────\n");
    handler.next(err);
  }




  void _prettyPrintJson(dynamic data) {
    try {
      const encoder = JsonEncoder.withIndent("  ");
      print(encoder.convert(data));
    } catch (_) {
      print(data);
    }
  }
  void logError(DioException error, ErrorInterceptorHandler handler, StackTrace stackTrace, String customMessage,[Response? response]) {
    // ... implementation
  }

}
