import 'dart:convert';
import 'dart:io';
import '../services/student_service.dart';
import '../models/student.dart';
import '../models/subject.dart';
import 'package:cli_table/cli_table.dart';
import '../services/file_service.dart';
import '../services_implement/file_service_implement.dart';

class StudentServiceImplement implements StudentService {
  @override
  Future<void> addStudent(String filePath) async {
    // Lấy danh sách sinh viên từ file
    List<Student> students = await getAllStudents(filePath);

    stdout.write('Enter Student Name: ');
    String? name = stdin.readLineSync();
    if (name == null || !isAlphabet(name)) {
      print('Invalid Student Name');
      return;
    }

    // Student ID
    int id = students.isEmpty ? 1 : students.last.id + 1;

    // Subject
    List<Subject> subjects = [];

    for (var i = 0; i < 3; i++) {
      stdout.write('Enter Subject Name: ');
      String? subjectName = stdin.readLineSync();
      if (subjectName == null || !isAlphabet(subjectName)) {
        print('Invalid Subject Name');
        return;
      }

      // Score
      List<int> scores = [];

      for (int i = 0; i < 3; i++) {
        stdout.write('Enter Score ${i + 1} for Subject $subjectName: ');
        int? score = int.tryParse(stdin.readLineSync() ?? '');
        if (score == null) {
          print('Invalid Score');
          return;
        }
        scores.add(score);
      }
      var newSubject = Subject(subjectName: subjectName, scores: scores);
      subjects.add(newSubject);
    }
    var newStudent = Student(id: id, name: name, subjects: subjects);
    students.add(newStudent);

    // Add List to Json file
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
    FileService fileService = FileServiceImplement();

    // Check file exist
    if (!File(filePath).existsSync()) {
      await File(filePath).create();
      await File(filePath).writeAsString(jsonEncode({'students': []}));
      return [];
    }

    var students = fileService.readData(filePath);
    return students;
  }

  @override
  Future<void> getStudentHighestScore() {
    // TODO: implement getStudentHighestScore
    throw UnimplementedError();
  }

  @override
  Future<void> saveStudent(String filePath, List<Student> students) async {
    FileService fileService = FileServiceImplement();
    fileService.writeData(filePath, students);
    print('Add student successfully');
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
      return;
    }

    final table = Table(
      // Set headers
      header: [
        'ID',
        'Name',
        'Subject',
        'Score',
      ],
    );

    for (var student in students) {
      for (var subject in student.subjects) {
        table.add([
          student.id,
          student.name.toUpperCase(),
          subject.subjectName.toUpperCase(),
          subject.scores.join(' - ')
        ]);
      }
    }

    print(table.toString());
  }

  @override
  bool isAlphabet(String str) {
    RegExp alphabet = RegExp(r'^[a-zA-Z\s]+$');
    return alphabet.hasMatch(str);
  }
}
