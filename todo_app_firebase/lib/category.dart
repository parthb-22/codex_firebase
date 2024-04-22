import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });


  // factory counstructor takes firestore document and return category class object
  factory Category.fromSnapshot(DocumentSnapshot snapshot) {
    return Category(
      id: snapshot.id,
      name: snapshot['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

