import 'dart:io';
import 'services/student_service.dart';
import 'services_implement/student_service_implement.dart';
import 'package:path/path.dart' as p;

void main() async {
  const String fileName = 'student.json';
  final String directoryPath = p.join(Directory.current.path, 'data');

  /* Thư mục sẽ lưu file */
  final Directory directory = Directory(directoryPath);

  if (!await directory.exists()) {
    await directory.create(recursive: true);
  }

  final String filePath = p.join(directoryPath, fileName);

  while (true) {
    stdout.write('''
    Menu:
    1. Get All Students
    2. Add Student
    3. Update Student
    4. Find Student
    5. Get Highest Score
    6. Delete Student
    7. Exit
    Enter number: ''');

    String? choice = stdin.readLineSync();
    StudentService studentService = StudentServiceImplement();

    switch (choice) {
      case '1':
        await studentService.displayStudent(filePath);
        break;
      case '2':
        await studentService.addStudent(filePath);
        break;
      case '3':
        await studentService.updateStudent();
        break;
      case '4':
        await studentService.findStudentByName();
        break;
      case '5':
        await studentService.getStudentHighestScore();
        break;
      case '6':
        await studentService.deleteStudent();
        break;
      case '7':
        print('Good bye');
        exit(0);
      default:
        print('Invalid number');
    }
  }
}
