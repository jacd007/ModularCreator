import 'package:flutter/material.dart';

import '../../core/core_m.dart';
import '../presentation_m.dart';

class HomeStep2Screen extends StatelessWidget {
  const HomeStep2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return GetBuilder<HomeController>(builder: (homeCtr) {
      return Scaffold(
        body: SafeArea(
          child: ResponsiveWidget(
            // IS DESKTOP
            desktopScreen: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // text Json input
                  Expanded(
                    flex: 1,
                    child: ExpansionTile(
                      title: const Text('Json Input'),
                      initiallyExpanded: true,
                      children: [_jsonInput(homeCtr, maxPercentHeight: 0.80)],
                    ),
                  ),
                  // text Json output
                  Expanded(
                    flex: 2,
                    child: ExpansionTile(
                      title: const Text('Json Output'),
                      initiallyExpanded: true,
                      children: [_jsonOutput(homeCtr, maxPercentHeight: 0.80)],
                    ),
                  ),
                ]),
            // IS MOBILE
            mobileScreen: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(15, 0, 20, 80),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                // text Json input
                ExpansionTile(
                  title: const Text('Json Input'),
                  initiallyExpanded: true,
                  children: [
                    _jsonInput(homeCtr),
                  ],
                ),
                const Divider(),
                // text Json output
                ExpansionTile(
                  title: const Text('Json Output'),
                  children: [_jsonOutput(homeCtr)],
                ),
              ]),
            ),
          ),
        ),
      );
    });
  }

  Widget _jsonInput(HomeController homeCtr, {maxPercentHeight = 0.60}) {
    return SizedBox(
      height: Get.height * maxPercentHeight,
      child: TextField(
        controller: homeCtr.textModelCtr,
        minLines: 20,
        maxLines: 20,
        style: TextStyle(
          color: homeCtr.errorModel.value ? Colors.red : null,
        ),
        onChanged: homeCtr.onChangedJsonModel,
      ),
    );
  }

  Widget _jsonOutput(HomeController homeCtr, {maxPercentHeight = 0.50}) {
    const tertiaryWordsToHighlight = [
      'copyWith',
      'fromJson',
      'toJson',
      'fromMap',
      'toMap',
      'empty'
    ];
    return SizedBox(
      height: Get.height * maxPercentHeight,
      child: SingleChildScrollView(
        child: Column(children: [
          HighlightableText(
            text: homeCtr.textModel.value.isEmpty
                ? 'Not Valido'
                : homeCtr.textModel.value,
            wordsToHighlight: [
              '${homeCtr.nameClass.trim()}Model',
            ],
            secondaryWordsToHighlight: [
              ...HighlightableText.privateTypes,
            ],
            tertiaryWordsToHighlight: tertiaryWordsToHighlight,
          ),
        ]),
      ),
    );
  }
}
