import 'package:app/config/routes/app_routes.dart';
import 'package:app/core/provider/internet_connectivity.dart';
import 'package:app/features/mentee/domain/usecases/login_use_case.dart';
import 'package:app/features/mentee/domain/usecases/register_use_case.dart';
import 'package:app/features/mentee/presentation/viewmodel/mentee_viewmodel.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/sessions/domain/usecases/get_all_session_usecase.dart';
import 'package:app/features/sessions/domain/usecases/get_session_by_id_usecase.dart';
import 'package:app/features/sessions/domain/usecases/get_session_by_mentor_id_usecase.dart';
import 'package:app/features/sessions/domain/usecases/join_session_usecase.dart';
import 'package:app/features/sessions/presentation/viewmodel/session_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test/unit_test/article_unit_test.mocks.dart';
import '../test/unit_test/mentee_auth_test.mocks.dart';
import '../test/unit_test/mentee_session_unit_test.mocks.dart';

import '../test_data/session_entity_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();

  late LoginUseCase mockLoginUsecase;
  late GetAllSessionsUsecase mockGetAllSessionUseCase;
  late GetSessionByIdUsecase mockGetSessionByIdUsecase;
  late GetSessionByMentorIdUsecase mockGetSessionByMentorIdUsecase;
  late JoinSessionUsecase mockjoinSessionUseCase;
  late List<SessionEntity> sessionEntity;
  late RegisterUseCase mockRegisterUseCase;

  late bool isLogin;

  setUpAll(() async {
    mockLoginUsecase = MockLoginUseCase();
    mockGetAllSessionUseCase = MockGetAllSessionsUsecase();
    mockGetSessionByIdUsecase = MockGetSessionByIdUsecase();
    mockGetSessionByMentorIdUsecase = MockGetSessionByMentorIdUsecase();
    mockjoinSessionUseCase = MockJoinSessionUsecase();

    sessionEntity = await getSessionListTest();

    mockRegisterUseCase = MockRegisterUseCase();
    isLogin = true;
  });

  testWidgets('login test with username and password and open dashboard',
      (WidgetTester tester) async {
    when(mockLoginUsecase.loginMentee('shristy@gmail.com', 'shristy123'))
        .thenAnswer((_) async => Right(isLogin));

    when(mockGetAllSessionUseCase.getAllSession())
        .thenAnswer((_) async => Right(sessionEntity));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          menteeViewModelProvider.overrideWith((ref) => MenteeViewModel(
              registerUseCase: mockRegisterUseCase,
              loginUseCase: mockLoginUsecase)),
          sessionViewModelPrvoider.overrideWith((ref) => SessionViewModel(
              getAllSessionsUsecase: mockGetAllSessionUseCase,
              getSessionByIdUsecase: mockGetSessionByIdUsecase,
              getSessionByMentorIdUsecase: mockGetSessionByMentorIdUsecase,
              joinSessionUsecase: mockjoinSessionUseCase))
        ],
        child: MaterialApp(
          initialRoute: AppRoutes.menteeLoginPage,
          routes: AppRoutes.getApplicationRoute(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Type in first textformfield/TextField
    await tester.enterText(find.byType(TextField).at(0), 'shristy@gmail.com');
    // Type in second textformfield
    await tester.enterText(find.byType(TextField).at(1), 'shristy123');

    await tester.tap(
      find.widgetWithText(ElevatedButton, 'Login'),
    );

    await tester.pumpAndSettle();

    expect(find.text('Explore Sessions'), findsOneWidget);
  });
}
