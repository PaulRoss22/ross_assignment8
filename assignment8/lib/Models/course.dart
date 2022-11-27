class Course {
  final String id;
  final String courseName;
  final String courseInstructor;
  final String courseCredits;

  Course._(this.id, this.courseName, this.courseInstructor, this.courseCredits);

  factory Course.fromJson(Map json) {
    final id = json[''].replaceAll('ObjectId(\"', '').replaceAll('\")', '');
    final courseName = json['courseName'];
    final courseInstructor = json['courseInstructor'];
    final courseCredits = json['courseCredits'];

    return Course._(id, courseName, courseInstructor, courseCredits);
  }
}
