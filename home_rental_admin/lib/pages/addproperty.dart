import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_rental_admin/pages/properties.dart';

class AddProperty extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  AddProperty(
      {super.key, required this.categoryId, required this.categoryName});

  @override
  State<AddProperty> createState() =>
      _AddPropertyState(categoryId, categoryName);
}

class _AddPropertyState extends State<AddProperty> {
  final String categoryName;
  final String categoryId;
  _AddPropertyState(this.categoryId, this.categoryName);
  @override
  Widget build(BuildContext context) {
    final CollectionReference propertyRef =
        FirebaseFirestore.instance.collection('properties');

    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _locationController = TextEditingController();
    final TextEditingController _priceController = TextEditingController();
    final TextEditingController _imageController = TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromARGB(200, 204, 230, 244),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(27, 26, 85, 1),
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(
          categoryName,
          style: GoogleFonts.jost(fontWeight: FontWeight.w600, fontSize: 24),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: StreamBuilder<QuerySnapshot>(
            stream: propertyRef
                .where('categoryId', isEqualTo: categoryId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              // converted firestore tasks colection data to our model class
              final List<Properties> property = snapshot.data!.docs
                  .map((doc) => Properties.fromSnapshot(doc))
                  .toList();

              return ListView.builder(
                itemCount: property.length,
                itemBuilder: (context, index) {
                  final prop = property[index];
                  return Container(
                    height: 200,
                    width: 380,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4)
                      ],
                    ),
                    // height: 70,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      title: Container(
                        width: 343,
                        height: 100,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 122,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(prop.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    prop.title,
                                    style: GoogleFonts.jost(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color:
                                            Color.fromRGBO(147, 149, 211, 1)),
                                  ),
                                  Text(
                                    prop.location,
                                    style: GoogleFonts.jost(
                                        fontSize: 13,
                                        fontWeight: FontWeight
                                            .w400), // Format DateTime as desired
                                  ),
                                  Text(
                                    "\$ ${prop.price}",
                                    style: GoogleFonts.jost(
                                        fontSize: 13,
                                        fontWeight: FontWeight
                                            .w400), // Format DateTime as desired
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Edit Property'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller: _titleController
                                                    ..text = prop.title,
                                                  decoration: InputDecoration(
                                                      labelText:
                                                          'Property Name'),
                                                ),
                                                TextField(
                                                  controller:
                                                      _locationController
                                                        ..text = prop.location,
                                                  decoration: InputDecoration(
                                                      labelText: 'Location'),
                                                ),
                                                TextField(
                                                  controller: _priceController
                                                    ..text = prop.price,
                                                  decoration: InputDecoration(
                                                      labelText: 'Price'),
                                                ),
                                                TextField(
                                                  controller: _imageController
                                                    ..text = prop.imageUrl,
                                                  decoration: InputDecoration(
                                                      labelText: 'Image URL'),
                                                ),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('CANCEL'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  _titleController.clear();
                                                  _locationController.clear();
                                                  _priceController.clear();
                                                  _imageController.clear();
                                                },
                                              ),
                                              TextButton(
                                                child: Text('SAVE'),
                                                onPressed: () async {
                                                  String newTitle =
                                                      _titleController.text
                                                          .trim();
                                                  String newLocation =
                                                      _locationController.text
                                                          .trim();
                                                  String newPrice =
                                                      _priceController.text
                                                          .trim();
                                                  String newImageUrl =
                                                      _imageController.text
                                                          .trim();

                                                  if (newTitle.isNotEmpty &&
                                                      newLocation.isNotEmpty &&
                                                      newPrice.isNotEmpty &&
                                                      newImageUrl.isNotEmpty) {
                                                    await propertyRef
                                                        .doc(prop.id)
                                                        .update({
                                                      'title': newTitle,
                                                      'location': newLocation,
                                                      'price': newPrice,
                                                      'imageUrl': newImageUrl,
                                                    });

                                                    Navigator.pop(context);
                                                    _titleController.clear();
                                                    _locationController.clear();
                                                    _priceController.clear();
                                                    _imageController.clear();
                                                  }
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
                                      await propertyRef.doc(prop.id).delete();
                                    },
                                    color: Color.fromRGBO(179, 183, 238, 1),
                                    icon: Icon(Icons.delete_outline_rounded))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 50, bottom: 12),
                      child: Text(
                        "Enter Property name",
                        style: GoogleFonts.averageSans(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(208, 205, 236, 1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 50, bottom: 12),
                      child: Text(
                        "Enter Location",
                        style: GoogleFonts.averageSans(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      // padding: EdgeInsets.all(50),
                      child: TextField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(208, 205, 236, 1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 50, bottom: 12),
                      child: Text(
                        "Enter Price",
                        style: GoogleFonts.averageSans(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      // padding: EdgeInsets.all(50),
                      child: TextField(
                        controller: _priceController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(208, 205, 236, 1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 50, bottom: 12),
                      child: Text(
                        "Enter Image Url",
                        style: GoogleFonts.averageSans(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      // padding: EdgeInsets.all(50),
                      child: TextField(
                        controller: _imageController,
                        decoration: const InputDecoration(
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
                            String propertyTitle = _titleController.text.trim();
                            String propertyLocation =
                                _locationController.text.trim();
                            String propertyPrice = _priceController.text.trim();
                            String propertyImage = _imageController.text.trim();

                            if (propertyTitle.isNotEmpty &&
                                propertyLocation.isNotEmpty &&
                                propertyPrice.isNotEmpty &&
                                propertyImage.isNotEmpty) {
                              await propertyRef.add({
                                'categoryId': categoryId,
                                'title': propertyTitle,
                                'location': propertyLocation,
                                'price': propertyPrice,
                                'imageUrl': propertyImage
                              });

                              _titleController.clear();
                              _locationController.clear();
                              _priceController.clear();
                              _imageController.clear();
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
            ),
          );
        },
        backgroundColor: Color.fromRGBO(147, 149, 211, 1),
        child: Icon(Icons.add),
      ),
    );
  }
}
