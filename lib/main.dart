import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/observers/app_bloc_observer.dart';
import 'package:task_manager/view_models/auth/cubit/auth_cubit.dart';
import 'package:task_manager/view_models/auth/repo/auth_repository.dart';
import 'package:task_manager/view_models/tasks/bloc/task_bloc.dart';
import 'package:task_manager/view_models/tasks/repositories/task_repository.dart';
import 'package:task_manager/views/auth/login_screen.dart';
import 'package:task_manager/views/tasks/task_screen.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(AuthRepository())),
        BlocProvider(
          create:
              (context) =>
                  TaskBloc(TaskRepository())..add(TaskEvent.fetchTasks()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager',
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}

class AppRoutes {
  static const String login = '/login';
  static const String task = '/task';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      case task:
        return MaterialPageRoute(builder: (context) => TaskScreen());

      default:
        return MaterialPageRoute(
          builder:
              (context) =>
                  Scaffold(body: Center(child: Text('Page not found!'))),
        );
    }
  }
}
