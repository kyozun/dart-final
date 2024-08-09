import './subject.dart';

class Student {
  int id;
  String name;
  List<Subject> subjects;

  Student({required this.id, required this.name, required this.subjects});
}
