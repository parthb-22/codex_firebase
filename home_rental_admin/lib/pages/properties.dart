import 'package:cloud_firestore/cloud_firestore.dart';

class Properties {
  final String id;
  final String categoryId;
  final String title;
  final String location;
  final String price;
  final String imageUrl;

  Properties(
      {required this.id,
      required this.categoryId,
      required this.title,
      required this.location,
      required this.price,
      required this.imageUrl});

  // Factory constructor that takes a Firestore document and returns a Task object
  factory Properties.fromSnapshot(DocumentSnapshot snapshot) {
    return Properties(
        id: snapshot.id,
        categoryId: snapshot['categoryId'],
        title: snapshot['title'],
        location: snapshot['location'],
        price: snapshot['price'],
        imageUrl: snapshot['imageUrl']);
  }

  // Method to convert Task object to JSON
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'title': title,
      'location': location,
      'price': price,
      'imageUrl': imageUrl
    };
  }
}
