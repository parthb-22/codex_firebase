import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homerent_app/pages/details.dart';

class HouseList extends StatefulWidget {
  String? categoryName;
  HouseList({super.key, this.categoryName});

  @override
  State<HouseList> createState() => _HouseListState(categoryName);
}

class _HouseListState extends State<HouseList> {
  String? categoryName;
  _HouseListState(this.categoryName);
  List houseList = List.generate(
      6,
      (index) => {
            "title": "Entire Bromo mountain view Cabin in Surabaya",
            "subtitle": "Malang, Probolinggo",
            "price": "\$1,290 / month",
            "image": "images/purple.png"
          });
  @override
  Widget build(BuildContext context) {
    print("$categoryName");
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 80),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ),
                Text(
                  "$categoryName",
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Expanded(
            child: Container(
              // margin: EdgeInsets.only(left: 20),
              // height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Details(imageUrl: houseList[index]['image']),
                          ));
                    },
                    child: Container(
                      width: 343,
                      height: 160,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 122,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(houseList[index]['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    houseList[index]['title'],
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  houseList[index]['subtitle'],
                                  style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(125, 127, 136, 1)),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  houseList[index]['price'],
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
