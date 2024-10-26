// ignore_for_file: non_constant_identifier_names

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

/// Here is a succinct explanation of the ApiRest class definition:
///
/// Class Overview
///
/// The ApiRest class is a utility class for making HTTP requests to a REST
/// API.
///
/// It provides a simple way to send GET, POST, PUT, DELETE, and HEAD requests
/// to a specified URL with optional headers, query parameters, and body data.
///
/// Class Methods
///
/// * request<T>: Sends an HTTP request to the specified URL with optional
/// body data and headers. Returns a Future containing an ApiRestResponse
/// object with the response code, status, and parsed response body.
/// * requestRead: Sends a GET request to the specified URL and returns the
/// response body as a string.
/// * requestReadBytes: Sends a GET request to the specified URL and returns
/// the response body as a byte array.
///
/// Note that the request method is the main method of the class, and it uses
/// a switch statement to determine which HTTP method to use based on the
/// method property of the class. The requestRead and requestReadBytes
/// methods are simpler and only send GET requests.
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
      {Object? body, bool bodyIsJson = false}) async {
    ///
    /// Check body no null
    if ((method != ApiMethod.get) &&
        (method != ApiMethod.head) &&
        (method != ApiMethod.delete) &&
        (body == null)) {
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
      final query = ApiService2.queryFromJson(queryParameters!);
      path = "$path$query";
    }

    /// url
    Uri uri = Uri.parse('$urlBase$path');

    String def = '';
    try {
      def = jsonEncode({"code": 404, "status": false});
    } on Exception catch (e) {
      debugPrint(e.toString());
    }

    /// initialization
    http.Response response = http.Response(def, 404);

    /// check method
    switch (method) {
      case ApiMethod.get:
        try {
          response = await http.get(
            uri,
            headers: headers,
          );
        } catch (e) {
          debugPrint(e.toString());
        }
        break;
      case ApiMethod.post:
        try {
          final resp = await ApiService2.post(
            url: uri,
            body: body,
            header: headers,
          );
          if (resp != null) {
            response = resp;
          } else {
            response = await http.post(
              uri,
              body: bodyIsJson ? body : jsonEncode(body),
              headers: headers,
              encoding: encoding,
            );
          }
        } catch (e) {
          debugPrint(e.toString());
          response = await http.post(
            uri,
            body: bodyIsJson ? body : jsonEncode(body),
            headers: headers,
            encoding: encoding,
          );
        }

        break;
      case ApiMethod.put:
        try {
          final resp = await ApiService2.put(
            url: uri,
            body: body,
            header: headers,
          );
          if (resp != null) {
            response = resp;
          } else {
            response = await http.put(
              uri,
              body: bodyIsJson ? body : jsonEncode(body),
              headers: headers,
              encoding: encoding,
            );
          }
        } catch (e) {
          debugPrint(e.toString());
          response = await http.put(
            uri,
            body: bodyIsJson ? body : jsonEncode(body),
            headers: headers,
            encoding: encoding,
          );
        }
        break;
      case ApiMethod.delete:
        try {
          final resp = await ApiService2.delete(
            url: uri,
            header: headers,
          );
          if (resp != null) {
            response = resp;
          } else {
            response = await http.delete(
              uri,
              body: bodyIsJson ? body : jsonEncode(body),
              headers: headers,
              encoding: encoding,
            );
          }
        } catch (e) {
          debugPrint(e.toString());
          response = await http.delete(
            uri,
            body: bodyIsJson ? body : jsonEncode(body),
            headers: headers,
            encoding: encoding,
          );
        }
        break;
      case ApiMethod.patch:
        try {
          final resp = await ApiService2.patch(
            url: uri,
            body: body,
            header: headers,
          );
          if (resp != null) {
            response = resp;
          } else {
            response = await http.patch(
              uri,
              body: bodyIsJson ? body : jsonEncode(body),
              headers: headers,
              encoding: encoding,
            );
          }
        } catch (e) {
          debugPrint(e.toString());
          response = await http.post(
            uri,
            body: bodyIsJson ? body : jsonEncode(body),
            headers: headers,
            encoding: encoding,
          );
        }

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
      debugPrint('*' * 40);
      debugPrint('- Timestamp: ${DateTime.now()}');
      debugPrint('- Url: $uri');
      debugPrint('- Method: ${method.name.toUpperCase()}');
      if (headers != null) debugPrint('- Headers: ${jsonEncode(headers)}');
      debugPrint('- Code Status: $code');
      if (body != null) debugPrint('- body: $body');
      debugPrint('- Response: $respObject');
      debugPrint('*' * 40);
    } else {
      debugPrint('ApiRest - Response ${status ? 'SUCCESS' : 'FAIL'} => $uri');
    }

    return ApiRestResponse(
      code: code,
      status: status,
      response: response,
      parseResponse: respObject,
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
      {String headerAuthorization = 'Authorization',
      Map<String, String>? allHeaders}) {
    final map = {
      'Content-Type': 'application/json; charset=UTF-8',
      headerAuthorization: token,
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
  final T? parseResponse;

  ApiRestResponse({
    required this.code,
    required this.response,
    this.status = false,
    this.parseResponse,
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
        parseResponse: respObject ?? this.parseResponse,
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
      parseResponse: respObject,
    );
  }
}

// ============================================================

class ApiService2 {
  //---- HEADERs

  static final HEADERS_SIMPLE = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  static final HEADERS_FORM_DATA = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  static Map<String, String> HEADERS_AUTH(String token) {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": token,
    };
  }

  static String basicAuth(
      {required String username, required String password}) {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    return basicAuth;
  }

  //----- Query's
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

  //---- URL
  static Uri getUrl({required url, required endpoint, dynamic params}) =>
      params != null
          ? Uri.https(url, endpoint, params)
          : Uri.https(url, endpoint);
  //--------
  static getBody(http.Response response) {
    String b = utf8.decode(response.bodyBytes);
    final json = jsonDecode(b);
    return json;
  }

  static Future<Uint8List> getResponse(String path) async {
    final url = Uri.parse(path);
    final response = await http.get(url);
    return response.bodyBytes;
  }

  /// GET
  static Future<http.Response?> get({
    required Uri url,
    bool printResp = false,
    bool printUrl = true,
    Map<String, String>? header,
    int timeOut = 80,
  }) async {
    try {
      var response = await http
          .get(
            url,
            headers: header ?? HEADERS_SIMPLE,
          )
          .timeout(Duration(seconds: timeOut));
      if (printUrl) {
        debugPrint(
            'Response GET status: ${response.statusCode} || ${url.path}');
      }
      if (printResp) debugPrint('Response body: ${response.body}');
      return response;
    } catch (_) {
      return null;
    }
  }

  /// POST
  static Future<http.Response?> post({
    required Uri url,
    required body,
    bool printResp = false,
    Map<String, String>? header,
    int timeOut = 80,
    bool isFormData = false,
  }) async {
    try {
      var response = await http
          .post(
            url,
            body: isFormData ? body : jsonEncode(body),
            headers: header ?? HEADERS_SIMPLE,
          )
          .timeout(Duration(seconds: timeOut));
      debugPrint(
          'Response POST status: ${response.statusCode}  || ${url.path}');
      if (printResp) debugPrint('Response body: ${response.body}');
      return response;
    } catch (_) {
      return null;
    }
  }

  /// PUT
  static Future<http.Response?> put({
    required Uri url,
    required body,
    bool printResp = false,
    Map<String, String>? header,
    int timeOut = 80,
    bool isFormData = false,
  }) async {
    try {
      var response = await http
          .put(
            url,
            body: isFormData ? body : jsonEncode(body),
            headers: header ?? HEADERS_SIMPLE,
          )
          .timeout(Duration(seconds: timeOut));
      debugPrint('Response PUT status: ${response.statusCode}  || ${url.path}');
      if (printResp) debugPrint('Response body: ${response.body}');
      return response;
    } catch (_) {
      return null;
    }
  }

  /// DELETE
  static Future<http.Response?> delete({
    required Uri url,
    bool printResp = false,
    Map<String, String>? header,
    int timeout = 300,
  }) async {
    try {
      var response = await http
          .delete(
            url,
            headers: header ?? HEADERS_SIMPLE,
          )
          .timeout(Duration(seconds: timeout));
      debugPrint(
          'Response DELETE status: ${response.statusCode} || ${url.path}');
      if (printResp) debugPrint('Response body: ${response.body}');
      return response;
    } catch (_) {
      return null;
    }
  }

  /// PATCH
  static Future<http.Response?> patch({
    required Uri url,
    required body,
    bool printResp = false,
    Map<String, String>? header,
    int timeOut = 80,
    bool isFormData = false,
  }) async {
    try {
      var response = await http
          .patch(
            url,
            body: isFormData ? body : jsonEncode(body),
            headers: header ?? HEADERS_SIMPLE,
          )
          .timeout(Duration(seconds: timeOut));
      debugPrint('Response PUT status: ${response.statusCode}  || ${url.path}');
      if (printResp) debugPrint('Response body: ${response.body}');
      return response;
    } catch (_) {
      return null;
    }
  }

// notification push services
  static Future<void> sendMessageFirebaseCloud(
      {required String tokenSend,
      required String authorization,
      String title = '',
      String content = '',
      Map<String, dynamic>? data,
      bool printResp = false,
      int timeOut = 300}) async {
    // header
    Map<String, String> headersAuth = {
      "Authorization": authorization,
      "Content-Type": 'application/json',
    };

    // body send
    Map<String, dynamic> body = {
      "to": tokenSend,
      "notification": {"title": title, "body": content},
      "data": data ?? {}
    };

    try {
      var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
      var response = await http
          .post(
            url,
            body: jsonEncode(body),
            headers: headersAuth,
          )
          .timeout(Duration(seconds: timeOut));
      debugPrint('Response status: ${response.statusCode}');
      if (printResp) debugPrint('Response body: ${response.body}');
    } catch (_) {}
  }
}
