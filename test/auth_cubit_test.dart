import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/view_models/auth/cubit/auth_cubit.dart';
import 'package:task_manager/view_models/auth/repo/auth_repository.dart';
import 'package:bloc_test/bloc_test.dart';

// Mock AuthRepository
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthCubit authCubit;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authCubit = AuthCubit(mockAuthRepository);
  });

  tearDown(() {
    authCubit.close();
  });

  blocTest<AuthCubit, bool>(
    'emits [true] when login is successful',
    build: () {
      when(mockAuthRepository.loginUser('testuser', 'password'))
          .thenAnswer((_) async => 'mock_token');
      return authCubit;
    },
    act: (cubit) => cubit.login('testuser', 'password'),
    expect: () => [true],
  );

  blocTest<AuthCubit, bool>(
    'emits [false] when login fails',
    build: () {
      when(mockAuthRepository.loginUser('testuser', 'wrongpassword'))
          .thenAnswer((_) async => null);
      return authCubit;
    },
    act: (cubit) => cubit.login('testuser', 'wrongpassword'),
    expect: () => [false],
  );

  blocTest<AuthCubit, bool>(
    'emits [false] when logging out',
    build: () {
      return authCubit;
    },
    act: (cubit) => cubit.logout(),
    expect: () => [false],
  );
}
