import 'dart:convert';
import 'dart:io';
import '../services/student_service.dart';
import '../models/student.dart';
import 'package:cli_table/cli_table.dart';

class StudentServiceImplement implements StudentService {
  @override
  Future<void> addStudent(String filePath) async {
    // Lấy danh sách sinh viên từ file
    var students = await getAllStudents(filePath);

    stdout.write('Enter name: ');
    String? name = stdin.readLineSync();
    if (name == null || !isAlphabet(name)) {
      print('Invalid Name');
      return;
    }

    // ID của sinh viên
    int id = students.isEmpty ? 1 : students.last.id + 1;

    // Lưu vào file
    Student student = Student(id, name);

    // Thêm sinh viên vao List
    students.add(student);

    // Thêm List vào Json file
    await saveStudent(filePath, students);
    
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
    RegExp alphabet = RegExp(r'^[A-Za-z]+$');
    return alphabet.hasMatch(str);
  }

  @override
  Future<void> saveStudent(String filePath, List<Student> students) async {
    String jsonContent =
        jsonEncode(students.map((student) => student.toJson()).toList());
    /* Ghi vào file */
    await File(filePath).writeAsString(jsonContent);
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

    final table = Table(
      header: ['ID', 'Name'], // Set headers
      columnWidths: [10, 20], // Optionally set column widhts,
    );

    for (var student in students) {
      table.add([student.id, student.name]);
    }
    print(table.toString());
  }
}
