class Student {
  int id;
  String name;
  Student(this.id, this.name);

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  static Student fromJson(Map<String, dynamic> json) {
    return Student(json['id'], json['name']);
  }

  @override
  String toString() {
    return 'ID: $id, Name: $name';
  }
}
