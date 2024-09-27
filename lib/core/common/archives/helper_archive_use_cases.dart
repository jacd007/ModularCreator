class HelperArchiveUseCases {
  HelperArchiveUseCases._();

  static String create(String name) {
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
