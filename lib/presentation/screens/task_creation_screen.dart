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
    'Shaheed',
    'Yaseen',
    'Ismail',
    'Swalih',
    'Anshif',
    'Dilshad',
  ];

  final _taskNameFocusNode = FocusNode();
  final _taskDescriptionFocusNode = FocusNode();

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? AppStrings.editTask : AppStrings.createTask,
        ),
      ),
      body: SafeArea(
        child: BlocListener<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is CreateTaskSuccess) {
              Navigator.pop(context);
            } else if (state is CreateTaskError) {
              showCustomSnackbar(
                  context: context,
                  message: state.message,
                  type: SnackBarType.error);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Card(
                color: AppColors.cardColor,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextField(
                        controller: _taskNameController,
                        focusNode: _taskNameFocusNode,
                        labelText: AppStrings.taskNameLabel,
                        textStyle: const TextStyle(color: AppColors.white),
                        labelStyle: const TextStyle(color: AppColors.grey),
                        fillColor: AppColors.inputBackgroundColor,
                        borderRadius: 12,
                        validator: (value) => value?.isEmpty ?? true
                            ? AppStrings.enterTaskNameError
                            : null,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: _taskDescriptionController,
                        focusNode: _taskDescriptionFocusNode,
                        labelText: AppStrings.taskDescriptionLabel,
                        textStyle: const TextStyle(color: AppColors.white),
                        labelStyle: const TextStyle(color: AppColors.grey),
                        fillColor: AppColors.inputBackgroundColor,
                        borderRadius: 12,
                        maxLines: 3,
                        validator: (value) => value?.isEmpty ?? true
                            ? AppStrings.enterTaskDescriptionError
                            : null,
                      ),
                      const SizedBox(height: 20),
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
                        textStyle: const TextStyle(color: AppColors.white),
                        labelStyle: const TextStyle(color: AppColors.grey),
                        fillColor: AppColors.inputBackgroundColor,
                        borderRadius: 12,
                        dropdownColor: AppColors.inputBackgroundColor,
                        validator: (value) => value == null
                            ? AppStrings.selectEmployeeError
                            : null,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: AppColors.black,
                          elevation: 4,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (widget.isEdit) {
                              BlocProvider.of<TaskBloc>(context).add(
                                EditTaskEvent(
                                  task: TaskModel(
                                    id: widget.task!.id,
                                    name: _taskNameController.text,
                                    description:
                                        _taskDescriptionController.text,
                                    assignedEmployee: _selectedEmployee!,
                                  ),
                                ),
                              );
                            } else {
                              BlocProvider.of<TaskBloc>(context).add(
                                CreateTaskEvent(
                                  task: TaskModel(
                                    name: _taskNameController.text,
                                    description:
                                        _taskDescriptionController.text,
                                    assignedEmployee: _selectedEmployee!,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: Text(
                          widget.isEdit
                              ? AppStrings.editTask
                              : AppStrings.createTask,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
    _taskNameFocusNode.dispose();
    _taskDescriptionFocusNode.dispose();
    super.dispose();
  }
}
