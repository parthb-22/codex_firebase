import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/FirstPage.dart';
import 'package:getx_app/SecondPage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SecondPage(),
    );
  }
}
