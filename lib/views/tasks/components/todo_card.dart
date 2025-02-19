import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/view_models/tasks/bloc/task_bloc.dart';
import 'package:task_manager/views/tasks/task_edit_screen.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({super.key, required this.model});

  final dynamic model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white10),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: ListTile(
        title: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(colors: [Colors.blue, Colors.pink]),
          ),
          child: Text(
            "Description",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Text(
          model.todo ?? "null",
          style: TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: model.completed ? Colors.green : Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Text(
            model.completed ? 'Completed' : 'Incomplete',
            style: TextStyle(color: Colors.white),
          ),
        ),
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskEditScreen(task: model),
              ),
            ),
        onLongPress: () {
          if (model.id != null) {
            context.read<TaskBloc>().add(TaskEvent.deleteTask(model.id!));
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Task deleted')));
          }
        },
      ),
    );
  }
}
