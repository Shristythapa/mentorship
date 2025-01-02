
import 'package:app/features/mentorSearch/domain/entity/mentor_search_entity.dart';

class MentorSearchState {
  final bool isLoading;
  final bool isError;
  final List<MentorSearchEntity> mentors;
  final bool showMessage;
  final String message;

  MentorSearchState(
      {required this.isLoading,
      required this.isError,
      required this.mentors,
      required this.showMessage,
      required this.message});

  factory MentorSearchState.initialState() => MentorSearchState(
      isLoading: false,
      isError: false,
      mentors: [],
      showMessage: false,
      message: "");

  MentorSearchState copyWith(
      {bool? isLoading,
      bool? isError,
      List<MentorSearchEntity>? mentors,
      bool? showMessage,
      String? message}) {
    return MentorSearchState(
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        mentors: mentors ?? this.mentors,
        showMessage: showMessage ?? this.showMessage,
        message: message ?? this.message);
  }
}
