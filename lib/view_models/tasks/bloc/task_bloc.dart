import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_manager/core/storage/task_local_store.dart';
import 'package:task_manager/models/tasks/task_model.dart';
import 'package:task_manager/view_models/tasks/repositories/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';
part 'task_bloc.freezed.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository;

  bool _isFetching = false;
  int _currentPage = 1;
  final int _limit = 20;
  final List<TodoModel> _allTasks = [];

  TaskBloc(this._taskRepository) : super(TaskState.initial()) {
    on<_FetchTasks>(_fetchTasks);
    on<_AddTask>(_addTask);
    on<_UpdateTask>(_updateTask);
    on<_DeleteTask>(_deleteTask);
  }

  /// **Fetch Tasks - Load from Local Storage, If Empty, Fetch from API**
  Future<void> _fetchTasks(_FetchTasks event, Emitter<TaskState> emit) async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      emit(TaskState.loading());

      // Fetch new tasks
      List<TodoModel> newTasks = await _taskRepository.fetchTasks(
        _currentPage,
        _limit,
      );

      if (newTasks.isNotEmpty) {
        _allTasks.addAll(newTasks);
        _currentPage++;
        log("Loaded ${newTasks.length} new tasks. Total: ${_allTasks.length}");
      } else {
        log("No more tasks to load.");
      }

      emit(TaskState.success(List.from(_allTasks)));
    } catch (e, stackTrace) {
      emit(TaskState.failure('Failed to fetch tasks: $e'));
      log("Error fetching tasks: $e");
      log("$stackTrace");
    } finally {
      _isFetching = false;
    }
  }

  /// **Add Task - Add to API, then Update Local Storage**
  Future<void> _addTask(_AddTask event, Emitter<TaskState> emit) async {
    try {
      await _taskRepository.addTask(event.model);

      List<TodoModel> tasks = await TaskLocalStorage.loadTasks();

      final newTask = event.model.copyWith(
        id: event.model.id ?? DateTime.now().millisecondsSinceEpoch,
      );

      tasks.insert(0, newTask);
      await TaskLocalStorage.saveTasks(tasks);

      emit(TaskState.success(tasks));
    } catch (e, stackTrace) {
      emit(TaskState.failure('Failed to add task: $e'));
      log(stackTrace.toString());
    }
  }

  /// **Update Task - Update on API, then Update Local Storage**
  Future<void> _updateTask(_UpdateTask event, Emitter<TaskState> emit) async {
    try {
      await _taskRepository.updateTask(
        event.taskId,
        event.model.completed ?? false,
      );

      List<TodoModel> tasks = await TaskLocalStorage.loadTasks();
      final index = tasks.indexWhere((task) => task.id == event.taskId);

      if (index == -1) {
        emit(TaskState.failure('Task not found in local storage'));
        return;
      }

      tasks[index] = event.model;
      await TaskLocalStorage.saveTasks(tasks);

      emit(TaskState.success(List.from(tasks)));
    } catch (e, stackTrace) {
      emit(TaskState.failure('Failed to update task: $e'));
      log("$stackTrace");
    }
  }

  /// **Delete Task - Remove from API, then Local Storage**
  Future<void> _deleteTask(_DeleteTask event, Emitter<TaskState> emit) async {
    try {
      // Call API delete
      await _taskRepository.deleteTask(event.taskId);

      List<TodoModel> tasks = await TaskLocalStorage.loadTasks();

      tasks.removeWhere((task) => task.id == event.taskId || task.id == null);

      await TaskLocalStorage.saveTasks(tasks);
      emit(TaskState.success(List.from(tasks))); // Ensure UI updates
    } catch (e, stackTrace) {
      emit(TaskState.failure('Failed to delete task: $e'));
      log("Error deleting task: $stackTrace");
    }
  }
}
