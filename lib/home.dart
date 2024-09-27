import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'core/core_m.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameClassCtr = TextEditingController();

  final inputCtr = TextEditingController();
  final outputCtr = TextEditingController();

  bool zip = false;
  String text = '';

  @override
  void initState() {
    inputCtr.text = jsonEncode({
      "id": 0,
      "text": "",
      "price": 12.65,
      "show": false,
      "maps": {},
      "lists": ["Type ", "Sample"]
    });

    onChanged(nameClass: 'NameClass', content: inputCtr.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          // elevation: 1,
          flexibleSpace:
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              flex: 8,
              child: Container(
                // width: size.width * 0.92,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: theme.primaryColor,
                child: TextField(
                  controller: nameClassCtr,
                  autofocus: true,
                  cursorColor: Colors.red,
                  style: const TextStyle(color: Colors.white),
                  textAlignVertical: const TextAlignVertical(y: 0),
                  decoration: const InputDecoration(
                      hintText: 'ClassName',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: SizedBox(
                        width: 40.0,
                        child: Center(
                          child: Icon(
                            Icons.class_,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      border: InputBorder.none),
                  onChanged: (content) {
                    onChanged(
                      nameClass: convertSnakeToCamel(content),
                      content: inputCtr.text,
                    );
                  },
                ),
              ),
            ),
            //
            MaterialButton(
              onPressed: onCreateZip,
              child: const Center(
                child: Icon(
                  Icons.build_circle_rounded,
                  size: 30.0,
                ),
              ),
            ),
          ]),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Text(text),
            const SizedBox(height: 20.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // INPUT TEXT
                Expanded(
                  flex: 2,
                  child: Stack(children: [
                    TextField(
                      controller: inputCtr,
                      minLines: 50,
                      maxLines: 1000,
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: const OutlineInputBorder(),
                        contentPadding:
                            const EdgeInsets.fromLTRB(12, 80, 12, 12),
                      ),
                      onChanged: (content) => onChanged(
                        nameClass: convertSnakeToCamel(nameClassCtr.text),
                        content: content,
                      ),
                    ),
                    // copy and paste
                    Positioned(
                      top: 2,
                      right: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          // name class
                          Text(
                            '${nameClassCtr.text}Model',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          // copy
                          Visibility(
                            visible: inputCtr.text.trim().isNotEmpty,
                            child: IconButton(
                              tooltip: 'Copiar',
                              onPressed: () {
                                inputCtr.selection = TextSelection(
                                  baseOffset: 0,
                                  extentOffset: inputCtr.text.length,
                                );
                                copyToClipboard(outputCtr.text, context);
                              },
                              icon: const Icon(Icons.copy),
                            ),
                          ),
                          // paste
                          IconButton(
                            tooltip: 'Pegar',
                            onPressed: () {
                              pasteFromClipboard().then((value) {
                                if (value == null) return;

                                setState(() {
                                  inputCtr.text = value;
                                });

                                onChanged(
                                  nameClass:
                                      convertSnakeToCamel(nameClassCtr.text),
                                  content: inputCtr.text,
                                );
                              });
                            },
                            icon: const Icon(Icons.paste),
                          ),
                        ]),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(width: 20),
                // OUTPUT TEXT
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.iconTheme.color ?? Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 45, 12, 12),
                        child: HighlightableText(
                          text: outputCtr.text.isEmpty
                              ? 'Not Valido'
                              : outputCtr.text,
                          wordsToHighlight: [
                            '${nameClassCtr.text.trim()}Model',
                          ],
                          secondaryWordsToHighlight: [
                            ...HighlightableText.privateTypes,
                          ],
                          tertiaryWordsToHighlight: [
                            'copyWith',
                            'fromJson',
                            'toJson',
                            'fromMap',
                            'toMap',
                            'empty'
                          ],
                        ),
                      ),
                      /*  TextField(
                        controller: outputCtr,
                        minLines: 50,
                        maxLines: 100000,
                        readOnly: true,
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: const OutlineInputBorder(),
                          contentPadding:
                              const EdgeInsets.fromLTRB(12, 80, 12, 12),
                        ),
                      ), */
                      // copy
                      Positioned(
                        top: 2,
                        right: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: IconButton(
                            tooltip: 'Copiar',
                            onPressed: () {
                              outputCtr.selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: outputCtr.text.length,
                              );
                              copyToClipboard(outputCtr.text, context);
                            },
                            icon: const Icon(Icons.copy),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: onCreateZip,
                child: const Text('Crear y Descargar ZIP'),
              ),
            ),
            const SizedBox(height: 20.0),
          ]),
        ));
  }

  void onCreateZip() async {
    onChanged(
      nameClass: convertSnakeToCamel(nameClassCtr.text),
      content: inputCtr.text,
    );

    setState(() => text = 'Construyendo ZIP');
    String name = nameClassCtr.text;

    if (kIsWeb) {
      throw Exception('Web not supported');
    }

    zip = await CustomArchiveDesktop.createZip(
      nameModule: name,
      contentModel: inputCtr.text,
    );
    setState(() {
      text = zip ? 'ZIP Creado Correctamente' : 'ZIP no Creado';
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() => text = '');
    });

    if (zip) nameClassCtr.clear();
  }

  String convertSnakeToCamel(String input) {
    if (input.isEmpty) return '';

    input = input.contains(" ") ? input.replaceAll(" ", "_") : input;
    // input = input.contains("_") ? input.replaceAll("_", "") : input;

    String firstChar = input[0].toUpperCase();
    String lastChar = input[input.length - 1].toLowerCase();
    String middleChars = input.substring(1, input.length - 1);

    return '$firstChar$middleChars$lastChar';
  }

  void onChanged({required String nameClass, required String content}) {
    Map<String, dynamic> fields = {};

    try {
      fields = content.isEmpty ? {} : jsonDecode(content);
      nameClass = nameClass.isEmpty ? "NameClass" : nameClass;
    } on Exception catch (e) {
      debugPrint('Error: $e');
    }

    outputCtr.text = HelperArchiveModel.create(
      name: nameClass,
      fields: fields,
    );
    setState(() {});
  }

  Future<void> copyToClipboard(String text, BuildContext context) async {
    final snackBar = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: text));
    snackBar.showSnackBar(
      const SnackBar(
        content: Text('Texto copiado al portapapeles.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<String?> pasteFromClipboard() async {
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text;
  }
}
