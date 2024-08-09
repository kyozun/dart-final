
abstract class FileService {
  // Read
  Map<String, dynamic> readData(String filePath);

  // Write
  void writeData(String filePath, Map<String, dynamic> data);
}
