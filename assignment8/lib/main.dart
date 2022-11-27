import 'package:assignment8/Models/course.dart';
import 'package:flutter/material.dart';
import './api.dart';
import './student.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 8 App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CourseApi api = CourseApi();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List courses = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();

    widget.api.getAllCourses().then((data) {
      setState(() {
        courses = data;
        _dbLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Assignment 8 App"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Course Name  |  Instructor Name  |  Course Credits",
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
                child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(15.0),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Database Loading",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    CircularProgressIndicator()
                  ],
                ),
                ...courses.map<Widget>(
                  (course) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: TextButton(
                      onPressed: () => {
                        Navigator.pop(context),
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Student(
                                      id: course['_id'],
                                      courseName: course['courseName'],
                                      fname: '',
                                    ))),
                      },
                      child: ListTile(
                          title: Text(
                        (course['courseName'] +
                            "  |  " +
                            course['courseInstructor'] +
                            "  |  " +
                            course['courseCredits'].toString()),
                        style: TextStyle(fontSize: 18),
                      )),
                    ),
                  ),
                ),
              ].toList(),
            )),
          ],
        )));
  }
}
