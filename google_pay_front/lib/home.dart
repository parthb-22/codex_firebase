import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            // color: Colors.blueGrey,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage("images/top_img.png"))),
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 300,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(0, 3)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Pay by name or phone number",
                            hintStyle: GoogleFonts.dmSans(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      // color: Colors.amber,
                      image: DecorationImage(
                          image: AssetImage("images/profile.jpg"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(50)),
                )
              ],
            ),
          )
        ,Container(
          child: Row(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Image(image: AssetImage("")),
                    )
                  ],
                ),
              )
            ],
          ),
        )
        ],
      ),
    );
  }
}
