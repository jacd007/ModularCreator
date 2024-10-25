import 'package:flutter/material.dart';

import '../presentation_m.dart';

class HomeStep1Screen extends StatelessWidget {
  const HomeStep1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: GetBuilder<HomeController>(builder: (homeCtr) {
          return SizedBox(
            width: size.width > 600.0 ? 300.0 : 200.0,
            child: TextField(
              controller: homeCtr.nameClassCtr,
              decoration: const InputDecoration(
                hintText: 'NameClass',
                hintStyle: TextStyle(color: Colors.grey),
                label: Text('Name class'),
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                homeCtr.setNameClass = text;
              },
            ),
          );
        }),
      ),
    );
  }
}
