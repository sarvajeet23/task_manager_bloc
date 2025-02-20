import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:task_manager/view_models/tasks/bloc/task_bloc.dart';
import 'package:task_manager/view_models/tasks/repositories/task_repository.dart';
import 'package:task_manager/models/tasks/task_model.dart';

// Mock Repository
class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late TaskBloc taskBloc;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    taskBloc = TaskBloc(mockTaskRepository);
  });

  tearDown(() {
    taskBloc.close();
  });

  blocTest<TaskBloc, TaskState>(
    'emits [loading, success] when fetching tasks is successful',
    build: () {
      when(
        mockTaskRepository.fetchTasks(1, 10),
      ).thenAnswer((_) async => [TodoModel(id: 1, todo: 'Test Task')]);
      return taskBloc;
    },
    act: (bloc) => bloc.add(const TaskEvent.fetchTasks()),
    expect:
        () => [
          const TaskState.loading(),
          TaskState.success([TodoModel(id: 1, todo: 'Test Task')]),
        ],
  );

  blocTest<TaskBloc, TaskState>(
    'emits [loading, failure] when fetching tasks fails',
    build: () {
      when(
        mockTaskRepository.fetchTasks(
          mockTaskRepository.limit,
          mockTaskRepository.page,
        ),
      ).thenThrow(Exception('API Error'));
      return taskBloc;
    },
    act: (bloc) => bloc.add(const TaskEvent.fetchTasks()),
    expect:
        () => [
          const TaskState.loading(),
          const TaskState.failure(
            'Failed to fetch tasks: Exception: API Error',
          ),
        ],
  );
}
