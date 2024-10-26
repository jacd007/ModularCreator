import 'package:flutter/material.dart';

import '../presentation_m.dart';

class HomeMainPage extends StatelessWidget {
  const HomeMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => Get.to(() => const HomePage()),
              child: const Text('Creator 1'),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () => Get.to(() => const HomeStepsPage()),
              child: const Text('Creator 2'),
            ),
          ],
        ),
      ),
    );
  }
}
