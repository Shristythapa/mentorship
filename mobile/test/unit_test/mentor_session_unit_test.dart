
import 'package:app/core/shared_pref/user_shared_prefs.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/sessions/domain/usecases/add_session_usecase.dart';
import 'package:app/features/sessions/domain/usecases/delete_session_usecase.dart';
import 'package:app/features/sessions/domain/usecases/get_session_by_id_usecase.dart';
import 'package:app/features/sessions/domain/usecases/get_session_by_mentor_id_usecase.dart';
import 'package:app/features/sessions/presentation/viewmodel/mentor_session_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../test_data/session_entity_test.dart';
import 'mentor_session_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AddSessionUsecase>(),
  MockSpec<DeleteSessionUsecase>(),
  MockSpec<GetSessionByIdUsecase>(),
  MockSpec<GetSessionByMentorIdUsecase>(),
  MockSpec<UserSharedPrefs>(),
  MockSpec<BuildContext>()
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  late AddSessionUsecase mockAddSessionUseCase;
  late DeleteSessionUsecase mockDeleteSessionUseCase;
  late GetSessionByIdUsecase mockGetSessionByIdUsecase;
  late GetSessionByMentorIdUsecase mockGetSessionByMentorIdUsecase;
  late List<SessionEntity> sessionEntity;
  late UserSharedPrefs mockUserSharedPrefs;
  late BuildContext context;

  setUpAll(() async {
    final Map<String, dynamic> defaultUserDetails = {
      // Initialize with default values
      "userId": 'defaultUserId',
      "userName": 'Default User',
      // Add more fields as necessary
    };

    mockAddSessionUseCase = MockAddSessionUsecase();
    mockDeleteSessionUseCase = MockDeleteSessionUsecase();
    mockGetSessionByIdUsecase = MockGetSessionByIdUsecase();
    mockGetSessionByMentorIdUsecase = MockGetSessionByMentorIdUsecase();
    mockUserSharedPrefs = MockUserSharedPrefs();
    sessionEntity = await getSessionListTest();
    when(mockGetSessionByMentorIdUsecase.getSessionByMentorId("id"))
        .thenAnswer((_) async => Right(sessionEntity));
    when(mockUserSharedPrefs.getUserDetails())
        .thenAnswer((_) async => Right(defaultUserDetails));
    context = MockBuildContext();
    container = ProviderContainer(overrides: [
      mentorSessionViewModelPrvoider.overrideWith((ref) =>
          MentorSessionViewModel(
              addSessionUsecase: mockAddSessionUseCase,
              deleteSessionUsecase: mockDeleteSessionUseCase,
              getSessionByIdUsecase: mockGetSessionByIdUsecase,
              getSessionByMentorIdUsecase: mockGetSessionByMentorIdUsecase,
              userSharedPrefs: mockUserSharedPrefs))
    ]);
  });

  test('add session test', () async {
    when(mockAddSessionUseCase.addSession(sessionEntity[0]))
        .thenAnswer((_) => Future.value(const Right(true)));
    await container
        .read(mentorSessionViewModelPrvoider.notifier)
        .addSession(sessionEntity[0], context);

    final sessionState = container.read(mentorSessionViewModelPrvoider);
    expect(sessionState.isError, false);
  });

}
