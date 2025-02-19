part of 'task_bloc.dart';

@freezed
class TaskState with _$TaskState {
   const factory TaskState.initial() = _Initial;
  const factory TaskState.loading() = _Loading;
  const factory TaskState.success(List<dynamic> tasks) = _Success;
  const factory TaskState.failure(String error) = _Failure;
}
