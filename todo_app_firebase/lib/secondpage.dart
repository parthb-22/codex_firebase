import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_firebase/todoscreen.dart';

class SecondPage extends StatefulWidget {
  String userName;
  SecondPage({super.key, required this.userName});

  @override
  State<SecondPage> createState() => _SecondPageState(userName);
}

class _SecondPageState extends State<SecondPage> {
  String? userName;
  _SecondPageState(this.userName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(13, 12, 56, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 150),
                    child: Image(image: AssetImage("images/image.png")),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Text(
                      "Build the future by completing tasks.",
                      style: GoogleFonts.asapCondensed(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 21.23),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(55),
                    child: Text(
                      "Your tasks are bridges leading to the future. By completing them, reach your potential and your dreams.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.asapCondensed(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ToDoScreen(username: userName),
                              ));
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(65, 201, 226, 1))),
                        child: Text(
                          "Continue",
                          style: GoogleFonts.asapCondensed(
                              color: Color.fromRGBO(27, 26, 85, 0.65),
                              fontWeight: FontWeight.w700,
                              fontSize: 21.23),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
