import 'package:task_assignment/core/utils/imports.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    super.id,
    required super.name,
    required super.description,
    required super.assignedEmployee,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      assignedEmployee: map['assignedEmployee'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'assignedEmployee': assignedEmployee,
    };
  }
}
