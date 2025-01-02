import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/sessions/domain/usecases/get_all_session_usecase.dart';
import 'package:app/features/sessions/domain/usecases/get_session_by_id_usecase.dart';
import 'package:app/features/sessions/domain/usecases/get_session_by_mentor_id_usecase.dart';
import 'package:app/features/sessions/domain/usecases/join_session_usecase.dart';
import 'package:app/features/sessions/presentation/state/session_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sessionViewModelPrvoider =
    StateNotifierProvider.autoDispose<SessionViewModel, SessionState>((ref) =>
        SessionViewModel(
            getAllSessionsUsecase: ref.read(getAllSessionUsecaseProvider),
            getSessionByIdUsecase: ref.read(getSessionByIdUsecaseProvider),
            getSessionByMentorIdUsecase:
                ref.read(getSessionByMentorIdUsecaseProvider),
            joinSessionUsecase: ref.read(joinSessionUsecaseProvider)));

class SessionViewModel extends StateNotifier<SessionState> {

  final GetAllSessionsUsecase getAllSessionsUsecase;

  final GetSessionByIdUsecase getSessionByIdUsecase;
  final GetSessionByMentorIdUsecase getSessionByMentorIdUsecase;
  final JoinSessionUsecase joinSessionUsecase;

  SessionViewModel(
      {
      required this.getAllSessionsUsecase,
  
      required this.getSessionByIdUsecase,
      required this.getSessionByMentorIdUsecase,
      required this.joinSessionUsecase})
      : super(SessionState.initialState()) {
    getAllSessions();
  }

  Future resetState() async {
    state = SessionState.initialState();
    getAllSessions();
  }


  Future<void> getAllSessions() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
  
    final sessions = currentState.sessions;

      // get data from data source
      final result = await getAllSessionsUsecase.getAllSession();
      result.fold(
        (failure) =>
            state = state.copyWith(hasMaxReached: true, isLoading: false),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasMaxReached: true, isLoading: false);
          } else {
            state = state.copyWith(
              sessions: [...sessions, ...data],
         
              isLoading: false,
            );
          }
        },
      );
    
  }

  void joinSession(SessionEntity sessionEntity) {
    state = state.copyWith(isLoading: true);
    joinSessionUsecase.joinSession(sessionEntity).then((value) => value.fold(
        (failure) => state = state.copyWith(
            isLoading: true,
            message: failure.error,
            showMessage: true,
            isError: true),
        (success) => state = state.copyWith(
            isLoading: false,
            showMessage: true,
            message: "Session Joined Sucessfully")));
    resetState();
  }

  Future<void> getSessionByMentorId(String id) async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
 
    final sessions = currentState.sessions;

      // get data from data source
      final result =
          await getSessionByMentorIdUsecase.getSessionByMentorId(id);
      result.fold(
        (failure) =>
            state = state.copyWith(hasMaxReached: true, isLoading: false),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasMaxReached: true, isLoading: false);
          } else {
            state = state.copyWith(
              sessions: [...sessions, ...data],
            
              isLoading: false,
            );
          }
        },
      );
    
  }

}
