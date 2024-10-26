import 'package:creador_modular/core/core_m.dart';
import 'package:flutter/material.dart';

import '../../modules/modules_m.dart';
import '../presentation_m.dart';

class AddMethodDialog extends StatefulWidget {
  final ValueChanged<dynamic> onConfirm;
  const AddMethodDialog({required this.onConfirm, super.key});

  @override
  State<AddMethodDialog> createState() => _AddMethodDialogState();
}

class _AddMethodDialogState extends State<AddMethodDialog> {
  final homeCtr = Get.find<HomeController>();

  final ctrName = TextEditingController();
  final ctrParams = TextEditingController();
  final ctrReturn1 = TextEditingController();
  final ctrContent = TextEditingController();

  MethodTypes methodType = MethodTypes.get;

  List<String> privateTypes = [];
  String selected = 'void';

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    final name = homeCtr.nameClass.trim();
    final content = HelperArchiveProvider.jsonContent(name);

    ctrReturn1.text = 'Object';
    ctrName.text = '';
    ctrContent.text = content;
    privateTypes.addAll(homeCtr.privateTypes);
    privateTypes.add('Custom');
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    const hintStyle = TextStyle(color: Colors.grey);

    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        // ==== return
        const Text('Return'),
        ResponsiveWidget(
          desktopScreen: Row(children: [
            Flexible(
              child: _dropDown(),
            ),
            if (selected == 'Custom') const SizedBox(width: 10.0),
            // show textField
            Visibility(
              visible: selected == 'Custom',
              child: Expanded(
                child: _editTextReturn(hintStyle),
              ),
            ),
          ]),
          mobileScreen: Flexible(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              _dropDown(),
              // show textField
              Visibility(
                visible: selected == 'Custom',
                child: _editTextReturn(hintStyle),
              ),
            ]),
          ),
        ),
        // ==== name method
        const Text('Name Method').paddingAll(7.0),
        _editTextName(hintStyle),
        // ==== params
        const Text('Parameters').paddingAll(7.0),
        _editTextParams(hintStyle),
        // ==== content
        const Text('Content').paddingAll(7.0),
        _editTextContent(hintStyle),
        const Divider(),
        // ==== type
        _dropDownMethodType(),
        // ==== result
        const Divider(),
        const Text('Result:'),
        Text('Future<${ctrReturn1.text}> ${ctrName.text}(${ctrParams.text});'),
        const Divider(),
        const SizedBox(height: 10.0),
        // ==== button confirm
        _buttonConfirm(),
      ]),
    );
  }

  SizedBox _buttonConfirm() {
    return SizedBox(
      height: 40.0,
      width: 200.0,
      child: ElevatedButton(
        onPressed: () {
          if (ctrName.text.trim().isEmpty) return;
          if (ctrReturn1.text.trim().isEmpty) return;
          if (ctrContent.text.trim().isEmpty) return;

          final method = MethodsModel(
            name: ctrName.text.trim(),
            return1: 'ApiResponse',
            return2: ctrReturn1.text.trim(),
            params1: ctrParams.text.trim(),
            params2: ctrParams.text.trim(),
            content: ctrContent.text.trim(),
            methodTypes: methodType,
          );
          widget.onConfirm.call(method);
        },
        child: const Text('Saved'),
      ),
    );
  }

  TextField _editTextContent(TextStyle hintStyle) {
    return TextField(
      controller: ctrContent,
      minLines: 2,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Content',
        hintStyle: hintStyle,
        labelStyle: ctrContent.text.isEmpty ? hintStyle : null,
        border: const OutlineInputBorder(),
      ),
      onChanged: (_) => setState(() {}),
    );
  }

  TextField _editTextParams(TextStyle hintStyle) {
    return TextField(
      controller: ctrParams,
      decoration: InputDecoration(
        labelText: 'Parameters',
        hintStyle: hintStyle,
        labelStyle: ctrParams.text.isEmpty ? hintStyle : null,
        border: const OutlineInputBorder(),
      ),
      onChanged: (_) => setState(() {}),
    );
  }

  TextField _editTextName(TextStyle hintStyle) {
    return TextField(
      controller: ctrName,
      decoration: InputDecoration(
        labelText: 'Name Method',
        hintStyle: hintStyle,
        labelStyle: ctrName.text.isEmpty ? hintStyle : null,
        border: const OutlineInputBorder(),
      ),
      onChanged: (_) => setState(() {}),
    );
  }

  Widget _editTextReturn(TextStyle hintStyle) {
    return TextField(
      controller: ctrReturn1,
      decoration: InputDecoration(
        labelText: 'Return',
        hintStyle: hintStyle,
        labelStyle: ctrReturn1.text.isEmpty ? hintStyle : null,
        border: const OutlineInputBorder(),
      ),
      onChanged: (_) => setState(() {}),
    ).paddingSymmetric(vertical: 15.0);
  }

  Widget _dropDown() {
    return CustomDropDownWidget<String>(
      elements: privateTypes,
      widthItem: 210.0,
      onBuilder: (index) => Text(privateTypes[index]),
      onSelected: (value) {
        setState(() {
          selected = value;
          ctrReturn1.text = value;
        });
      },
    );
  }

  Widget _dropDownMethodType() {
    return CustomDropDownWidget<MethodTypes>(
      elements: MethodTypes.values,
      widthItem: 210.0,
      onBuilder: (index) => Text(MethodTypes.values[index].name.toUpperCase()),
      onSelected: (value) {
        setState(() {
          methodType = value;
        });
      },
    );
  }
}
