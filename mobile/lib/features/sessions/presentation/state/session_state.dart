import 'package:app/features/sessions/domain/entity/session_entity.dart';

class SessionState {
  final bool isLoading;
  final bool isError;
  final List<SessionEntity> sessions;
  final bool showMessage;
  final String message;
  

  SessionState({
    required this.isError,
    required this.isLoading,
    required this.sessions,
    required this.showMessage,
    required this.message,

  });

  factory SessionState.initialState() => SessionState(
    isError: false,
        isLoading: false,
        sessions: [],
        showMessage: false,
        message: "",
       
      );

  SessionState copyWith(
      {bool? isError,
        bool? isLoading,
      List<SessionEntity>? sessions,
      bool? showMessage,
      bool? hasMaxReached,
      int? page,
      String? message}) {
    return SessionState(
      isError: isError?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      sessions: sessions ?? this.sessions,
      showMessage: showMessage ?? this.showMessage,
      message: message ?? this.message,
     
    );
  }
}
