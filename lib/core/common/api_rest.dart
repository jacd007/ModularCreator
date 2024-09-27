import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Method Type request
enum ApiMethod {
  get,
  post,
  put,
  delete,
  head,
  patch,
}

class ApiRest {
  /// [urlBase] String Url base to request
  /// * Example: https://api.projectname.com
  String urlBase;

  /// [endpoint] String path Url endpoint
  /// * Example: /users
  String endpoint;

  /// [queryParameters] String query parameters
  /// * Example:
  /// ```
  /// {'key1': 'value1', 'key2': 'value2'}
  /// ```
  Map<String, dynamic>? queryParameters;

  /// Headers to request.
  /// [headers] default:
  /// ```
  ///  {'Content-Type': 'application/json; charset=UTF-8'}
  /// ```
  Map<String, String>? headers;

  /// Sends an HTTP POST request with the given headers and body to the given
  /// URL.
  ///
  /// [body] sets the body of the request. It can be a [String], a [List] or
  /// a [Map<String, String>].
  /// If it's a String, it's encoded using [encoding] and used as the body
  /// of the request.
  /// The content-type of the request will default to "text/plain".
  ///
  /// If [body] is a List, it's used as a list of bytes for the body of the
  /// request.
  ///
  /// If [body] is a Map, it's encoded as form fields using [encoding].
  /// The content-type of the request will be set to
  /// "application/x-www-form-urlencoded"; this cannot be overridden.
  ///
  /// [encoding] defaults to [utf8].
  ///
  /// For more fine-grained control over the request, use [Request] or
  /// [StreamedRequest] instead.
  ///
  Encoding? encoding;

  /// Method to request
  ApiMethod method;

  /// Token to request
  String token;

  /// Mode debug to print url and codeStatus from request
  bool debugMode;

  ApiRest({
    required this.urlBase,
    this.endpoint = '',
    this.queryParameters,
    this.headers,
    this.encoding,
    this.debugMode = false,
    this.token = '',
    this.method = ApiMethod.get,
  });

  /// Method Get
  Future<ApiRestResponse<T>> request<T>(
      {Map<String, dynamic>? body, bool bodyIsJson = false}) async {
    ///
    /// Check body no null
    if (method != ApiMethod.get && method != ApiMethod.head && body == null) {
      throw UnimplementedError(
        'ApiMethod ${method.name.toUpperCase()} required `Object?` body',
      );
    }

    /// code default
    int code = 404;

    /// status code [bool]
    bool status = false;

    ///
    T? respObject;

    /// Check endpoint
    String path = endpoint.startsWith("/") ? endpoint : "/$endpoint";

    /// Check queryParameters
    if (queryParameters != null) {
      path = "$path?${Uri(queryParameters: queryParameters).query}";
    }

    /// url
    Uri uri = Uri.parse('$urlBase$path');

    /// initialization
    late http.Response response;

    /// check method
    switch (method) {
      case ApiMethod.get:
        response = await http.get(
          uri,
          headers: headers,
        );
        break;
      case ApiMethod.post:
        response = await http.post(
          uri,
          body: bodyIsJson ? body : jsonEncode(body),
          headers: headers,
          encoding: encoding,
        );
        break;
      case ApiMethod.put:
        response = await http.put(
          uri,
          body: bodyIsJson ? body : jsonEncode(body),
          headers: headers,
          encoding: encoding,
        );
        break;
      case ApiMethod.delete:
        response = await http.delete(
          uri,
          body: bodyIsJson ? body : jsonEncode(body),
          headers: headers,
          encoding: encoding,
        );
        break;
      case ApiMethod.head:
        response = await http.head(
          uri,
          headers: headers,
        );
        break;
      default:
        response = await http.get(
          uri,
          headers: headers,
        );
    }

    /// update code status
    code = response.statusCode;

    /// update status
    status = response.statusCode == 200 || response.statusCode == 201;

    /// parse Object response body
    try {
      String b = utf8.decode(response.bodyBytes);
      respObject = jsonDecode(b);
    } on Exception catch (_) {}

    if (debugMode) {
      debugPrint('- Timestamp: ${DateTime.now()}');
      debugPrint('- Url: $uri');
      debugPrint('- Method: ${method.name.toUpperCase()}');
      debugPrint('- Code Status: $code');
      debugPrint('- Response: $respObject');
    }

    return ApiRestResponse(
      code: code,
      status: status,
      response: response,
      respObject: respObject,
    );
  }

  /// read
  Future<String> requestRead() async {
    /// url
    Uri uri = Uri.parse(urlBase);

    final read = await http.read(
      uri,
      headers: headers,
    );

    return read;
  }

  /// read
  Future<Uint8List> requestReadBytes() async {
    /// url
    Uri uri = Uri.parse(urlBase);

    final readBytes = await http.readBytes(
      uri,
      headers: headers,
    );

    return readBytes;
  }
} // end

// ===========================

///
/// [ApiRestOptions]
/// ApiRest Helpers
///
class ApiRestOptions {
  ///
  /// default headers request
  /// Contains:
  ///
  /// * Content-Type : application/json; charset=UTF-8
  ///
  static final headersSimple = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  /// Form Data headers request
  /// Contains:
  ///
  /// * Content-Type : application/x-www-form-urlencoded
  ///
  static final headersFormData = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  /// Authorization headers request
  /// Contains:
  ///
  /// * Content-Type : application/json; charset=UTF-8
  /// * Authorization: [token]
  ///
  static Map<String, String> headersAuth(String token,
      {Map<String, String>? allHeaders}) {
    final map = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": token,
    };

    if (allHeaders != null) {
      map.addAll(allHeaders);
    }

    return map;
  }

  /// Map headers request.
  /// Contains:
  ///
  /// * Content-Type : application/json; charset=UTF-8
  ///
  static Map<String, String> headersMaps(Map<String, String> allHeaders) {
    Map<String, String> map = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    map.addAll(allHeaders);

    return map;
  }

  /// Basic authorization by user and password
  static String basicAuth({required String user, required String password}) {
    String basicAuth = 'Basic ${base64.encode(utf8.encode('$user:$password'))}';
    return basicAuth;
  }

  /// Generate String Query from JsonQuery
  static String queryFromJson(Map<String, dynamic> json) {
    String query = '';
    var keys = json.keys;
    var values = json.values;
    for (int i = 0; i < keys.length; i++) {
      if (i == 0) query += '?${keys.first}=${values.first}';
      if (i != 0) query += '&${keys.elementAt(i)}=${values.elementAt(i)}';
    }
    return query;
  }
}

// ===========================

class ApiRestResponse<T> {
  /// [int] codeStatus request
  final int code;

  /// [bool] status from codeStatus request
  final bool status;

  /// Object [http.Response] response request
  final http.Response response;

  /// Parse [dynamic] response request
  final T? respObject;

  ApiRestResponse({
    required this.code,
    required this.response,
    this.status = false,
    this.respObject,
  });

  ApiRestResponse<T> copyWith({
    int? code,
    bool? status,
    http.Response? response,
    T? respObject,
  }) =>
      ApiRestResponse(
        code: code ?? this.code,
        status: status ?? this.status,
        response: response ?? this.response,
        respObject: respObject ?? this.respObject,
      );

  static ApiRestResponse<T> empty<T>({
    int code = 404,
    bool status = false,
    http.Response? response,
    T? respObject,
  }) {
    return ApiRestResponse(
      code: code,
      status: status,
      response: response ?? http.Response('', 404),
      respObject: respObject,
    );
  }
}
