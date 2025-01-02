import 'package:app/core/error/failure.dart';
import 'package:app/features/mentee/domain/usecases/login_use_case.dart';
import 'package:app/features/mentee/domain/usecases/register_use_case.dart';
import 'package:app/features/mentee/presentation/viewmodel/mentee_viewmodel.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mentee_auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<LoginUseCase>(),
  MockSpec<RegisterUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late LoginUseCase mockLoginUseCase;
  late ProviderContainer container;
  late BuildContext context;
  late RegisterUseCase mockRegisterUseCase;

  setUpAll(() {
    mockLoginUseCase = MockLoginUseCase();
    context = MockBuildContext();
    mockRegisterUseCase = MockRegisterUseCase();
    container = ProviderContainer(overrides: [
      menteeViewModelProvider.overrideWith((ref) => MenteeViewModel(
          registerUseCase: mockRegisterUseCase, loginUseCase: mockLoginUseCase))
    ]);
  });

  test('login test with valid username and', () async {
    when(mockLoginUseCase.loginMentee('shristy', 'shristy123'))
        .thenAnswer((_) => Future.value(const Right(true)));


    container
        .read(menteeViewModelProvider.notifier)
        .loginMentee(context, 'shristy', 'shristy1234');

    final authState = container.read(menteeViewModelProvider);

    expect(authState.error, isNull);
  });

  
  test('check for invalid username and password ', () async {
    when(mockLoginUseCase.loginMentee('shristy', 'shristy1234'))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

   await container
        .read(menteeViewModelProvider.notifier)
        .loginMentee(context, 'shristy', 'shristy1234');

    final authState = container.read(menteeViewModelProvider);

    expect(authState.error, 'Invalid');
  });

  tearDownAll(
    () => container.dispose(),
  );
}
