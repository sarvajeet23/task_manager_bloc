import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:task_manager/view_models/tasks/repositories/task_repository.dart';
import 'package:task_manager/models/tasks/task_model.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late TaskRepository taskRepository;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    taskRepository = TaskRepository();
  });

  // test('should return list of tasks when API call is successful', () async {
  //   when(mockDio.get(any)).thenAnswer((_) async => Response(
  //         requestOptions: RequestOptions(path: ''),
  //         data: {
  //           'todos': [
  //             {'id': 1, 'todo': 'Test Task', 'completed': false}
  //           ]
  //         },
  //       ));

  //   final result = await taskRepository.fetchTasks(1, 10);
  //   expect(result, isA<List<TodoModel>>());
  //   expect(result.first.todo, 'Test Task');
  // });

  // test('should return empty list when API call fails', () async {
  //   when(mockDio.get(any)).thenThrow(DioException(requestOptions: RequestOptions(path: '')));

  //   final result = await taskRepository.fetchTasks(1, 10);
  //   expect(result, []);
  // });
}
