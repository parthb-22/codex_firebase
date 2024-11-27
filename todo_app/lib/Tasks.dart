import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String categoryId;
  final String title;
  final bool isCompleted;

  Task({
    required this.id,
    required this.categoryId,
    required this.title,
    this.isCompleted = false,
  });

  // factory counstructor takes firestore document and return Task class object

  factory Task.fromSnapshot(DocumentSnapshot snapshot) {
    return Task(
      id: snapshot.id,
      categoryId: snapshot['categoryId'],
      title: snapshot['title'],
      isCompleted: snapshot['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'title': title,
      'isCompleted': isCompleted,
    };
  }
}