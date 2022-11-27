import 'package:flutter/material.dart';
import './api.dart';
import './main.dart';

class Student extends StatefulWidget {
  Student(
      {super.key,
      required this.id,
      required this.courseName,
      required this.fname});
  final CourseApi api = CourseApi();

  final String id;
  final String courseName;
  final String fname;

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  List students = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();

    widget.api.getAllStudents().then((data) {
      setState(() {
        students = data;
        _dbLoaded = true;
      });
    });
  }

  void _editStudentById(id, fname) {
    setState(() {
      widget.api.editStudentById(id, fname);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text(
                    "Change Student First Name " + widget.fname,
                    style: TextStyle(fontSize: 25),
                  ),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      controller: nameController),
                  ElevatedButton(
                      onPressed: () => {
                            _editStudentById(widget.fname, nameController.text),
                          },
                      child: Text("Submit")),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () => {
                Navigator.pop(context),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage())),
              }),
    );
  }
}
