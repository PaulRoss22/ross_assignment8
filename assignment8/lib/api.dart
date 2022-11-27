import 'package:dio/dio.dart';

import 'Models/course.dart';

const String localhost = "http://10.0.2.2:1200/";

class CourseApi {
  final _dio = Dio(BaseOptions(baseUrl: localhost));

  Future<List> getAllCourses() async {
    final response = await _dio.get('/getAllCourses');

    return response.data['courses'];
  }

  Future<List> getAllStudents() async {
    final response = await _dio.get('/getAllStudents');

    return response.data['students'];
  }

  Future editStudentById(String id, String fname) async {
    final response =
        await _dio.post('/editStudentById', data: {'id': id, 'fname': fname});
  }
}
