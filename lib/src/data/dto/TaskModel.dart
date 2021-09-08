class TaskModel {
  int? id;
  String name;
  String description;
  int status;

  TaskModel({this.id,
    required this.status,
    required this.name,
    required this.description});

  factory TaskModel.fromMap(Map<dynamic, dynamic> map) {
    return new TaskModel(id: map['id'],
        status: map['status'],
        name: map['name'],
        description: map['description']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'status': this.status,
      'name': this.name,
      'description': this.description
    };
  }

  @override
  String toString() {
    return 'TaskModel {id=$id, status=$status, name=$name, description=$description}';
  }

}
