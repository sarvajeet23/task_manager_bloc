import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/view_models/auth/repo/auth_repository.dart';

// Mock Dio
class MockDio extends Mock implements Dio {}

// Mock SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late AuthRepository authRepository;
  late MockDio mockDio;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockDio = MockDio();
    authRepository = AuthRepository();
  });

  test('should return token when login is successful', () async {
    final response = Response(
      requestOptions: RequestOptions(path: ''),
      statusCode: 200,
      data: {'accessToken': 'mock_token'},
    );

    final result = await authRepository.loginUser('testuser', 'password');

    expect(result, 'mock_token');
  });

  test('should return null when login fails', () async {
  //  when(mockDio.post(any, data: anyNamed('data')))
  //   .thenThrow(DioException(requestOptions: RequestOptions(path: '')));


    final result = await authRepository.loginUser('testuser', 'wrongpassword');

    expect(result, null);
  });
}
