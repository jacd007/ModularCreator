class HelperArchiveRepository {
  HelperArchiveRepository._();

  static String jsonContent(String name, Map<String, dynamic> json) {
    StringBuffer sb = StringBuffer();

    // ignore: unused_local_variable
    final nameLower = name.toLowerCase();
    final nameMethod = json["name"] ?? '';
    final params1 = json["params2"] ?? '';

    sb.writeln("    final response = await _provider.$nameMethod($params1);");
    sb.writeln("    /// ERROR request");
    sb.writeln("    if (!response.status) {");
    sb.writeln("      // TODO: implement get$name");
    sb.writeln("      return throw('Error');");
    sb.writeln("    }");
    sb.writeln("    final collection = response.parseResponse ;");
    sb.writeln("    return collection;");

    return sb.toString();
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
  /// }
  /// ```
  static String createCustom(
    String name,
    List<Map<String, dynamic>> listMethods,
  ) {
    StringBuffer sb = StringBuffer();

    sb.writeln("\n");
    sb.writeln("import 'package:flutter/material.dart';");
    sb.writeln("\n");
    sb.writeln("import '../${name.toLowerCase()}_m.dart';");
    sb.writeln("\n");
    sb.writeln("class ${name}Repositories extends ${name}RepositoryUseCases {");
    sb.writeln("  final _provider = ${name}Provider();");

    sb.writeln("\n");

    sb.writeln("  @override");
    for (var json in listMethods) {
      sb.writeln(
          "  Future<List<${name}Model>> get$name([String id = " "]) async {");
      sb.writeln(jsonContent(name, json));
      sb.writeln("    }");
    }

    sb.writeln("  }");
    sb.writeln("\n");

    return sb.toString();
  }

  ///
  static String create(String name) {
    return '''

import 'package:flutter/material.dart';

import '../${name.toLowerCase()}_m.dart';

class ${name}Repositories extends ${name}RepositoryUseCases {
  final _provider = ${name}Provider();

  @override
  Future<List<${name}Model>> get$name([String id$name = '']) async {
    List<${name}Model> list = [];

    final response = await _provider.get$name(id$name);

    /// ERROR request
    if (!response.status) {
      // TODO: implement get$name
      return [];
    }

    final collection = response.respObject as List;

    for (var json in collection) {
      final model = ${name}Model.fromJson(json);
      list.add(model);
    }

    return list;
  }

  @override
  Future<bool> post$name(${name}Model ${name.toLowerCase()}) async {
    final body = ${name.toLowerCase()}.toJson();
    final response = await _provider.post$name(body);

    /// ERROR request
    if (!response.status) {
      final data = response.respObject;
      debugPrint('Error post $name: \$data');
      return false;
    }

    final data = response.respObject;
    debugPrint('$name: \$data');

    return true;
  }

  @override
  Future<bool> put$name(String id$name, ${name}Model ${name.toLowerCase()}) async {
    final body = ${name.toLowerCase()}.toJson();
    final response = await _provider.put$name(id$name, body);

    /// ERROR request
    if (!response.status) {
      final data = response.respObject;
      debugPrint('Error put $name: \$data');
      return false;
    }

    final data = response.respObject;
    debugPrint('$name: \$data');

    return true;
  }

  // ============= DANGER ZONE =============

  @override
  Future<bool> delete$name(String id$name) async {
    final response = await _provider.delete$name(id$name);

    /// ERROR request
    if (!response.status) {
      final data = response.respObject;
      debugPrint('Error delete $name: \$data');
      return false;
    }

    final data = response.respObject;
    debugPrint('$name: \$data');

    return true;
  }
}


''';
  }
}
