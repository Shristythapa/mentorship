import 'dart:io';

import 'package:app/config/routes/app_routes.dart';
import 'package:app/features/mentee/domain/entity/mentee_entity.dart';
import 'package:app/features/mentee/domain/usecases/login_use_case.dart';
import 'package:app/features/mentee/domain/usecases/register_use_case.dart';
import 'package:app/features/mentee/presentation/viewmodel/mentee_viewmodel.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test/unit_test/mentee_auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<RegisterUseCase>(),
])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late LoginUseCase mockLoginUsecase;

  late RegisterUseCase registerUseCase;
  setUpAll(() async {
    mockLoginUsecase = MockLoginUseCase();
    registerUseCase = MockRegisterUseCase();
  });
  testWidgets('register mentee test', (WidgetTester tester) async {
    when(registerUseCase.registerMentee(
            File('path/to/image.jpg'),
            MenteeEntity(
                userName: "testuser",
                email: "testuser@gmail.com",
                password: "testpassword")))
        .thenAnswer((_) async => const Right(true));

    await tester.pumpWidget(ProviderScope(
      overrides: [
        menteeViewModelProvider.overrideWith((ref) => MenteeViewModel(
            registerUseCase: registerUseCase, loginUseCase: mockLoginUsecase))
      ],
      child: MaterialApp(
        initialRoute: AppRoutes.menteeSignup,
        routes: AppRoutes.getApplicationRoute(),
      ),
    ));

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'testuser');

    await tester.enterText(
        find.byType(TextFormField).at(1), 'testuser@gmail.com');

    await tester.enterText(find.byType(TextFormField).at(2), 'testpassword');
    await tester.pumpAndSettle();

    
    await tester.tap(
      find.widgetWithText(ElevatedButton, 'Sign up'),
    );

    await tester.pumpAndSettle();

    expect(find.text('Sign up as mentee'), findsOneWidget);
  });
}
