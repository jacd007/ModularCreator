import 'package:flutter/material.dart';

import '../presentation_m.dart';

class HomeStepsPage extends StatelessWidget {
  const HomeStepsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllController>(builder: (allCtr) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Step ${allCtr.currentPage + 1}'),
          actions: allCtr.currentPage == 2
              ? [
                  IconButton(
                    onPressed: Get.find<HomeController>().showDialogAdded,
                    icon: const Icon(Icons.add),
                  ),
                ]
              : null,
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: allCtr.pageCtr,
          children: allCtr.screens,
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // previous
              _btnPrevious(allCtr),
              // next
              _btnNext(allCtr),
            ],
          ),
        ),
      );
    });
  }

  Widget _btnNext(AllController allCtr) {
    const iconLoading = SizedBox.square(
      dimension: 20,
      child: CircularProgressIndicator(),
    );

    final btnNext = FloatingActionButton(
      heroTag: 'btnHomeStepsPageViewNext',
      onPressed: allCtr.onPageNext,
      child: const Icon(Icons.navigate_next),
    );

    return Visibility(
      visible: allCtr.currentPage != (allCtr.screens.length - 1),
      replacement: GetBuilder<HomeController>(builder: (homeCtr) {
        return StreamBuilder<bool>(
            stream: homeCtr.loading.stream,
            initialData: false,
            builder: (context, snap) {
              final zip = snap.data ?? false;

              return FloatingActionButton(
                heroTag: 'btnHomeStepsPageViewFinished',
                onPressed: zip ? null : homeCtr.onCreateZip,
                child: zip ? iconLoading : const Icon(Icons.build),
              );
            });
      }),
      child: btnNext,
    );
  }

  Widget _btnPrevious(AllController allCtr) {
    return Visibility(
      visible: allCtr.currentPage != 0,
      child: FloatingActionButton(
        heroTag: 'btnHomeStepsPageViewPrevious',
        onPressed: allCtr.onPagePrevious,
        child: const Icon(Icons.navigate_before),
      ),
    );
  }
}
