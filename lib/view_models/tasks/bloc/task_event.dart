part of 'task_bloc.dart';

@freezed
class TaskEvent with _$TaskEvent {
  const factory TaskEvent.fetchTasks({
    @Default(1) int page,
    @Default(10) int limit,
    @Default(false) bool forceRefresh,
  }) = _FetchTasks;

  const factory TaskEvent.addTask(TodoModel model) = _AddTask;
  const factory TaskEvent.updateTask(int taskId, TodoModel model) = _UpdateTask;
  const factory TaskEvent.deleteTask(int taskId) = _DeleteTask;
}
