class HelperArchiveProvider {
  HelperArchiveProvider._();

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
