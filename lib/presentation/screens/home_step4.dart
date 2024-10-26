import 'package:flutter/material.dart';

import '../../core/common/common_m.dart';
import '../presentation_m.dart';

class HomeStep4Screen extends StatelessWidget {
  const HomeStep4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeCtr) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              // Model
              ExpansionTile(
                title: const Text('Model'),
                children: [
                  _jsonOutput(
                    homeCtr,
                    maxPercentHeight: 0.80,
                    text: homeCtr.textModel.value.isEmpty
                        ? 'Not Valido'
                        : homeCtr.textModel.value,
                    wordsToHighlight: [
                      '${homeCtr.nameClass.trim()}Model',
                    ],
                  )
                ],
              ),
              // Use Cases
              ExpansionTile(
                title: const Text('Use Cases'),
                children: [
                  _jsonOutput(
                    homeCtr,
                    maxPercentHeight: 0.80,
                    text: homeCtr.textUseCase.value,
                    wordsToHighlight: [
                      '${homeCtr.nameClass.trim()}Model',
                    ],
                  )
                ],
              ),
              // Provider Use Cases
              ExpansionTile(
                title: const Text('Provider Use Cases'),
                children: [
                  _jsonOutput(
                    homeCtr,
                    maxPercentHeight: 0.80,
                    text: homeCtr.textProviderUseCase.value,
                    wordsToHighlight: [
                      '${homeCtr.nameClass.trim()}Model',
                    ],
                  )
                ],
              ),
              // Repository Use Cases
              ExpansionTile(
                title: const Text('Repository Use Cases'),
                children: [
                  _jsonOutput(
                    homeCtr,
                    maxPercentHeight: 0.80,
                    text: homeCtr.textRepositoryUseCase.value,
                    wordsToHighlight: [
                      '${homeCtr.nameClass.trim()}Model',
                    ],
                  )
                ],
              ),
            ]),
          ),
        ),
      );
    });
  }

  Widget _jsonOutput(
    HomeController homeCtr, {
    required String text,
    required List<String> wordsToHighlight,
    maxPercentHeight = 0.50,
  }) {
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          HighlightableText(
            text: text,
            wordsToHighlight: wordsToHighlight,
            secondaryWordsToHighlight: HighlightableText.privateTypes,
            tertiaryWordsToHighlight: tertiaryWordsToHighlight,
          ),
        ]),
      ),
    );
  }
}
