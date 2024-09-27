class HelperArchiveRepository {
  HelperArchiveRepository._();

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
