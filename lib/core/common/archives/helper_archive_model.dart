import 'dart:convert';

import 'package:flutter/material.dart';

class HelperArchiveModel {
  HelperArchiveModel._();

  //
  static Map<String, dynamic> map({String contentModel = ''}) {
    Map<String, dynamic> map = {
      "id": 0,
      "name": "",
      "price": 0.99,
      "show": false,
      "maps": {},
      "lists": ["Type ", "Sample"]
    };

    try {
      map = contentModel.isEmpty ? map : jsonDecode(contentModel);
    } on Exception catch (e) {
      debugPrint('Error _model parse: $e');
    }

    return map;
  }

  /// Generate model
  static String create(
      {required String name, required Map<String, dynamic> fields}) {
    StringBuffer sb = StringBuffer();

    // Class header
    sb.writeln('class ${name}Model {');

    // Final variables definition
    fields.forEach((key, value) {
      String type = _inferType(value);
      String newKey = _convertSnakeToCamel(key);
      newKey = key.trim().isEmpty ? "field" : newKey;
      sb.writeln('  final $type $newKey;');
    });

    // Constructor
    sb.writeln('\n /// Constructor');

    sb.writeln('  ${name}Model({');
    fields.forEach((key, value) {
      // String type = _inferType(value);
      String newKey = _convertSnakeToCamel(key);
      newKey = key.trim().isEmpty ? "field" : newKey;
      sb.writeln('    required this.$newKey,');
    });
    sb.writeln('  });');

    // copyWith method
    sb.writeln('\n /// Copy with Method');
    sb.writeln('  ${name}Model copyWith({');
    fields.forEach((key, value) {
      String type = _inferType(value);
      String newKey = _convertSnakeToCamel(key);
      newKey = key.trim().isEmpty ? "field" : newKey;
      sb.writeln('    $type? $newKey,');
    });
    sb.writeln('  }) {');
    sb.writeln('    return ${name}Model(');
    fields.forEach((key, value) {
      String newKey = _convertSnakeToCamel(key);
      newKey = key.trim().isEmpty ? "field" : newKey;
      sb.writeln('      $newKey: $newKey ?? this.$newKey,');
    });
    sb.writeln('    );');
    sb.writeln('  }');

    // fromJson method
    sb.writeln('\n /// from Json method');
    sb.writeln('  factory ${name}Model.fromJson(Map<String, dynamic> json) {');
    sb.writeln('    return ${name}Model(');
    fields.forEach((key, value) {
      String type = _inferType(value, isNullable: true);
      String newKey = _convertSnakeToCamel(key);
      newKey = key.trim().isEmpty ? "field" : newKey;
      String defaultValue = _typeDefault(type);

      // nameVar: json['name_var'] as String? ?? '',
      // sb.writeln('      $newKey: json[\'$key\'] as $type ?? $defaultValue,');

      // nameVar: json['name_var'] ?? '',
      sb.writeln('      $newKey: json[\'$key\'] ?? $defaultValue,');
    });
    sb.writeln('    );');
    sb.writeln('  }');

    // toJson method
    sb.writeln('\n /// to Json method');
    sb.writeln('  Map<String, dynamic> toJson() {');
    sb.writeln('    return {');
    fields.forEach((key, value) {
      String newKey = _convertSnakeToCamel(key);
      newKey = key.trim().isEmpty ? "field" : newKey;
      sb.writeln('      \'$key\': $newKey,');
    });
    sb.writeln('    };');
    sb.writeln('  }');

    // 'empty' factory method with non-null parameters and default values
    sb.writeln('\n /// Empty method');
    sb.writeln('  factory ${name}Model.empty({');

    fields.forEach((key, value) {
      String type = _inferType(value);
      String newKey = _convertSnakeToCamel(key);
      newKey = key.trim().isEmpty ? "field" : newKey;

      String defaultValue = _typeDefault(type);

      sb.writeln('    $type $newKey = $defaultValue,');
    });

    sb.writeln('}) {');

    // Return constructor with default values
    sb.writeln('    return ${name}Model(');

    fields.forEach((key, value) {
      String newKey = _convertSnakeToCamel(key);
      newKey = key.trim().isEmpty ? "field" : newKey;
      sb.writeln('      $newKey: $newKey,');
    });

    sb.writeln('    );');
    sb.writeln('}');

    // Class closure
    sb.writeln('}');

    return sb.toString();
  }
}

// =================

// Function to infer the type from the value
String _inferType(dynamic value, {bool isNullable = false}) {
  String type = 'Object';
  if (value is String) type = 'String';
  if (value is int) type = 'int';
  if (value is double) type = 'double';
  if (value is bool) type = 'bool';

  if (value is List) type = 'List';

  if (value is Map) type = 'Map<String, dynamic>';

  return isNullable ? '$type?' : type;
}

String _typeDefault(String type) {
  type = type.replaceAll("?", "");
  String defaultValue;

  if (type == 'String') {
    defaultValue = '\'\'';
  } else if (type == 'int') {
    defaultValue = '0';
  } else if (type == 'double') {
    defaultValue = '0.0';
  } else if (type == 'bool') {
    defaultValue = 'false';
  } else if (type == 'List') {
    defaultValue = 'const []';
  } else if (type == 'Map' || type == 'Map<String, dynamic>') {
    defaultValue = 'const {}';
  } else {
    defaultValue = 'null';
  }
  return defaultValue;
}

String _convertSnakeToCamel(String input, {String defaultKey = ''}) {
  // Dividir el string por el guion bajo
  List<String> parts = input.split('_');

  // Convertir la primera parte a minúsculas y las siguientes a mayúsculas
  String result = parts[0].toLowerCase() +
      parts.skip(1).map((word) {
        if (word.isEmpty) return defaultKey;
        return word[0].toUpperCase() + word.substring(1);
      }).join('');

  return result;
}
