import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/tasks/task_model.dart';
import '../../view_models/tasks/bloc/task_bloc.dart';

class TaskEditScreen extends StatefulWidget {
  final TodoModel? task;

  const TaskEditScreen({super.key, this.task});

  @override
  _TaskEditScreenState createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _taskController.text = widget.task!.todo ?? '';
      _userIdController.text = widget.task!.userId.toString();
      _completed = widget.task!.completed!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Task' : 'Add New Task'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCustomTextField(_userIdController, "User ID", true),
            const SizedBox(height: 16),
            _buildCustomTextField(_taskController, "Task Description", false),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _completed,
                  onChanged: (value) {
                    setState(() {
                      _completed = value ?? false;
                    });
                  },
                ),
                Text(_completed ? "Completed" : "Uncompleted"),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final taskText = _taskController.text;
                  final userIdText = _userIdController.text;
                  final userId = int.tryParse(userIdText) ?? 1;

                  if (taskText.isNotEmpty) {
                    final taskModel = TodoModel(
                      id: widget.task?.id,
                      todo: taskText,
                      completed: _completed,
                      userId: userId,
                    );

                    if (isEditing) {
                      context.read<TaskBloc>().add(
                        TaskEvent.updateTask(widget.task!.id!, taskModel),
                      );
                    } else {
                      context.read<TaskBloc>().add(
                        TaskEvent.addTask(taskModel),
                      );
                    }

                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a task description'),
                      ),
                    );
                  }
                },
                child: Text(isEditing ? 'Update Task' : 'Add Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔥 Custom TextField with red border and white fill
  Widget _buildCustomTextField(
    TextEditingController controller,
    String label,
    bool isNumber,
  ) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white12, // White background inside field
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          ), // Red border
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.purple,
            width: 2,
          ), // Red border when focused
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.purple, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
