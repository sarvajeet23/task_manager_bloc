
import 'package:flutter/material.dart';
import 'package:task_manager/views/auth/login_screen.dart';
import 'package:task_manager/views/tasks/task_screen.dart';


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
