import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_rental_admin/pages/addproperty.dart';
import 'package:home_rental_admin/pages/category.dart';
import 'package:home_rental_admin/pages/properties.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CollectionReference categoriesRef =
        FirebaseFirestore.instance.collection('categories');
    return Scaffold(
      backgroundColor: Color.fromARGB(200, 204, 230, 244),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: 50),
            child: Text(
              "Welcome Admin",
              style:
                  GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 40),
              child: StreamBuilder(
                  stream: categoriesRef.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

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
                                  builder: (context) => AddProperty(
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
                                                      _categoryController,
                                                  decoration: InputDecoration(
                                                      hintText: category.name),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('CANCEL'),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      _categoryController
                                                          .clear();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('SAVE'),
                                                    onPressed: () async {
                                                      String newCategoryName =
                                                          _categoryController
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
                                                      _categoryController
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
            builder: (context) => Container(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50, left: 50, bottom: 12),
                    child: const Text("Enter Category"),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: TextField(
                      controller: _categoryController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(215, 211, 255, 1),
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
                          print("Add button");
                          String categoryName = _categoryController.text.trim();
                          if (categoryName.isNotEmpty) {
                            await categoriesRef.add({
                              'name': categoryName // Add the timestamp field
                            });
                            _categoryController.clear();
                            Navigator.pop(context);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(255, 160, 160, 1)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Add',
                          style: TextStyle(
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
        child: Icon(Icons.add),
      ),
    );
  }
}
