import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
    final TextEditingController _dateController = TextEditingController();
    DateTime? selectedDate;
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
          _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
          // Set selected date to text field
        });
    }

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
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.title,
                                  style: GoogleFonts.jost(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Color.fromRGBO(147, 149, 211, 1)),
                                ),
                                Text(
                                  DateFormat('dd-MM-yyyy').format(task.date),
                                  style: GoogleFonts.jost(
                                      fontSize: 13,
                                      fontWeight: FontWeight
                                          .w400), // Format DateTime as desired
                                )

                                // Format DateTime as desired
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
                                          title: Text('Edit Task'),
                                          content: TextField(
                                            controller: _controller,
                                            decoration: InputDecoration(
                                                hintText: task.title),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('CANCEL'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                _controller.clear();
                                              },
                                            ),
                                            TextButton(
                                              child: Text('SAVE'),
                                              onPressed: () async {
                                                String newCategoryName =
                                                    _controller.text.trim();
                                                if (newCategoryName
                                                    .isNotEmpty) {
                                                  await tasksRef
                                                      .doc(task.id)
                                                      .update({
                                                    'title': newCategoryName,
                                                    'timestamp': FieldValue
                                                        .serverTimestamp()
                                                  });
                                                }

                                                Navigator.pop(context);
                                                _controller.clear();
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
              height: 400,
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
                        controller: _dateController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(208, 205, 236, 1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  _selectDate(context);
                                },
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
                            String taskDate = _dateController.text.trim();

                            if (taskTitle.isNotEmpty && taskDate.isNotEmpty) {
                              await tasksRef.add({
                                'categoryId': categoryId,
                                'title': taskTitle,
                                'date': Timestamp.fromDate(
                                    DateTime.parse(taskDate)),
                                'isCompleted': false,
                                'timestamp': FieldValue.serverTimestamp(),
                              });

                              _controller.clear();
                              _dateController.clear();
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
