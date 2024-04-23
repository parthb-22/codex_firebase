import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_firebase/category.dart';
import 'package:todo_app_firebase/tasklist.dart';

class ToDoScreen extends StatefulWidget {
  String? username;
  ToDoScreen({super.key, required this.username});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState(username);
}

class _ToDoScreenState extends State<ToDoScreen> {
  String? username;

  _ToDoScreenState(this.username);

  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CollectionReference categoriesRef =
        FirebaseFirestore.instance.collection('categories');

    return Scaffold(
      backgroundColor: Color.fromRGBO(208, 205, 236, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 50, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Hello",
                    style: GoogleFonts.tinos(
                        fontWeight: FontWeight.w400, fontSize: 40),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    "${username}",
                    style: GoogleFonts.tinos(
                        fontWeight: FontWeight.w400, fontSize: 36),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.only(top: 60),
              // height: 100,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(13, 12, 56, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45))),
              child: StreamBuilder(
                  stream: categoriesRef.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // converted firestore data(documetapshot data) ito our model class Category
                    final List<Category> categories = snapshot.data!.docs
                        .map((doc) => Category.fromSnapshot(doc))
                        .toList();

                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          height: 70,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TaskList(
                                      categoryId: category.id,
                                      categoryName: category.name),
                                ),
                              );
                            },
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  category.name,
                                  style: GoogleFonts.jost(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 24),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('Edit Category'),
                                                content: TextField(
                                                  controller:
                                                      _textFieldController,
                                                  decoration: InputDecoration(
                                                      hintText: category.name),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('CANCEL'),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      _textFieldController
                                                          .clear();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('SAVE'),
                                                    onPressed: () async {
                                                      String newCategoryName =
                                                          _textFieldController
                                                              .text
                                                              .trim();
                                                      if (newCategoryName
                                                          .isNotEmpty) {
                                                        await categoriesRef
                                                            .doc(category.id)
                                                            .update({
                                                          'name':
                                                              newCategoryName,
                                                          'timestamp': FieldValue
                                                              .serverTimestamp()
                                                        });
                                                      }

                                                      Navigator.pop(context);
                                                      _textFieldController
                                                          .clear();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        color: Color.fromRGBO(179, 183, 238, 1),
                                        icon: Icon(Icons.edit_outlined)),
                                    IconButton(
                                        onPressed: () async {
                                          await categoriesRef
                                              .doc(category.id)
                                              .delete();
                                        },
                                        color: Color.fromRGBO(179, 183, 238, 1),
                                        icon:
                                            Icon(Icons.delete_outline_rounded))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
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
                        onPressed: () async {
                          String categoryName =
                              _textFieldController.text.trim();
                          if (categoryName.isNotEmpty) {
                            await categoriesRef.add({
                              'name': categoryName,
                              'timestamp': FieldValue
                                  .serverTimestamp(), // Add the timestamp field
                            });
                            _textFieldController.clear();
                            Navigator.pop(context);
                          }
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
