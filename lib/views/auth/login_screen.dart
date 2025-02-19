import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/view_models/auth/cubit/auth_cubit.dart';
import '../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void loginUser(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return; // ✅ Validate first!

    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    if (context.mounted) {
      context.read<AuthCubit>().login(
        usernameController.text,
        passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.deepPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              color: Colors.white.withOpacity(0.9),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey, // ✅ Form key added
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          labelText: "Username",
                        ),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? "Enter username"
                                    : null,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: "Password",
                        ),
                        obscureText: true,
                        validator:
                            (value) =>
                                value == null || value.length < 6
                                    ? "Password must be at least 6 characters"
                                    : null,
                      ),
                      const SizedBox(height: 20),

                      // BlocListener for authentication state
                      BlocListener<AuthCubit, bool>(
                        listener: (context, isAuthenticated) {
                          if (isAuthenticated) {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.task,
                            );
                          } else {
                            setState(() => isLoading = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Login failed!")),
                            );
                          }
                        },
                        child: const SizedBox.shrink(),
                      ),

                      // Animated Button
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 50,
                        width:
                            isLoading
                                ? 50
                                : MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(
                            isLoading ? 50 : 8,
                          ),
                        ),
                        alignment: Alignment.center,
                        child:
                            isLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : GestureDetector(
                                  onTap: () => loginUser(context),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
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
}
