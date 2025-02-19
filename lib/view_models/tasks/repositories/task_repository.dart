import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:task_manager/models/tasks/task_model.dart';

class TaskRepository {
  final String baseUrl = 'https://dummyjson.com/todos';
  final Dio _dio = Dio();
  int page = 1;
  int limit = 10;

  Future<List<TodoModel>> fetchTasks(int page, int limit) async {
    try {
      final response = await _dio.get(
        baseUrl,
        queryParameters: {'skip': (page - 1) * limit, 'limit': limit},
      );
      List<TodoModel> tasks =
          (response.data['todos'] as List)
              .map((task) => TodoModel.fromJson(task))
              .toList();
      return tasks;
    } catch (e) {
      log("Error fetching tasks: $e");
      return [];
    }
  }

  Future<void> addTask(TodoModel model) async {
    try {
      final response = await _dio.post(
        '$baseUrl/add',
        data: model.toJson(),
        options: Options(headers: {"Content-Type": "application/json"}),
      );
      log("Task Added: ${response.data}");
    } catch (e) {
      log("Error adding task: $e");
    }
  }

  Future<void> updateTask(int taskId, bool completed) async {
    try {
      final response = await _dio.put(
        '$baseUrl/$taskId',
        data: {'completed': completed},
        options: Options(headers: {"Content-Type": "application/json"}),
      );
      log("Task Updated: ${response.data}");
    } catch (e) {
      log("Error updating task: $e");
    }
  }

  Future<void> deleteTask(int taskId) async {
    try {
      await _dio.delete('$baseUrl/$taskId');
      log("Task Deleted: $taskId");
    } catch (e) {
      log("Error deleting task: $e");
    }
  }
}
