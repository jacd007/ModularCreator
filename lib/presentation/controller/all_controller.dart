import 'package:flutter/material.dart';

import '../presentation_m.dart';

class AllController extends GetxController {
  /// Screens
  List<Widget> screens = [
    const HomeStep1Screen(),
    const HomeStep2Screen(),
    const HomeStep3Screen(),
    const HomeStep4Screen(),
  ];

  final PageController pageCtr = PageController();
  int currentPage = 0;

  void onPageNext() {
    pageCtr.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
    if (currentPage < screens.length - 1) currentPage++;
    update();
  }

  void onPagePrevious() {
    pageCtr.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
    if (currentPage > 0) currentPage--;
    update();
  }
}
