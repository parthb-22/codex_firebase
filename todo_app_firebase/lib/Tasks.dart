import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String categoryId;
  final String title;
  final bool isCompleted;
  final DateTime date; // Add date property

  Task({
    required this.id,
    required this.categoryId,
    required this.title,
    this.isCompleted = false,
    required this.date, // Add date parameter to the constructor
  });

  // Factory constructor that takes a Firestore document and returns a Task object
  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    return Task(
      id: snapshot.id,
      categoryId: snapshot['categoryId'],
      title: snapshot['title'],
      isCompleted: snapshot['isCompleted'] ?? false,
      date: (snapshot['date'] as Timestamp)
          .toDate(), // Convert Firestore Timestamp to DateTime
    );
  }

  // Method to convert Task object to JSON
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'title': title,
      'isCompleted': isCompleted,
      'date': date, // Include date in JSON representation
    };
  }
}
