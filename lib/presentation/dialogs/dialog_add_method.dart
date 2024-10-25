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

  List<String> privateTypes = [];
  String selected = 'void';

  @override
  void initState() {
    ctrReturn1.text = 'Object';
    ctrName.text = '';
    privateTypes.addAll(homeCtr.privateTypes);
    privateTypes.add('Custom');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      // ==== return
      const Text('Return'),
      CustomDropDownWidget(
        elements: privateTypes,
        onBuilder: (index) => Text(privateTypes[index]),
        onSelected: (value) {
          setState(() {
            selected = value;
            ctrReturn1.text = value;
          });
        },
      ),
      // show textField
      Visibility(
        visible: selected == 'Custom',
        child: TextField(
          controller: ctrReturn1,
          decoration: const InputDecoration(
            labelText: 'Return',
            border: OutlineInputBorder(),
          ),
          onChanged: (_) => setState(() {}),
        ).paddingSymmetric(vertical: 15.0),
      ),

      // ==== name method
      const Text('Name Method').paddingAll(7.0),
      TextField(
        controller: ctrName,
        decoration: const InputDecoration(
          labelText: 'Name Method',
          border: OutlineInputBorder(),
        ),
        onChanged: (_) => setState(() {}),
      ),
      // ==== params
      const Text('Parameters').paddingAll(7.0),
      TextField(
        controller: ctrParams,
        decoration: const InputDecoration(
          labelText: 'Parameters',
          border: OutlineInputBorder(),
        ),
        onChanged: (_) => setState(() {}),
      ),
      // ==== params
      const Divider(),
      const Text('Result:'),
      Text('Future<${ctrReturn1.text}> ${ctrName.text}(${ctrParams.text});'),
      const Divider(),
      const SizedBox(height: 10.0),
      // ==== button confirm
      SizedBox(
        height: 40.0,
        width: 200.0,
        child: ElevatedButton(
          onPressed: () {
            if (ctrName.text.trim().isEmpty) return;
            if (ctrReturn1.text.trim().isEmpty) return;

            final method = MethodsModel(
              name: ctrName.text.trim(),
              return1: 'ApiResponse',
              return2: ctrReturn1.text.trim(),
              params1: ctrParams.text.trim(),
              params2: ctrParams.text.trim(),
              content: 'throw("Here code");',
            );
            widget.onConfirm.call(method);
          },
          child: const Text('Saved'),
        ),
      ),
    ]);
  }
}
