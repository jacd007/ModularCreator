class HelperArchiveProvider {
  HelperArchiveProvider._();

  static String jsonContent(String name, [String method = 'get']) {
    StringBuffer sb = StringBuffer();
    sb.writeln("\n");
    sb.writeln("//    final token = await SharedPrefs.getString(shared_JWT);");
    sb.writeln("\n");
    sb.writeln("//    _apiRest");
    sb.writeln("//      ..endpoint = Endpoint.\${name.toLowerCase()}");
    sb.writeln(
        "//      ..headers = ApiRestOptions.headersAuth('Token \$token')");
    sb.writeln("//      ..debugMode = false");
    sb.writeln("//      ..method = ApiMethod.$method;");
    sb.writeln("\n");
    sb.writeln("//    final response = await _apiRest.request();");
    sb.writeln("//    return response;");
    sb.writeln("// TODO: implement getOffers");
    sb.writeln("throw UnimplementedError();");
    sb.writeln("\n");

    final content = sb.toString();
    return content;
  }

  /// * Example:
  /// ```
  /// {
  ///   'name': name,
  ///   'return1': return1,
  ///   'return2': return2,
  ///   'params1': params1,
  ///   'params2': params2,
  ///   'content': content,
  ///   'methodTypes': methodTypes.index,
  /// }
  /// ```
  static String createCustom(
    String name,
    List<Map<String, dynamic>> listMethods,
  ) {
    StringBuffer sb = StringBuffer();

    sb.writeln("\n");
    sb.writeln("import '../../../core/core_m.dart';");
    sb.writeln("import '../${name.toLowerCase()}_m.dart';");

    sb.writeln("\n");
    sb.writeln("class ${name}Provider extends ${name}UseCases {");

    sb.writeln("  final _apiRest = ApiRest(urlBase: url_base);");

    sb.writeln("\n");

    for (var json in listMethods) {
      // ignore: unused_local_variable
      final nameLower = name.toLowerCase();
      final nameMethod = json["name"] ?? '';
      final return1 = json["return1"] ?? '';
      final params1 = json["params1"] ?? '';
      final content = json["content"] ?? 'throw("Here code");';

      final method = json["methodTypes"] ?? 'get';

      // ignore: unused_local_variable
      String body = method == 'post' || method == 'put' || method == 'patch'
          ? 'body: body'
          : '';

      sb.writeln("  @override");
      sb.writeln("Future<$return1> $nameMethod($params1) async {");
      // sb.writeln("// final token = await SharedPrefs.getString(shared_JWT);");
      // sb.writeln("\n");
      // sb.writeln("// _apiRest");
      // sb.writeln("// ..endpoint = '\${Endpoint.$nameLower}/\$id$name'");
      // sb.writeln("// ..headers = ApiRestOptions.headersAuth('Token \$token')");
      // sb.writeln("// ..debugMode = false");
      // sb.writeln("// ..method = ApiMethod.$method;");
      // sb.writeln("\n");
      // sb.writeln("// final response = await _apiRest.request($body);");
      // sb.writeln("// return response;");
      sb.writeln("$content");
      sb.writeln("  }");

      sb.writeln("\n");
    }

    sb.writeln(
        "  // ==============================================================");
    sb.writeln(
        "  // ========================== ANYTHING ==========================");

    sb.writeln("}");
    sb.writeln("\n");

    return sb.toString();
  }

  ///
  static String create(String name) {
    return '''

import '../../../core/core_m.dart';
import '../${name.toLowerCase()}_m.dart';

class ${name}Provider extends ${name}UseCases {
  final _apiRest = ApiRest(urlBase: url_base);

  @override
  Future<ApiRestResponse> get$name([String id$name = '']) async {
    final token = await SharedPrefs.getString(shared_JWT);

    _apiRest
      ..endpoint = '\${Endpoint.${name.toLowerCase()}}/\$id$name'
      ..headers = ApiRestOptions.headersAuth('Token \$token')
      ..debugMode = false
      ..method = ApiMethod.get;

    final response = await _apiRest.request();
    return response;
  }

  @override
  Future<ApiRestResponse> post$name(Map<String, dynamic> ${name.toLowerCase()}) async {
    final token = await SharedPrefs.getString(shared_JWT);

    _apiRest
      ..endpoint = Endpoint.${name.toLowerCase()}
      ..headers = ApiRestOptions.headersAuth('Token \$token')
      ..debugMode = false
      ..method = ApiMethod.post;

    final response = await _apiRest.request(body: ${name.toLowerCase()});
    return response;
  }

  @override
  Future<ApiRestResponse> put$name(
      String id$name, Map<String, dynamic> ${name.toLowerCase()}) async {
    final token = await SharedPrefs.getString(shared_JWT);

    _apiRest
      ..endpoint = '\${Endpoint.${name.toLowerCase()}}/\$id$name'
      ..headers = ApiRestOptions.headersAuth('Token \$token')
      ..debugMode = false
      ..method = ApiMethod.put;

    final response = await _apiRest.request(body: ${name.toLowerCase()});
    return response;
  }

  // ============= DANGER ZONE =============

  @override
  Future<ApiRestResponse> delete$name(String id$name) async {
    final token = await SharedPrefs.getString(shared_JWT);

    _apiRest
      ..endpoint = '\${Endpoint.${name.toLowerCase()}}/\$id$name'
      ..headers = ApiRestOptions.headersAuth('Token \$token')
      ..debugMode = false
      ..method = ApiMethod.delete;

    final response = await _apiRest.request();
    return response;
  }

  // ==============================================================
  // ========================== ANYTHING ==========================
}


''';
  }
}
