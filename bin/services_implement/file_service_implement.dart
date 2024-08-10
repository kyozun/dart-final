import 'dart:convert';
import 'dart:io';
import '../services/file_service.dart';
import '../models/student.dart';

class FileServiceImplement implements FileService {
  // Read
  @override
  List<Student> readData(String filePath) {
    var file = File(filePath);
    var jsonData = file.readAsStringSync();

    // decode the json
    List<dynamic> parsedJson = jsonDecode(jsonData)['students'] ;

    // convert parsedJson to Class  
    var students = parsedJson.map((parsedJson) => Student.fromJson(parsedJson)).toList();
    return students;
  }

  // Write
  @override
  void writeData(String filePath, List<Student> students) {
    var file = File(filePath);

    // Encode Json
    var jsonString = jsonEncode({'students' : students});

    file.writeAsStringSync(jsonString);
  }
}
