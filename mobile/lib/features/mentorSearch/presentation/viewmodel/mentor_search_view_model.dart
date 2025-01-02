
import 'package:app/features/mentorSearch/domain/usecases/get_all_mentor_use_case.dart';
import 'package:app/features/mentorSearch/domain/usecases/get_mentor_by_id_usecase.dart';
import 'package:app/features/mentorSearch/presentation/state/mentor_search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mentorSearchViewModelProvider = StateNotifierProvider.autoDispose<MentorSearchViewModel, MentorSearchState>((ref) => MentorSearchViewModel(
    getMentorByIdUsecase: ref.read(getMentorByIdUseCaseProvider),
    getAllMentorsUseCase: ref.read(getAllMentorUseCaseProvider)));

class MentorSearchViewModel extends StateNotifier<MentorSearchState> {
  final GetMentorByIdUsecase getMentorByIdUsecase;
  final GetAllMentorsUseCase getAllMentorsUseCase;

  MentorSearchViewModel(
      {required this.getMentorByIdUsecase, required this.getAllMentorsUseCase})
      : super(MentorSearchState.initialState()) {
    getAllMentors();
  }
  Future resetState() async {
    state = MentorSearchState.initialState();
    getAllMentors();
  }

  Future<void> getAllMentors() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final mentors = currentState.mentors;
    final result = await getAllMentorsUseCase.getAllMentors();

    result.fold(
        (failure) => state = state.copyWith(
            isLoading: false,
            isError: true,
            message: failure.error,
            showMessage: true), (data) {
      state = state.copyWith(isLoading: false, mentors: [...mentors, ...data]);
    });
  }
}
