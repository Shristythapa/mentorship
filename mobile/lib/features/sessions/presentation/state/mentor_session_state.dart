import 'package:app/features/sessions/domain/entity/session_entity.dart';

class MentorSessionState {
  final bool isLoading;
  final bool isError;
  final List<SessionEntity> sessions;
  final bool showMessage;
  final String? message;

  MentorSessionState({
    required this.isError,
    required this.isLoading,
    required this.sessions,
    required this.showMessage,
    this.message,
  });

  factory MentorSessionState.initialState() => MentorSessionState(
        isError: false,
        isLoading: false,
        sessions: [],
        showMessage: false,
        message: "",
      );

  MentorSessionState copyWith(
      {bool? isError,
      bool? isLoading,
      List<SessionEntity>? sessions,
      String? message,
      bool? showMessage}) {
    return MentorSessionState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      sessions: sessions ?? this.sessions,
      showMessage: showMessage ?? this.showMessage,
      message: message ?? this.message,
    );
  }
}
