import 'package:flutter/material.dart';

import '../../core/core_m.dart';
import '../presentation_m.dart';

class HomeStep3Screen extends StatelessWidget {
  const HomeStep3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeCtr) {
      homeCtr.updateStep3();
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              // title useCase provider
              const Divider(),
              const Divider(color: Colors.transparent),
              const Text('Provider Use Cases'),
              const Divider(color: Colors.transparent),
              const Divider(),
              // list useCase provider
              for (int i = 0; i < homeCtr.listMethods.length; i++)
                ResponsiveWidget(
                  desktopScreen: _item(
                    index: i,
                    name: homeCtr.listMethods[i].name,
                    returnT: homeCtr.listMethods[i].return1,
                    params: homeCtr.listMethods[i].params1,
                    content: homeCtr.listMethods[i].content1,
                  ),
                  mobileScreen: _itemMobile(
                    index: i,
                    name: homeCtr.listMethods[i].name,
                    returnT: homeCtr.listMethods[i].return1,
                    params: homeCtr.listMethods[i].params1,
                    content: homeCtr.listMethods[i].content1,
                  ),
                ),
              // title useCase repositories
              /*  const Divider(color: Colors.transparent),
              const Text('Repositories Use Cases'),
              const Divider(color: Colors.transparent),
              const Divider(),
              // list useCase repositories
              ...homeCtr.listMethods.map((method) {
                return ResponsiveWidget(
                  desktopScreen: _item(
                    name: method.name,
                    returnT: method.return2,
                    params: method.params2,
                    content: method.content,
                  ),
                  mobileScreen: _itemMobile(
                    name: method.name,
                    returnT: method.return2,
                    params: method.params2,
                    content: method.content,
                  ),
                );
              }), */
            ]),
          ),
        ),
        bottomNavigationBar: const SizedBox(height: 80),
      );
    });
  }

  Widget _item({
    required int index,
    required String name,
    required String returnT,
    required String params,
    required String content,
  }) {
    final method1 = 'Future<$returnT> $name($params);';
    final homeCtr = Get.find<HomeController>();

    return Column(mainAxisSize: MainAxisSize.min, children: [
      // item
      ListTile(
        title: Text(
          method1,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          content,
          style: const TextStyle(color: Colors.grey),
        ),
        onLongPress: () => homeCtr.deleteMethod(index),
      ),
      // divider
      const Divider(),
    ]);
  }

  Widget _itemMobile({
    required int index,
    required String name,
    required String returnT,
    required String params,
    required String content,
  }) {
    final method2 = 'Future<$returnT> $name($params);';
    final homeCtr = Get.find<HomeController>();

    return Column(mainAxisSize: MainAxisSize.min, children: [
      // item
      ListTile(
        title: SizedBox(
          height: 25.0,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(
              method2,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        subtitle: Text(
          content,
          style: const TextStyle(color: Colors.grey),
        ),
        onLongPress: () => homeCtr.deleteMethod(index),
      ),
      // divider
      const Divider(),
    ]);
  }
}
