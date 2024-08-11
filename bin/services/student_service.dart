import '../models/student.dart';
import '../types/find_by.dart';

abstract class StudentService {
  Future<void> addStudent(String filePath);

  Future<List<Student>> getAllStudents(String filePath);

  Future<void> displayStudent(String filePath, FindBy findBy, {List<Student> foundStudents});

  Future<void> saveStudent(String filePath, List<Student> students);

  Future<void> deleteStudent(filePath);

  Future<void> updateStudent(filePath);

  Future<void> findStudentByName(filePath, FindBy findBy);

  Future<void> getStudentHighestScore(filePath);

  bool isAlphabet(String str);
}
