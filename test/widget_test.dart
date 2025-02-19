import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager/view_models/auth/cubit/auth_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:task_manager/view_models/auth/repo/auth_repository.dart';

// Generate Mock Class
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

  test('Initial state should be false', () {
    expect(authCubit.state, false);
  });

  blocTest<AuthCubit, bool>(
    'emits [true] when login is successful',
    build: () {
      when(
        mockAuthRepository.loginUser('testuser', 'password'),
      ).thenAnswer((_) async => 'mockToken');
      when(
        mockAuthRepository.saveToken(mockAuthRepository as String),
      ).thenAnswer((_) async {});
      return authCubit;
    },
    act: (cubit) => cubit.login('testuser', 'password'),
    expect: () => [true],
  );

  blocTest<AuthCubit, bool>(
    'emits [false] when login fails',
    build: () {
      when(
        mockAuthRepository.loginUser('testuser', 'wrongpassword'),
      ).thenAnswer((_) async => null);
      return authCubit;
    },
    act: (cubit) => cubit.login('testuser', 'wrongpassword'),
    expect: () => [false],
  );

  blocTest<AuthCubit, bool>(
    'emits [false] when logging out',
    build: () {
      when(mockAuthRepository.logoutUser()).thenAnswer((_) async {});
      return authCubit;
    },
    act: (cubit) => cubit.logout(),
    expect: () => [false],
  );

  blocTest<AuthCubit, bool>(
    'emits [true] if user is already logged in',
    build: () {
      when(mockAuthRepository.isUserLoggedIn()).thenAnswer((_) async => true);
      return authCubit;
    },
    act: (cubit) => cubit.checkLoginStatus(),
    expect: () => [true],
  );

  blocTest<AuthCubit, bool>(
    'emits [false] if user is not logged in',
    build: () {
      when(mockAuthRepository.isUserLoggedIn()).thenAnswer((_) async => false);
      return authCubit;
    },
    act: (cubit) => cubit.checkLoginStatus(),
    expect: () => [false], // ✅ Expect user is not logged in
  );
}
