import '../models/student.dart';

abstract class FileService {
  // Read
 List<Student> readData(String filePath);

  // Write
  void writeData(String filePath, List<Student> data);
}
