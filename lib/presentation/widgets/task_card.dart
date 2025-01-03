import 'package:task_assignment/core/utils/imports.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;
  final int index;

  const TaskCard({
    required this.task,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id.toString()),
      direction: DismissDirection.endToStart,
      background: _buildDismissibleBackground(),
      confirmDismiss: (_) => _showDeleteConfirmation(context),
      onDismissed: (_) => _handleDismiss(context),
      child: _buildCard(context),
    );
  }

  Widget _buildDismissibleBackground() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.error700,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const Icon(Icons.delete, color: AppColors.white),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      color: AppColors.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _buildAvatar(),
            const SizedBox(width: 16),
            Expanded(child: _buildTaskDetails()),
            _buildEditButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 24,
      backgroundColor: AppColors.primaryColor,
      child: Text(
        (index + 1).toString(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTaskDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          task.name.toUpperCase(),
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          task.description,
          style: const TextStyle(color: AppColors.grey),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          "${AppStrings.assignedTo} ${task.assignedEmployee}",
          style: const TextStyle(
            color: AppColors.grey,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit, color: AppColors.errorColor),
      onPressed: () => _navigateToEdit(context),
    );
  }

  void _navigateToEdit(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TaskCreationScreen(
          isEdit: true,
          task: task,
        ),
      ),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColors.cardColor,
            title: const Text(AppStrings.confirm,
                style: TextStyle(color: Colors.white)),
            content: Text(
              "${AppStrings.sureToDelete} ${task.name}?",
              style: const TextStyle(color: AppColors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(AppStrings.cancel,
                    style: TextStyle(color: AppColors.grey)),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(AppStrings.delete,
                    style: TextStyle(color: AppColors.errorColor)),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _handleDismiss(BuildContext context) {
    context.read<TaskBloc>().add(DeleteTaskEvent(taskId: task.id!));
  }
}
