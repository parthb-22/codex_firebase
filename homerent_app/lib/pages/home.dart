import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homerent_app/pages/housedetails.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 17, 24, 1),
      body: Column(
        children: [
          Container(
            width: 268,
            margin: EdgeInsets.only(top: 120),
            child: Text(
              "Rent a House for you.",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Image(
                image: AssetImage("images/home.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            height: 230,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(85),
                    topRight: Radius.circular(85))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "Reservation Now",
                    style: GoogleFonts.poppins(
                        fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  width: 220,
                  height: 60,
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HouseDetails(),
                          ));
                    },
                    child: Text("BOOK NOW",
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(223, 223, 223, 1))),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(4, 36, 47, 1)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(26))))),
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
