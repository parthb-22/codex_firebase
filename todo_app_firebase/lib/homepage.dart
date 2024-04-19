import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_firebase/secondpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(13, 12, 56, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 55, top: 90),
              child: Text(
                "Welcome",
                style: GoogleFonts.averageSans(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 40,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    // margin: EdgeInsets.only(left: 89, top: 30),
                    child: Image(image: AssetImage("images/home.png")),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 35, left: 50),
                  child: Text(
                    "Enter Name",
                    style: GoogleFonts.averageSans(color: Colors.white),
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(50),
                  margin: EdgeInsets.only(left: 50, top: 10, right: 50),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(217, 217, 217, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 70),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SecondPage(userName: username),
                              ));
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(65, 201, 226, 1))),
                        child: Text(
                          "GET STARTED",
                          style: GoogleFonts.asapCondensed(
                              color: Color.fromRGBO(27, 26, 85, 0.65),
                              fontWeight: FontWeight.w700,
                              fontSize: 21.23),
                        )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
