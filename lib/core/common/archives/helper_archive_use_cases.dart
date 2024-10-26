class HelperArchiveUseCases {
  HelperArchiveUseCases._();

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
    sb.writeln("import '../../../core/core_m.dart';");
    sb.writeln("import '../${name.toLowerCase()}_m.dart';");

    sb.writeln("\n");
    sb.writeln("abstract class ${name}UseCases {");

    for (var json in listMethods) {
      final nameMethod = json["name"] ?? '';
      final return1 = json["return1"] ?? '';
      final params1 = json["params1"] ?? '';

      sb.writeln("/// $nameMethod");
      sb.writeln("Future<$return1> $nameMethod($params1);");
      sb.writeln("\n");
    }

    sb.writeln("}");
    sb.writeln("\n");

    sb.writeln(
        "// ============================================================");
    sb.writeln("\n");

    sb.writeln("abstract class ${name}RepositoryUseCases {");
    sb.writeln("\n");

    for (var json in listMethods) {
      final nameMethod = json["name"] ?? '';
      final return2 = json["return2"] ?? '';
      final params2 = json["params2"] ?? '';

      sb.writeln("/// $nameMethod");
      sb.writeln("Future<$return2> $nameMethod($params2);");
      sb.writeln("\n");
    }

    sb.writeln("}");
    sb.writeln("\n");

    return sb.toString();
  }

  static String create(String name,
      {List<Map<String, dynamic>> listMethods = const []}) {
    StringBuffer sb = StringBuffer();

    sb.writeln("\n");
    sb.writeln("import '../${name.toLowerCase()}_m.dart';");

    sb.writeln("\n");
    sb.writeln("abstract class ${name}UseCases {");

    sb.writeln("/// get $name");
    sb.writeln("Future<Object> get$name([String id$name = '']);");
    sb.writeln("\n");

    sb.writeln("/// post $name");
    sb.writeln(
        "Future<Object> post$name(Map<String, dynamic> ${name.toLowerCase()});");
    sb.writeln("\n");

    sb.writeln("/// put $name");
    sb.writeln(
        "Future<Object> put$name(String id$name, Map<String, dynamic> ${name.toLowerCase()});");
    sb.writeln("\n");

    sb.writeln("/// delete $name");
    sb.writeln("Future<Object> delete$name(String id$name);");
    sb.writeln("\n");

    sb.writeln("}");
    sb.writeln("\n");

    sb.writeln(
        "// ============================================================");
    sb.writeln("\n");

    sb.writeln("abstract class ${name}RepositoryUseCases {");
    sb.writeln("\n");

    sb.writeln("/// get $name");
    sb.writeln("Future<void> get$name([String id$name = '']);");
    sb.writeln("\n");

    sb.writeln("/// post $name");
    sb.writeln("Future<void> post$name(${name}Model ${name.toLowerCase()});");
    sb.writeln("\n");

    sb.writeln("/// put $name");
    sb.writeln(
        "Future<void> put$name(String id$name, ${name}Model ${name.toLowerCase()});");
    sb.writeln("\n");

    sb.writeln("/// delete $name");
    sb.writeln("Future<void> delete$name(String id$name);");
    sb.writeln("\n");

    sb.writeln("}");
    sb.writeln("\n");

    return sb.toString();
  }
}
