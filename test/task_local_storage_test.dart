import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/core/storage/task_local_store.dart';
import 'package:task_manager/models/tasks/task_model.dart';
import 'dart:convert';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('should save and load tasks correctly', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    final task = TodoModel(id: 1, todo: 'Test Task', completed: false);
    await TaskLocalStorage.saveTasks([task]);

    final storedTasks = await TaskLocalStorage.loadTasks();
    expect(storedTasks.length, 1);
    expect(storedTasks.first.todo, 'Test Task');
  });

  test('should clear tasks', () async {
    SharedPreferences.setMockInitialValues({});
    await TaskLocalStorage.clearTasks();

    final storedTasks = await TaskLocalStorage.loadTasks();
    expect(storedTasks, []);
  });
}
