import './subject.dart';

class Student {
  int id;
  String name;
  List<Subject> subjects;

  Student({required this.id, required this.name, required this.subjects});

  // Convert Object to Json
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'subjects': subjects};
  }

  // Convert parsedJson to Student Object
  factory Student.fromJson(Map<String, dynamic> data) {
    var id = data['id'];
    var name = data['name'];
    List<dynamic> subjects = data['subjects'];
    return Student(
        id: id,
        name: name,
        subjects:
            subjects.map((subject) => Subject.fromJson(subject)).toList());
  }
}
