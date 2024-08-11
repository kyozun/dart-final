import 'dart:convert';
import 'dart:io';
import '../services/student_service.dart';
import '../models/student.dart';
import '../models/subject.dart';
import 'package:cli_table/cli_table.dart';
import '../services/file_service.dart';
import '../services_implement/file_service_implement.dart';
import '../types/find_by.dart';

class StudentServiceImplement implements StudentService {
  // Create
  @override
  Future<void> addStudent(String filePath) async {
    // Get Student List From Json File
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
    var newStudent =
        Student(id: id, name: name.toLowerCase(), subjects: subjects);
    students.add(newStudent);

    // Add List to Json file
    await saveStudent(filePath, students);
    print('Add student successfully');
  }

  // Delete
  @override
  Future<void> deleteStudent(filePath) async {
    // Get Student List From Json File
    List<Student> students = await getAllStudents(filePath);

    stdout.write('Enter Student Name: ');
    String? name = stdin.readLineSync();
    if (name == null || !isAlphabet(name)) {
      print('Invalid Student Name');
      return;
    }

    // Find Student By Name
    var foundStudents =
        students.where((student) => student.name == name.toLowerCase());
    if (foundStudents.isEmpty) {
      print('Student Not Found');
      return;
    }

    // Remove Student By Name
    students.removeWhere((student) => student.name == name.toLowerCase());
    await saveStudent(filePath, students);
    print('Remove Student Successfully');
  }

  // Get
  @override
  Future<void> findStudentByName(filePath, FindBy findByName) async {
    // Get Student List From Json File
    List<Student> students = await getAllStudents(filePath);

    stdout.write('Enter Student Name: ');
    String? name = stdin.readLineSync();
    if (name == null || !isAlphabet(name)) {
      print('Invalid Student Name');
      return;
    }

    List<Student> foundStudents = [];
    for (var student in students) {
      if (student.name.contains(name.toLowerCase())) {
        foundStudents.add(student);
      }
    }
    if (foundStudents.isEmpty) {
      print('Student not found');
      return;
    }
    await displayStudent(filePath, findByName, foundStudents: foundStudents);
    return;
  }

  // Get
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

  // Get
  @override
  Future<void> getStudentHighestScore(filePath) async {
    // Get Student List From Json File
    List<Student> students = await getAllStudents(filePath);

    stdout.write('Enter Subject Name: ');
    String? subjectName = stdin.readLineSync();
    if (subjectName == null || !isAlphabet(subjectName)) {
      print('Invalid Subject Name');
      return;
    }

    //  Find Subject By Name
    var found = 0;
    List<Subject> newSubjects = [];

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
        subject.scores.sort((a, b) => b.compareTo(a));
      }
    }

    for (var student in students) {
      var subjectIndex = student.subjects.indexWhere(
          (subject) => subject.subjectName == subjectName.toLowerCase());
      if (subjectIndex > -1) {
        found++;
        newSubjects.add(student.subjects[subjectIndex]);
        table.add([
          student.id,
          student.name,
          student.subjects[subjectIndex].subjectName,
          student.subjects[subjectIndex].scores.toString()
        ]);
      }
    }
    if (found == 0) {
      print('Subject Not Found');
      return;
    }
    print(table.toString());
  }

  // Update
  @override
  Future<void> updateStudent(filePath) async {
    // Get Student List From Json File
    List<Student> students = await getAllStudents(filePath);

    stdout.write('Enter Student ID: ');
    int? id = int.tryParse(stdin.readLineSync() ?? '');
    if (id == null) {
      print('Invalid ID');
      return;
    }

    // Find Student By ID
    var studentIndex = students.indexWhere((student) => student.id == id);
    var foundStudent = studentIndex > -1 ? students[studentIndex] : null;

    if (foundStudent == null) {
      print('Student Not Found');
      return;
    }

    // Update Student
    stdout.write('Enter Student Name: ');
    String? name = stdin.readLineSync();
    if (name == null || !isAlphabet(name)) {
      print('Invalid Student Name');
      return;
    }

    foundStudent.name = name;
    await saveStudent(filePath, students);
    print('Update Student Successfully');
  }

  @override
  Future<void> displayStudent(String filePath, FindBy findBy,
      {List<Student>? foundStudents}) async {
    final table = Table(
      // Set headers
      header: [
        'ID',
        'Name',
        'Subject',
        'Score',
      ],
    );

    if (findBy == FindBy.name) {
      for (var student in foundStudents!) {
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
    } else {
      List<Student> students = await getAllStudents(filePath);
      if (students.isEmpty) {
        print('Student is empty');
        return;
      }

      for (var student in students) {
        for (var subject in student.subjects) {
          table.add([
            student.id,
            student.name.toUpperCase(),
            subject.subjectName.toUpperCase(),
            subject.scores.join(' - ').toString()
          ]);
        }
      }

      print(table.toString());
    }
  }

  @override
  Future<void> saveStudent(String filePath, List<Student> students) async {
    FileService fileService = FileServiceImplement();
    fileService.writeData(filePath, students);
  }

  @override
  bool isAlphabet(String str) {
    RegExp alphabet = RegExp(r'^[a-zA-Z\s]+$');
    return alphabet.hasMatch(str);
  }
}
