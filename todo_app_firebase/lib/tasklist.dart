import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_firebase/Tasks.dart';

class TaskList extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  TaskList({super.key, required this.categoryId, required this.categoryName});

  @override
  State<TaskList> createState() => _TaskListState(categoryId, categoryName);
}

class _TaskListState extends State<TaskList> {
  final String categoryName;
  final String categoryId;
  _TaskListState(this.categoryId, this.categoryName);

  @override
  Widget build(BuildContext context) {
    final CollectionReference tasksRef =
        FirebaseFirestore.instance.collection('tasks');

    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromRGBO(208, 205, 236, 1),
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
            stream:
                tasksRef.where('categoryId', isEqualTo: categoryId).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              // converted firestore tasks colection data to our model class
              final List<Task> tasks = snapshot.data!.docs
                  .map((doc) => Task.fromSnapshot(doc))
                  .toList();

              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    height: 70,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            task.title,
                            style: GoogleFonts.jost(
                                fontWeight: FontWeight.w400, fontSize: 24),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  color: Color.fromRGBO(179, 183, 238, 1),
                                  icon: Icon(Icons.edit_outlined)),
                              IconButton(
                                  onPressed: () async {
                                    await tasksRef.doc(task.id).delete();
                                  },
                                  color: Color.fromRGBO(179, 183, 238, 1),
                                  icon: Icon(Icons.delete_outline_rounded))
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => Container(
              height: 300,
              child: Container(
                // color: Colors.amber,
                // height: 300,
                decoration: BoxDecoration(
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
                        "Enter Task",
                        style: GoogleFonts.averageSans(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      // padding: EdgeInsets.all(50),
                      child: TextField(
                        controller: _controller,
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
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 50, bottom: 12),
                      child: Text(
                        "Enter Date",
                        style: GoogleFonts.averageSans(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      // padding: EdgeInsets.all(50),
                      child: TextField(
                        // controller: _controller,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(208, 205, 236, 1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.calendar_today_outlined))),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.only(top: 45),
                        child: ElevatedButton(
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
                              _controller.clear();
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
