import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoScreen extends StatefulWidget {
  String? username;
  ToDoScreen({super.key, required this.username});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState(username);
}

class _ToDoScreenState extends State<ToDoScreen> {
  String? username;
  String? collectionName;

  _ToDoScreenState(this.username);
  @override
  void initState() {
    super.initState();
    collectionName = null;
  }

  final TextEditingController _textFieldController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _addData(String text) async {
    print('$text');
    await _firestore.collection(text).add({'name': text});
    print('Data added');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(208, 205, 236, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50, left: 20),
            child: Column(
              children: [
                Container(
                  child: Text(
                    "Hello",
                    style: GoogleFonts.nanumMyeongjo(
                        fontWeight: FontWeight.w500, fontSize: 40),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    "${username}",
                    style: GoogleFonts.nanumMyeongjo(
                        fontWeight: FontWeight.w500, fontSize: 36),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 40),
              // height: 100,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(13, 12, 56, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45))),
              child: StreamBuilder(
                stream: _firestore.collection(collectionName!).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // return _buildListItem(snapshot.data!.docs[index]);
                      var title = snapshot.data!.docs[index]["name"];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(title),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => Container(
              // color: Colors.amber,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 100, left: 50, bottom: 12),
                    child: Text(
                      "Enter Category",
                      style: GoogleFonts.averageSans(
                          fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    // padding: EdgeInsets.all(50),
                    child: TextField(
                      controller: _textFieldController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(208, 205, 236, 1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.only(top: 45),
                      child: ElevatedButton(
                        onPressed: () {
                          _addData(_textFieldController.text);
                          Navigator.pop(context);
                          _textFieldController.clear();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(208, 205, 236, 1)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                        child: Text(
                          'Add',
                          style: GoogleFonts.averageSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        backgroundColor: Color.fromRGBO(147, 149, 211, 1),
        child: Icon(Icons.add),
      ),
    );
  }
}
