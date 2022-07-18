import 'package:lastpage/models/syllabus/subject.dart';

class Syllabus {
  String university;
  String course;
  String syllabusVersion;
  List<Subject> subjects;

  Syllabus({
    required this.university,
    required this.course,
    required this.syllabusVersion,
    required this.subjects,
  });
}
