import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import '../services/student_service.dart';
import '../models/student.dart';

class StudentServiceImplement implements StudentService {
  @override
  Future<void> addStudent(String filePath) async {
    stdout.write('Enter student ID: ');
    int? id = int.tryParse(stdin.readLineSync() ?? '');
    if (id == null) {
      print('Invalid ID');
      return;
    }

    stdout.write('Enter name: ');
    String? name = stdin.readLineSync();
    if (name == null || !isAlphabet(name)) {
      print('Invalid Name');
      return;
    }

    // Lấy danh sách sinh viên từ file
    var students = await getAllStudents(filePath);

    // Lưu vào file
    Student student = Student(id, name);

    // Thêm sinh viên vao List
    students.add(student);

    // Thêm List vào Json file
    await saveStudent(filePath, students);

    /*  */
    int student_id = students.isEmpty ? 1 : students.last.id + 1;
  }

  @override
  Future<void> deleteStudent() {
    // TODO: implement deleteStudent
    throw UnimplementedError();
  }

  @override
  Future<void> findStudentByName() {
    // TODO: implement findStudentByName
    throw UnimplementedError();
  }

  @override
  Future<List<Student>> getAllStudents(String filePath) async {
    if (!File(filePath).existsSync()) {
      await File(filePath).create();
      await File(filePath).writeAsString(jsonEncode([]));
      return [];
    }
    String content = await File(filePath).readAsString();
    List<dynamic> jsonData = jsonDecode(content);

    var students = jsonData.map((json) => Student.fromJson(json)).toList();
    return students;
  }

  @override
  Future<void> getStudentHighestScore() {
    // TODO: implement getStudentHighestScore
    throw UnimplementedError();
  }

  @override
  bool isAlphabet(String str) {
    // TODO: implement isAlphabet
    throw UnimplementedError();
  }

  @override
  Future<void> saveStudent(String filePath, List<Student> students) {
    // TODO: implement saveStudent
    throw UnimplementedError();
  }

  @override
  Future<void> updateStudent() {
    // TODO: implement updateStudent
    throw UnimplementedError();
  }

  @override
  Future<void> displayStudent(String filePath) async {
    List<Student> students = await getAllStudents(filePath);
    if (students.isEmpty) {
      print('Student is empty');
    }
    for (var student in students) {
      print(student);
    }
  }
}
