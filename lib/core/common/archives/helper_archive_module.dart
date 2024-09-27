class HelperArchiveModule {
  HelperArchiveModule._();

  static String create(String name) {
    StringBuffer sb = StringBuffer();

    const d2 = 'models/';
    const d3 = 'provider/';
    const d4 = 'repositories/';
    const d5 = 'useCases/';

    sb.writeln('export "$d2$name.dart";');
    sb.writeln('export "$d3${name}_provider.dart";');
    sb.writeln('export "$d4${name}_repositories.dart";');
    sb.writeln('export "$d5${name}_use_cases.dart";');

    return sb.toString();
  }
}
