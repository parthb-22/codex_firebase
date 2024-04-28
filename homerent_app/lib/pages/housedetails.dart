import 'package:flutter/material.dart';

class HouseDetails extends StatefulWidget {
  const HouseDetails({super.key});

  @override
  State<HouseDetails> createState() => _HouseDetailsState();
}

class _HouseDetailsState extends State<HouseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 20),
            child: SingleChildScrollView(
              child: Row(
                children: [
                  Container(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search Now",
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, left: 22),
            height: 40,
            width: 110,
            child: Center(
              child: Text("Apartments",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          Column(
            children: [],
          )
        ],
      ),
    );
  }
}
