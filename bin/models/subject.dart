class Subject {
  String subjectName;
  List<int> scores;

  Subject({required this.subjectName, required this.scores});

  // Convert Object to Json
  Map<String, dynamic> toJson() {
    return {'subjectName': subjectName, 'scores': scores};
  }

  // Convert parsedJson to Student Object
  factory Subject.fromJson(Map<String, dynamic> data) {
    var subjectname = data['subjectName'] as String;
    var scores = data['scores'].cast<int>();
    return Subject(subjectName: subjectname, scores: scores);
  }
}
