import 'dart:convert';
import 'dart:io';
import '../services/file_service.dart';

class FileServiceImplement implements FileService {
  // Read
  @override
  Map<String, dynamic> readData(String filePath) {
    var file = File(filePath);
    var jsonString = file.readAsStringSync();
    return jsonDecode(jsonString);
  }

  // Write
  @override
  void writeData(String filePath, Map<String, dynamic> data) async {
    var file = File(filePath);
    var jsonString = jsonEncode(data);
    file.writeAsStringSync(jsonString);
  }
}
