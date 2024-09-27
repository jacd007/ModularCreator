import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CustomArchiveDesktop {
  // Constructor privado
  CustomArchiveDesktop._();

  static Future<void> createZipFile(
      {required Map<String, String> filesContent,
      required String directoryPath,
      String fileName = 'archivos'}) async {
    // Crea un nuevo archivo ZIP
    final archive = Archive();

    // Agrega cada archivo al archivo ZIP
    filesContent.forEach((fileName, content) {
      final file = ArchiveFile(fileName, content.length, content.codeUnits);
      archive.addFile(file);
    });

    // Codifica el archivo ZIP
    final bytes = ZipEncoder().encode(archive);

    // Crea un archivo ZIP en la ruta seleccionada por el usuario
    final zipFile = File('$directoryPath/$fileName.zip');

    // Escribe el contenido del ZIP en el archivo
    await zipFile.writeAsBytes(bytes!);

    debugPrint('Archivo ZIP creado en: ${zipFile.path}');
  }

  // DESKTOP MODE

  static Future<bool> selectDirectoryAndCreateZip(
      {required String nameModule}) async {
    final name = nameModule.toLowerCase();

    final dirFile1 = '$name/$name';
    final dir2 = '$name/models/';
    final dir3 = '$name/provider/';
    final dir4 = '$name/repositories/';
    final dir5 = '$name/useCases/';

    // Muestra un diálogo para seleccionar la ruta de descarga
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    String contentFile1 = _fileModule(name);
    String contentFile2 = _models(nameModule);
    String contentFile3 = _provider(nameModule);
    String contentFile4 = _repositories(nameModule);
    String contentFile5 = _useCases(nameModule);

    if (selectedDirectory != null) {
      // Definir contenido de los archivos
      Map<String, String> filesContent = {
        '${dirFile1}_m.dart': contentFile1,
        '$dir2$name.dart': contentFile2,
        '$dir3${name}_provider.dart': contentFile3,
        '$dir4${name}_repositories.dart': contentFile4,
        '$dir5${name}_use_cases.dart': contentFile5,
      };

      /// create zip file
      await createZipFile(
        filesContent: filesContent,
        directoryPath: selectedDirectory,
        fileName: name,
      );

      debugPrint('ZIP creado y guardado en: $selectedDirectory');
      return true;
    } else {
      debugPrint('No se seleccionó ninguna ruta de descarga');
      return false;
    }
  }

  // WEB MODE
  // TODO: FIX ERROR CREATE ZIP
  /* static Future<void> selectDirectoryAndCreateZipFromWeb(
      {required String nameModule}) async {
    final name = nameModule.toLowerCase();

    final dirFile1 = '$name/$name';
    final dir2 = '$name/models/';
    final dir3 = '$name/provider/';
    final dir4 = '$name/repositories/';
    final dir5 = '$name/useCases/';

    // Muestra un diálogo para seleccionar la ruta de descarga
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    String contentFile1 = _fileModule(name);
    String contentFile2 = _models(nameModule);
    String contentFile3 = _models(nameModule);
    String contentFile4 = _models(nameModule);
    String contentFile5 = _models(nameModule);

    if (selectedDirectory != null) {
      // Definir contenido de los archivos
      Map<String, String> filesContent = {
        '${dirFile1}_m.dart': contentFile1,
        '$dir2$name.dart': contentFile2,
        '$dir3${name}_provider.dart': contentFile3,
        '$dir4${name}_repositories.dart': contentFile4,
        '$dir5${name}_use_cases.dart': contentFile5,
      };

      /// create zip file
      // Crea un nuevo archivo ZIP
      final archive = Archive();

      // Agrega cada archivo al archivo ZIP
      filesContent.forEach((fileName, content) {
        final file = ArchiveFile(fileName, content.length, content.codeUnits);
        archive.addFile(file);
      });

      // Codifica el archivo ZIP
      final bytes = ZipEncoder().encode(archive);

      // Crea un Blob con el contenido del archivo ZIP
      final blob = webHtml.Blob([bytes]);
      final url = webHtml.Url.createObjectUrlFromBlob(blob);

      // Crea un enlace para descargar el archivo ZIP
      final anchor = webHtml.AnchorElement(href: url)
        ..setAttribute('download', 'archivos.zip')
        ..click();

      // Libera el objeto URL
      webHtml.Url.revokeObjectUrl(url);

      debugPrint('ZIP creado y guardado en: $selectedDirectory');
    } else {
      debugPrint('No se seleccionó ninguna ruta de descarga');
    }
  } */
}

// file module
String _fileModule(String name) {
  const d2 = 'models/';
  const d3 = 'provider/';
  const d4 = 'repositories/';
  const d5 = 'useCases/';

  return '''
export "$d2$name.dart";
export "$d3${name}_provider.dart";
export "$d4${name}_repositories.dart";
export "$d5${name}_use_cases.dart";
''';
}

// models
String _models(String name) {
  return '''

class ${name}Model {
  /// constructor
  ${name}Model();

  /// fromJson
  static ${name}Model fromJson(Map<String, dynamic> json) {
    return ${name}Model();
  }

  Map<String, dynamic> toJson() => {};
}


''';
}

// provider
String _provider(String name) {
  return '''

import '../../../core/core_m.dart';
import '../${name.toLowerCase()}_m.dart';

class ${name}Provider extends ${name}UseCases {
  final _apiRest = ApiRest(urlBase: url_base);

  @override
  Future<ApiRestResponse> get$name([String id$name = '']) async {
    final token = await SharedPrefs.getString('shared_JWT');

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
    final token = await SharedPrefs.getString('shared_JWT');

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
    final token = await SharedPrefs.getString('shared_JWT');

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
    final token = await SharedPrefs.getString('shared_JWT');

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

// repositories
String _repositories(String name) {
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

// UseCases
String _useCases(String name) {
  return '''

import '../${name.toLowerCase()}_m.dart';

abstract class ${name}UseCases {
  /// get $name
  Future<Object> get$name([String id$name = '']);

  /// post $name
  Future<Object> post$name(Map<String, dynamic> ${name.toLowerCase()});

  /// put $name
  Future<Object> put$name(String id$name, Map<String, dynamic> ${name.toLowerCase()});

  /// delete $name
  Future<Object> delete$name(String id$name);
}

// ==============================================================================

abstract class ${name}RepositoryUseCases {
  /// get $name
  Future<void> get$name([String id$name = '']);

  /// post $name
  Future<void> post$name(${name}Model ${name.toLowerCase()});

  /// put $name
  Future<void> put$name(String id$name, ${name}Model ${name.toLowerCase()});

  /// delete $name
  Future<void> delete$name(String id$name);
}

''';
}
