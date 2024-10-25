import 'package:flutter/material.dart';

import '../../core/core_m.dart';
import '../presentation_m.dart';

class HomeStep3Screen extends StatelessWidget {
  const HomeStep3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homeCtr) {
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
              ...homeCtr.listMethods.map((method) {
                return ResponsiveWidget(
                  desktopScreen: _item(
                    name: method.name,
                    returnT: method.return1,
                    params: method.params1,
                    content: method.content,
                  ),
                  mobileScreen: _itemMobile(
                    name: method.name,
                    returnT: method.return1,
                    params: method.params1,
                    content: method.content,
                  ),
                );
              }),
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
    required String name,
    required String returnT,
    required String params,
    required String content,
  }) {
    final method1 = 'Future<$returnT> $name($params);';

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
        onLongPress: () {},
      ),
      // divider
      const Divider(),
    ]);
  }

  Widget _itemMobile({
    required String name,
    required String returnT,
    required String params,
    required String content,
  }) {
    final method2 = 'Future<$returnT> $name($params);';

    return Column(mainAxisSize: MainAxisSize.min, children: [
      // item
      ListTile(
        title: FittedBox(
          child: Text(
            method2,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        subtitle: Text(
          content,
          style: const TextStyle(color: Colors.grey),
        ),
        onLongPress: () {},
      ),
      // divider
      const Divider(),
    ]);
  }
}
