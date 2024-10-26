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

  var listMethods = <MethodsModel>[].obs;

  /// text UseCases
  var textUseCase = ''.obs;

  /// text ProviderUseCases
  var textProviderUseCase = ''.obs;

  /// text RepositoryUseCases
  var textRepositoryUseCase = ''.obs;

  @override
  void onInit() {
    initHome();
    super.onInit();
  }

  void initHome() {
    // 0
    _listMethodDefaults();
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

  void _listMethodDefaults() {
    listMethods.value = [
      MethodsModel(
        name: 'get$nameClass',
        return1: 'ApiRestResponse',
        return2: 'List<${nameClass}Model>',
        params1: '[String id$nameClass = ""]',
        params2: '[String id$nameClass = ""]',
        content: HelperArchiveProvider.jsonContent(nameClass, 'get'),
        methodTypes: MethodTypes.get,
      ),
      MethodsModel(
        name: 'post$nameClass',
        return1: 'ApiRestResponse',
        return2: 'bool',
        params1: 'Map<String, dynamic> body',
        params2: '${nameClass}Model body',
        content: HelperArchiveProvider.jsonContent(nameClass, 'post'),
        methodTypes: MethodTypes.post,
      ),
      MethodsModel(
        name: 'put$nameClass',
        return1: 'ApiRestResponse',
        return2: 'bool',
        params1: 'String id, Map<String, dynamic> body',
        params2: 'String id, ${nameClass}Model body',
        content: HelperArchiveProvider.jsonContent(nameClass, 'put'),
        methodTypes: MethodTypes.put,
      ),
      MethodsModel(
        name: 'delete$nameClass',
        return1: 'ApiRestResponse',
        return2: 'bool',
        params1: 'String id',
        params2: 'String id',
        content: HelperArchiveProvider.jsonContent(nameClass, 'delete'),
        methodTypes: MethodTypes.delete,
      ),
    ];
    update();
  }

  /// Setter nameClass
  set setNameClass(String value) {
    nameClass = value.trim();
    nameClassCtr.text = value;
    update();
    _listMethodDefaults();
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
    required MethodTypes methodTypes,
    String returnMethod1 = 'ApiRestResponse',
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
      methodTypes: methodTypes,
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

  /// STEP 3 - Methods list, update helper
  void updateStep3() {
    final date = DateTime.now();
    final list = listMethods.map((e) => e.toJson()).toList();

    final text = HelperArchiveUseCases.createCustom(nameClass, list);
    debugPrint('${date.toIso8601String()}, update UseCases step3');
    textUseCase.value = text;

    final text2 = HelperArchiveProvider.createCustom(nameClass, list);
    debugPrint('${date.toIso8601String()}, update Provider step3');
    textProviderUseCase.value = text2;

    final text3 = HelperArchiveRepository.createCustom(nameClass, list);
    debugPrint('${date.toIso8601String()}, update Repository step3');
    textRepositoryUseCase.value = text3;
  }

  /// STEP 4 - create file zip
  void onCreateZip() async {
    loading.value = true;

    final allCtr = Get.find<AllController>();

    text.value = 'Construyendo ZIP';
    String name = nameClassCtr.text;

    if (kIsWeb) {
      throw Exception('Web not supported');
    }

    zip.value = await CustomArchiveDesktop.createZipCustom(
      nameModule: name.toLowerCase(),
      contentModule: HelperArchiveModule.create(name.toLowerCase()),
      contentModel: textModel.value,
      contentProvider: textProviderUseCase.value,
      contentRepository: textRepositoryUseCase.value,
      contentUseCase: textUseCase.value,
    );

    text.value = zip.value ? 'ZIP Creado Correctamente' : 'ZIP no Creado';

    Future.delayed(const Duration(seconds: 3));
    text.value = '';

    loading.value = false;
    if (zip.value) {
      nameClassCtr.clear();
      allCtr.currentPage = 0;
      allCtr.pageCtr.jumpToPage(0);
      update();
    }
  }

  void deleteMethod(int index) {
    listMethods.removeAt(index);
    update();
  }
}//** **/

