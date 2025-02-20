import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/routes/app_routes.dart';
import 'package:task_manager/view_models/auth/cubit/auth_cubit.dart';
import 'package:task_manager/view_models/tasks/bloc/task_bloc.dart';
import 'package:task_manager/views/tasks/components/todo_card.dart';
import 'package:task_manager/views/tasks/task_edit_screen.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      context.read<TaskBloc>().add(TaskEvent.fetchTasks());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            title: Text('Task Manager'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  context.read<AuthCubit>().logout();
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.purple.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            return state.when(
              initial: () => Center(child: Text('Welcome!')),
              loading:
                  () => Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
              success:
                  (tasks) => RefreshIndicator(
                    color: Colors.amber,
                    elevation: 0,
                    onRefresh: () async {
                      context.read<TaskBloc>().add(TaskEvent.fetchTasks());
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: BouncingScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final model = tasks[index];
                        return TodoCard(model: model);
                      },
                    ),
                  ),
              failure: (error) => Center(child: Text(error)),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskEditScreen(task: null)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
