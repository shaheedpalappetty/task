import 'package:flutter/material.dart';

class TaskCreationScreen extends StatefulWidget {
  const TaskCreationScreen({super.key});

  @override
  TaskCreationScreenState createState() => TaskCreationScreenState();
}

class TaskCreationScreenState extends State<TaskCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  String? _selectedEmployee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _taskNameController,
                decoration: const InputDecoration(labelText: "Task Name"),
                validator: (value) =>
                    value!.isEmpty ? "Task name is required" : null,
              ),
              TextFormField(
                controller: _taskDescriptionController,
                decoration: const InputDecoration(
                  labelText: "Task Description",
                ),
                validator: (value) =>
                    value!.isEmpty ? "Task Decription is required" : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedEmployee,
                items: ["Employee 1", "Employee 2", "Employee 3"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => _selectedEmployee = value,
                decoration: const InputDecoration(labelText: "Assign To"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Navigator.pop(context);
                  }
                },
                child: const Text("Create Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
