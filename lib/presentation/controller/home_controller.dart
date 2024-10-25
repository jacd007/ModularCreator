import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../core/core_m.dart';
import '../../modules/modules_m.dart';
import '../presentation_m.dart';

class HomeController extends GetxController {
  /// Controller All
  final allCtr = Get.find<AllController>();

  /// state text builder
  var text = ''.obs;

  /// state bool builder
  var zip = false.obs;

  /// loading builder
  var loading = false.obs;

  ///  NAME CLASS
  String nameClass = 'NameClass';
  final nameClassCtr = TextEditingController();

  final List<String> privateTypes = const [
    'Object',
    'int',
    'bool',
    'double',
    'String',
    'List',
    'List<String,dynamic>',
    'Map',
    'Map<String,dynamic>',
    'Map<String, String>',
    "void",
    "dynamic",
  ];

  // TEXT MODEL
  var textModel = "".obs;
  var errorModel = false.obs;
  final textModelCtr = TextEditingController();

  var listMethods = <MethodsModel>[
    MethodsModel(
      name: 'getNameClass',
      return1: 'ApiResponse',
      return2: 'List<Object>',
      params1: '[String idNameClass = ' ']',
      params2: '[String idNameClass = ' ']',
      content: 'throw ("Here code");',
    ),
    MethodsModel(
      name: 'postNameClass',
      return1: 'ApiResponse',
      return2: 'bool',
      params1: 'Map<String, dynamic> body',
      params2: 'Object body',
      content: 'throw ("Here code");',
    ),
    MethodsModel(
      name: 'putNameClass',
      return1: 'ApiResponse',
      return2: 'bool',
      params1: 'String id, Map<String, dynamic> body',
      params2: 'String id, Object body',
      content: 'throw ("Here code");',
    ),
    MethodsModel(
      name: 'deleteNameClass',
      return1: 'ApiResponse',
      return2: 'bool',
      params1: 'String id',
      params2: 'String id',
      content: 'throw ("Here code");',
    ),
  ].obs;

  @override
  void onInit() {
    initHome();
    super.onInit();
  }

  void initHome() {
    // step 1

    nameClassCtr.text = nameClass;

    // step 2

    final map = HelperArchiveModel.map();
    final textM = jsonEncode(map);
    onChanged(nameClass: nameClass, content: textM);
    textModelCtr.text = textM;

    // step 3

    // step 4

    update();
  }

  /// Setter nameClass
  set setNameClass(String value) {
    nameClass = value.trim();
    nameClassCtr.text = value;
    update();
  }

  /// STEP 1 - Name class
  void onChanged({required String nameClass, required String content}) {
    Map<String, dynamic> fields = {};

    try {
      fields = content.isEmpty ? {} : jsonDecode(content);
      nameClass = nameClass.isEmpty ? "NameClass" : nameClass;
    } on Exception catch (e) {
      debugPrint('Error: $e');
    }

    textModel.value = HelperArchiveModel.create(
      name: nameClass.trim(),
      fields: fields,
    );
    update();
  }

  /// STEP 2 - Json Model
  void onChangedJsonModel(String text) {
    try {
      jsonDecode(text);
      errorModel.value = false;
    } catch (_) {
      errorModel.value = true;
    }
    onChanged(nameClass: nameClass, content: text);
  }

  /// STEP 3 - Methods list added
  void addMethod({
    required String nameMethod,
    String returnMethod1 = 'ApiResponse',
    String returnMethod2 = 'Object',
    String params1 = '',
    String params2 = '',
    String content = 'throw ("Here code");',
  }) {
    final map = MethodsModel(
      name: nameMethod,
      return1: returnMethod2,
      return2: returnMethod1,
      params1: params1,
      params2: params2,
      content: content,
    );
    listMethods.add(map);
    update();
  }

  /// STEP 3 - Methods list, show Dialog
  showDialogAdded() {
    showDialog(
      context: Get.context!,
      builder: (_) => AlertDialog(
        content: AddMethodDialog(
          onConfirm: (method) {
            listMethods.add(method);
            update();
            Get.back();
          },
        ),
      ),
    );
  }

  /// STEP 4 - create file zip
  void onCreateZip() async {
    loading.value = true;

    final allCtr = Get.find<AllController>();

    onChanged(
      nameClass: _convertSnakeToCamel(nameClassCtr.text),
      content: textModel.value,
    );

    text.value = 'Construyendo ZIP';
    String name = nameClassCtr.text;

    if (kIsWeb) {
      throw Exception('Web not supported');
    }

    zip.value = await CustomArchiveDesktop.createZip(
      nameModule: name,
      contentModel: textModel.value,
    );

    text.value = zip.value ? 'ZIP Creado Correctamente' : 'ZIP no Creado';

    Future.delayed(const Duration(seconds: 3));
    text.value = '';

    loading.value = false;
    if (zip.value) {
      nameClassCtr.clear();
      allCtr.pageCtr.jumpTo(0.0);
      update();
    }
  }

  String _convertSnakeToCamel(String input) {
    if (input.isEmpty) return '';

    input = input.contains(" ") ? input.replaceAll(" ", "_") : input;
    // input = input.contains("_") ? input.replaceAll("_", "") : input;

    String firstChar = input[0].toUpperCase();
    String lastChar = input[input.length - 1].toLowerCase();
    String middleChars = input.substring(1, input.length - 1);

    return '$firstChar$middleChars$lastChar';
  }
}//** **/

