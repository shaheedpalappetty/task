import 'package:task_assignment/core/utils/imports.dart';

class TaskCreationScreen extends StatefulWidget {
  final bool isEdit;
  final TaskEntity? task;
  const TaskCreationScreen({super.key, this.isEdit = false, this.task});

  @override
  State<TaskCreationScreen> createState() => _TaskCreationScreenState();
}

class _TaskCreationScreenState extends State<TaskCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskNameController = TextEditingController();
  final _taskDescriptionController = TextEditingController();
  String? _selectedEmployee;

  final List<String> _employees = [
    'Employee 1',
    'Employee 2',
    'Employee 3',
    'Employee 4'
  ];
  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _taskNameController.text = widget.task?.name ?? "";
      _taskDescriptionController.text = widget.task?.description ?? "";
      _selectedEmployee = widget.task?.assignedEmployee ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is CreateTaskSuccess) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
                widget.isEdit ? AppStrings.editTask : AppStrings.createTask)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _taskNameController,
                  labelText: AppStrings.taskNameLabel,
                  validator: (value) => value?.isEmpty ?? true
                      ? AppStrings.enterTaskNameError
                      : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _taskDescriptionController,
                  labelText: AppStrings.taskDescriptionLabel,
                  maxLines: 3,
                  validator: (value) => value?.isEmpty ?? true
                      ? AppStrings.enterTaskDescriptionError
                      : null,
                ),
                const SizedBox(height: 16),
                CustomDropdown<String>(
                  value: _selectedEmployee,
                  labelText: AppStrings.assignToLabel,
                  items: _employees,
                  getLabel: (employee) => employee,
                  onChanged: (value) {
                    setState(() {
                      _selectedEmployee = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? AppStrings.selectEmployeeError : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isEdit) {
                        Logger.log("Edit Clicked task Id${widget.task!.id}");
                        BlocProvider.of<TaskBloc>(context).add(
                          EditTaskEvent(
                            task: TaskModel(
                              id: widget.task!.id,
                              name: _taskNameController.text,
                              description: _taskDescriptionController.text,
                              assignedEmployee: _selectedEmployee!,
                            ),
                          ),
                        );
                      } else {
                        BlocProvider.of<TaskBloc>(context).add(
                          CreateTaskEvent(
                            task: TaskModel(
                              name: _taskNameController.text,
                              description: _taskDescriptionController.text,
                              assignedEmployee: _selectedEmployee!,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: Text(widget.isEdit
                      ? AppStrings.editTask
                      : AppStrings.createTask),
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
