import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/models/tasks/task_model.dart';

class TaskLocalStorage {
  static const String _key = 'tasks';

  // Save tasks as JSON
  static Future<void> saveTasks(List<TodoModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedTasks = json.encode(
      tasks.map((task) => task.toJson()).toList(),
    );
    await prefs.setString(_key, encodedTasks);
  }

  // Load tasks and convert them into TodoModel objects
  static Future<List<TodoModel>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = prefs.getString(_key);
    if (tasks != null) {
      return (json.decode(tasks) as List)
          .map((task) => TodoModel.fromJson(task))
          .toList();
    }
    return [];
  }

  // Clear tasks
  static Future<void> clearTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
