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
    stdout.write('Enter name: ');
    String? name = stdin.readLineSync();
    if (name == null || !isAlphabet(name)) {
      print('Invalid Name');
      return;
    }

    // ID của sinh viên
    int id = students.isEmpty ? 1 : students.last.id + 1;

    /**********************************************************************/

    // Subject
    List<Map<String, dynamic>> subjects = [];
    stdout.write('Enter Number of Subject: ');
    int numberSubject = int.parse(stdin.readLineSync()!);

    stdout.write('Enter Subject Name: ');
    String? subjectName = stdin.readLineSync();
    if (subjectName == null || !isAlphabet(subjectName)) {
      print('Invalid Subject Name');
      return;
    }

    List<int> scores = [];
    for (var i = 0; i < 3; i++) {
      stdout.write('Enter Score $i: ');
      int? score = int.tryParse(stdin.readLineSync() ?? '');
      if (score == null) {
        print('Invalid score');
        return;
      }
      scores.add(score);
    }

    print('Score $scores');

    // Tạo Subject object
    Subject subject = Subject(subjectName: subjectName, scores: scores);
    print(subject);

    subjects.add(subject);
    print(subjects);

    // Tạo student object
    Student student = Student(id: id, name: name, subjects: subjects);

    print('Student name is $student.name');

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
    FileService fileService = FileServiceImplement();

    // Check file exist
    if (!File(filePath).existsSync()) {
      await File(filePath).create();
      await File(filePath).writeAsString(jsonEncode({}));
      return [];
    }

    var data = fileService.readData(filePath);
    var students = data['students'];
    return students ?? [];
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
    FileServiceImplement fileService = FileServiceImplement();
    fileService.writeData(filePath, {'students': students});
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
    }

    final table = Table(
      // Set headers
      header: ['ID', 'Name', 'Subject', 'Score'],
      // Optionally set column widhts,
      columnWidths: [
        10,
        10,
        10,
        10,
      ],
    );

    for (var student in students) {
      table.add([student.id, student.name]);
    }
    print(table.toString());
  }
}
