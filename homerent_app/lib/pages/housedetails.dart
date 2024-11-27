import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homerent_app/pages/houselist.dart';

class HouseDetails extends StatefulWidget {
  const HouseDetails({super.key});

  @override
  State<HouseDetails> createState() => _HouseDetailsState();
}

class _HouseDetailsState extends State<HouseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(221, 227, 227, 227)),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Now",
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w400),
                            prefixIcon: Icon(Icons.search)),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                          // borderRadius:
                          ),
                      child: Icon(Icons.filter_list),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 113,
                    width: 113,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3)),
                      ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 41,
                            width: 41,
                            child: Image(
                              image: AssetImage("images/Layer 2.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            child: Text("Near By"),
                          )
                        ]),
                  ),
                  Container(
                    height: 113,
                    width: 113,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3)),
                      ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 41,
                            width: 41,
                            child: Image(
                              image: AssetImage("images/logo3.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            child: Text("Book Room"),
                          )
                        ]),
                  ),
                  Container(
                    height: 113,
                    width: 113,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3)),
                      ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 41,
                            width: 41,
                            child: Image(
                              image: AssetImage("images/logo2.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            child: Text("Add Event"),
                          )
                        ]),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25, left: 25),
              child: Text(
                "Category",
                style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(13, 45, 58, 1)),
              ),
            ),
            InkWell(
              onTap: () {
                String categoryName = "Apartments";
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HouseList(categoryName: categoryName),
                    ));
              },
              child: Container(
                margin: EdgeInsets.only(top: 15, left: 22),
                height: 40,
                width: 110,
                child: Center(
                  child: Text("Apartments",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(0, 0, 0, 1))),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                width: 365,
                height: 350,
                // color: Colors.white,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 235,
                      width: 340,
                      child: Image(
                        image: AssetImage("images/hut2.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Wooden Hut",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Color.fromRGBO(13, 45, 58, 1)),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Rp. 249.000 / Night",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(30, 30, 30, 0.74)),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                child: Image(
                                    image: AssetImage("images/Vector.png")),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                child: Text(
                                  "Merbabu, Central Java",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color.fromRGBO(9, 131, 181, 1)),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Icon(Icons.room_service),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text(
                              "All Inclusive",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: Color.fromRGBO(13, 45, 58, 0.69)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Icon(Icons.wifi),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text("Free WiFi",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: Color.fromRGBO(13, 45, 58, 0.69))),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Icon(Icons.account_box),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text("Free Consultation",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: Color.fromRGBO(13, 45, 58, 0.69))),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 22),
              height: 40,
              width: 110,
              child: Center(
                child: Text("Villa",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(0, 0, 0, 1))),
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                width: 365,
                height: 350,
                // color: Colors.white,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 235,
                      width: 340,
                      child: Image(
                        image: AssetImage("images/hut1.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Wooden Hut",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Color.fromRGBO(13, 45, 58, 1)),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Rp. 249.000 / Night",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(30, 30, 30, 0.74)),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                child: Image(
                                    image: AssetImage("images/Vector.png")),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                child: Text(
                                  "Merbabu, Central Java",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color.fromRGBO(9, 131, 181, 1)),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Icon(Icons.room_service),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text(
                              "All Inclusive",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: Color.fromRGBO(13, 45, 58, 0.69)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Icon(Icons.wifi),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text("Free WiFi",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: Color.fromRGBO(13, 45, 58, 0.69))),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Icon(Icons.account_box),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text("Free Consultation",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: Color.fromRGBO(13, 45, 58, 0.69))),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
