import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/sessions/domain/usecases/get_all_session_usecase.dart';
import 'package:app/features/sessions/domain/usecases/get_session_by_id_usecase.dart';
import 'package:app/features/sessions/domain/usecases/get_session_by_mentor_id_usecase.dart';
import 'package:app/features/sessions/domain/usecases/join_session_usecase.dart';
import 'package:app/features/sessions/presentation/viewmodel/session_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../test_data/session_entity_test.dart';
import 'mentee_session_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetAllSessionsUsecase>(),
  MockSpec<GetSessionByIdUsecase>(),
  MockSpec<GetSessionByMentorIdUsecase>(),
  MockSpec<JoinSessionUsecase>()
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  late GetAllSessionsUsecase mockGetAllSessionUseCase;
  late GetSessionByIdUsecase mockGetSessionByIdUsecase;
  late GetSessionByMentorIdUsecase mockGetSessionByMentorIdUsecase;
  late JoinSessionUsecase mockjoinSessionUseCase;
  late List<SessionEntity> sessionEntity;
  setUpAll(() async {
    mockGetAllSessionUseCase = MockGetAllSessionsUsecase();
    mockGetSessionByIdUsecase = MockGetSessionByIdUsecase();
    mockGetSessionByMentorIdUsecase = MockGetSessionByMentorIdUsecase();
    mockjoinSessionUseCase = MockJoinSessionUsecase();
    sessionEntity = await getSessionListTest();

    when(mockGetAllSessionUseCase.getAllSession())
        .thenAnswer((_) async => const Right([]));
    container = ProviderContainer(overrides: [
      sessionViewModelPrvoider.overrideWith((ref) => SessionViewModel(
          getAllSessionsUsecase: mockGetAllSessionUseCase,
          getSessionByIdUsecase: mockGetSessionByIdUsecase,
          getSessionByMentorIdUsecase: mockGetSessionByMentorIdUsecase,
          joinSessionUsecase: mockjoinSessionUseCase))
    ]);
  });

  test('check session initial state', () async {
    await container.read(sessionViewModelPrvoider.notifier).getAllSessions();

    final sessionState = container.read(sessionViewModelPrvoider);

    expect(sessionState.isLoading, false);
    expect(sessionState.sessions, isEmpty);
  });

  test('check for the list of batches when calling get All sesisons', () async {
    when(mockGetAllSessionUseCase.getAllSession())
        .thenAnswer((_) => Future.value(Right(sessionEntity)));

    await container.read(sessionViewModelPrvoider.notifier).getAllSessions();

    final sessionState = container.read(sessionViewModelPrvoider);

    expect(sessionState.isLoading, false);
    expect(sessionState.sessions.length, 4);
  });

  
}
