import 'dart:io';
import 'package:flutter/material.dart';

import 'package:archive/archive.dart';
import 'package:file_picker/file_picker.dart';

import 'archive_m.dart';

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

  static Future<bool> createZip(
      {required String nameModule, String contentModel = ''}) async {
    final name = nameModule.toLowerCase();
    final nameM = nameModule;

    final dirFile1 = '$name/$name';
    final dir2 = '$name/models/';
    final dir3 = '$name/provider/';
    final dir4 = '$name/repositories/';
    final dir5 = '$name/useCases/';

    // Muestra un diálogo para seleccionar la ruta de descarga
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    final fields = HelperArchiveModel.map(contentModel: contentModel);

    String contentFile1 = HelperArchiveModule.create(name);
    String contentFile2 =
        HelperArchiveModel.create(name: nameM, fields: fields);
    String contentFile3 = HelperArchiveProvider.create(nameM);
    String contentFile4 = HelperArchiveRepository.create(nameM);
    String contentFile5 = HelperArchiveUseCases.create(nameM);

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
}







// ===========================================================================


