import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/view_models/auth/cubit/auth_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthCubit>().checkLoginStatus();

    return BlocListener<AuthCubit, bool>(
      listener: (context, isAuthenticated) {
        if (isAuthenticated) {
          Navigator.pushReplacementNamed(context, AppRoutes.task);
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
      },
      child: Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
