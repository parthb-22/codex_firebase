import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/category.dart';
import 'package:todo_app/Tasks.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Example',
      home: CategoryList(),
    );
  }
}

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // created a categories collection on firestore
    final CollectionReference categoriesRef =
        FirebaseFirestore.instance.collection('categories');

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: StreamBuilder<QuerySnapshot>(
        stream: categoriesRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // coverted firestore data(documetapshot data) ito our model class Category
          final List<Category> categories = snapshot.data!.docs
              .map((doc) => Category.fromSnapshot(doc))
              .toList();

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
                title: Text(category.name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskList(
                          categoryId: category.id, categoryName: category.name),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet(context, categoriesRef);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showBottomSheet(
      BuildContext context, CollectionReference categoriesRef) {
    final TextEditingController _controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter category name',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String categoryName = _controller.text.trim();
                  if (categoryName.isNotEmpty) {
                    await categoriesRef.add({
                      'name': categoryName,
                      'timestamp': FieldValue
                          .serverTimestamp(), // Add the timestamp field
                    });

                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Category'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TaskList extends StatelessWidget {
  final String categoryName;
  final String categoryId;

  TaskList({
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    // created "Tasks" collection on firestore
    final CollectionReference tasksRef =
        FirebaseFirestore.instance.collection('tasks');

    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: StreamBuilder<QuerySnapshot>(
        stream: tasksRef.where('categoryId', isEqualTo: categoryId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // converted firestore tasks colection data to our model class
          final List<Task> tasks =
              snapshot.data!.docs.map((doc) => Task.fromSnapshot(doc)).toList();

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task.title),
                trailing: Checkbox(
                  value: task.isCompleted,
                  onChanged: (newValue) async {
                    await tasksRef.doc(task.id).update({
                      'isCompleted': newValue,
                    });
                  },
                ),
                onLongPress: () async {
                  await tasksRef.doc(task.id).delete();
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet(context, tasksRef);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, CollectionReference tasksRef) {
    final TextEditingController _controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter task title',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String taskTitle = _controller.text.trim();
                  if (taskTitle.isNotEmpty) {
                    await tasksRef.add({
                      'categoryId': categoryId,
                      'title': taskTitle,
                      'isCompleted': false,
                      'timestamp': FieldValue
                          .serverTimestamp(), // Add the timestamp field
                    });

                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Task'),
              ),
            ],
          ),
        );
      },
    );
  }
}
