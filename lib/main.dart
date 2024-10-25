import 'package:flutter/material.dart';

import 'presentation/presentation_m.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(AllController());
  await Future.delayed(const Duration(milliseconds: 100));
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // home: HomeStepsPage(),
    );
  }
}
