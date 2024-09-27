import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

import 'core/core_m.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = TextEditingController();
  bool zip = false;
  String text = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Crear y Descargar Archivos')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              TextField(
                controller: controller,
              ),
              const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() => text = 'Construyendo ZIP');
                    String name = controller.text;
                    // name to capitalice
                    // TODO: here code
                    if (kIsWeb) {
                      throw Exception('Web not supported');
                    } else {
                      zip = await CustomArchiveDesktop
                          .selectDirectoryAndCreateZip(
                        nameModule: name,
                      );
                      setState(() {
                        text =
                            zip ? 'ZIP Creado Correctamente' : 'ZIP no Creado';
                      });
                      Future.delayed(const Duration(seconds: 3), () {
                        setState(() => text = '');
                      });
                    }
                    if (zip) controller.clear();
                  },
                  child: const Text('Crear y Descargar ZIP'),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(text),
            ]),
          )),
    );
  }
}
