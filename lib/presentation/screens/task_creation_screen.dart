import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_assignment/data/models/task_model.dart';
import 'package:task_assignment/presentation/blocs/task/task_bloc.dart';

class TaskCreationScreen extends StatefulWidget {
  const TaskCreationScreen({super.key});

  @override
  State<TaskCreationScreen> createState() => _TaskCreationScreenState();
}

class _TaskCreationScreenState extends State<TaskCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  String? _selectedEmployee;

  final List<String> _employees = ['John', 'Jane', 'Mike', 'Sarah'];

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is CreateTaskSuccess) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Create Task")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _taskNameController,
                  decoration: const InputDecoration(labelText: 'Task Name'),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter task name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _taskDescriptionController,
                  decoration:
                      const InputDecoration(labelText: 'Task Description'),
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Please enter task description'
                      : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedEmployee,
                  decoration: const InputDecoration(labelText: 'Assign To'),
                  items: _employees.map((employee) {
                    return DropdownMenuItem(
                      value: employee,
                      child: Text(employee),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedEmployee = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select an employee' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<TaskBloc>().add(
                            CreateTaskEvent(
                              task: TaskModel(
                                name: _taskNameController.text,
                                description: _taskDescriptionController.text,
                                assignedEmployee: _selectedEmployee!,
                              ),
                            ),
                          );
                    }
                  },
                  child: const Text("Create Task"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
    super.dispose();
  }
}
