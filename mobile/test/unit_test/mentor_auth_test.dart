

import 'package:app/core/error/failure.dart';
import 'package:app/features/mentor/domain/usecases/mentor_login_use_case.dart';
import 'package:app/features/mentor/domain/usecases/mentor_registeration_use_case.dart';
import 'package:app/features/mentor/presentation/viewmodel/mentor_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mentor_auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<MentorLoginUseCase>(),
  MockSpec<MentorRegisterUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late MentorLoginUseCase mockLoginUseCase;
  late ProviderContainer container;
  late BuildContext context;
  late MentorRegisterUseCase mockRegisterUseCase;

  setUpAll(() {
    mockLoginUseCase = MockMentorLoginUseCase();
    context = MockBuildContext();
    mockRegisterUseCase = MockMentorRegisterUseCase();
    container = ProviderContainer(overrides: [
      mentorViewModelProvider.overrideWith((ref) => MentorViewModel(
          registerUseCase: mockRegisterUseCase, loginUseCase: mockLoginUseCase))
    ]);
  });

  test('login test with valid username and', () async {
    when(mockLoginUseCase.loginMentee('shristy', 'shristy123'))
        .thenAnswer((_) => Future.value(const Right(true)));


    container
        .read(mentorViewModelProvider.notifier)
        .login(context, 'shristy', 'shristy123');

    final authState = container.read(mentorViewModelProvider);

    expect(authState.error, isNull);
  });

  test('check for invalid username and password ', () async {
    when(mockLoginUseCase.loginMentee('shristy', 'shristy1234'))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container
        .read(mentorViewModelProvider.notifier)
        .login(context, 'shristy', 'shristy1234');

    final authState = container.read(mentorViewModelProvider);

    expect(authState.error, 'Invalid');
  });

  tearDownAll(
    () => container.dispose(),
  );
}
