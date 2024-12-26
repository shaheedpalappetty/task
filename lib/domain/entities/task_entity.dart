class TaskEntity {
  final int? id;
  final String name;
  final String description;
  final String assignedEmployee;

  TaskEntity({
    this.id,
    required this.name,
    required this.description,
    required this.assignedEmployee,
  });
}
