import 'package:app/features/mentorSearch/domain/entity/mentor_search_entity.dart';
import 'package:app/features/mentorSearch/domain/usecases/get_all_mentor_use_case.dart';
import 'package:app/features/mentorSearch/domain/usecases/get_mentor_by_id_usecase.dart';
import 'package:app/features/mentorSearch/presentation/viewmodel/mentor_search_view_model.dart';
import 'package:app/features/sessions/presentation/viewmodel/session_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../test_data/mentor_entity_test.dart';
import 'mentor_unit_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<GetMentorByIdUsecase>(), MockSpec<GetAllMentorsUseCase>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  late GetMentorByIdUsecase mockGetMentorByIdUseCase;
  late GetAllMentorsUseCase mockGetAllMentorUseCase;
  late List<MentorSearchEntity> mentorSearchLst;

  setUpAll(() async {
    mockGetMentorByIdUseCase = MockGetMentorByIdUsecase();
    mockGetAllMentorUseCase = MockGetAllMentorsUseCase();
    mentorSearchLst = await getMentorSearchListTest();

    when(mockGetAllMentorUseCase.getAllMentors())
        .thenAnswer((_) async => Right(mentorSearchLst));

    container = ProviderContainer(overrides: [
      mentorSearchViewModelProvider.overrideWith((ref) => MentorSearchViewModel(
          getMentorByIdUsecase: mockGetMentorByIdUseCase,
          getAllMentorsUseCase: mockGetAllMentorUseCase))
    ]);
  });

  test('check mentor search init', () async {
    final mentorSearchState = container.read(sessionViewModelPrvoider);
    expect(mentorSearchState.isError, false);
  });

  test('get all mentors', () async {
    when(mockGetAllMentorUseCase.getAllMentors())
        .thenAnswer((realInvocation) => Future.value(Right(mentorSearchLst)));

    await container.read(mentorSearchViewModelProvider);

    final mentorSearchState = container.read(mentorSearchViewModelProvider);
    expect(mentorSearchState.mentors, isNotEmpty);
  });
}
