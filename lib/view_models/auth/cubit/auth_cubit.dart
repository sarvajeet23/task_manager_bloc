import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/view_models/auth/repo/auth_repository.dart';

class AuthCubit extends Cubit<bool> {
  final AuthRepository repository;

  AuthCubit(this.repository) : super(false);

  void login(String username, String password) async {
    final token = await repository.loginUser(username, password);
    emit(token != null);
  }

  void logout() async {
    await repository.logoutUser();
    emit(false);
  }

  Future<void> checkLoginStatus() async {
    bool loggedIn = await repository.isUserLoggedIn();
    emit(loggedIn);
  }
}
