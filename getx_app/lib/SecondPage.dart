import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondPage extends StatelessWidget {
  SecondPage({super.key});
  var count = 0.obs;
  @override
  Widget build(BuildContext context) {
    print("Second page build method");
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Obx(() => Text("$count")),
            ElevatedButton(
                onPressed: () {
                  count++;
                  print("Obx called");
                },
                child: Text("Increment"))
          ],
        ),
      ),
    );
  }
}
