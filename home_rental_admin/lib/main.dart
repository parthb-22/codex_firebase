import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_rental_admin/firebase_options.dart';
import 'package:home_rental_admin/pages/addcategory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: AddCategory());
  }
}
