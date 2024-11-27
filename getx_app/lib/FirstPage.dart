import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    print("build method called");
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              "$count",
              style: TextStyle(fontSize: 30),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
                child: Text("Increment"))
          ],
        ),
      ),
    );
  }
}
