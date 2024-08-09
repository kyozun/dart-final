import '../models/student.dart';

abstract class StudentService {
  Future<void> addStudent(String filePath);

  Future<List<Student>> getAllStudents(String filePath);

  Future<void> displayStudent(String filePath);

  Future<void> saveStudent(String filePath, List<Student> students);

  Future<void> deleteStudent();

  Future<void> updateStudent();

  Future<void> findStudentByName();

  Future<void> getStudentHighestScore();

  bool isAlphabet(String str) {
    RegExp alphabet = RegExp(r'^[A-Za-z]+$');
    return alphabet.hasMatch(str);
  }
}
