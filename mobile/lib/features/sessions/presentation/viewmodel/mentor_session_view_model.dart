import 'package:app/config/routes/app_routes.dart';
import 'package:app/core/shared_pref/user_shared_prefs.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/sessions/domain/usecases/add_session_usecase.dart';
import 'package:app/features/sessions/domain/usecases/delete_session_usecase.dart';
import 'package:app/features/sessions/domain/usecases/get_session_by_id_usecase.dart';
import 'package:app/features/sessions/domain/usecases/get_session_by_mentor_id_usecase.dart';
import 'package:app/features/sessions/presentation/state/mentor_session_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mentorSessionViewModelPrvoider = StateNotifierProvider.autoDispose<
        MentorSessionViewModel, MentorSessionState>(
    (ref) => MentorSessionViewModel(
        addSessionUsecase: ref.read(addSessionUsecaseProvider),
        deleteSessionUsecase: ref.read(deleteSessionUseCaseProvider),
        getSessionByIdUsecase: ref.read(getSessionByIdUsecaseProvider),
        getSessionByMentorIdUsecase:
            ref.read(getSessionByMentorIdUsecaseProvider),
        userSharedPrefs: ref.read(userSharedPrefsProvider)));

class MentorSessionViewModel extends StateNotifier<MentorSessionState> {
  final AddSessionUsecase addSessionUsecase;
  final DeleteSessionUsecase deleteSessionUsecase;
  final GetSessionByIdUsecase getSessionByIdUsecase;
  final GetSessionByMentorIdUsecase getSessionByMentorIdUsecase;
  final UserSharedPrefs userSharedPrefs;

  MentorSessionViewModel({
    required this.addSessionUsecase,
    required this.deleteSessionUsecase,
    required this.getSessionByIdUsecase,
    required this.getSessionByMentorIdUsecase,
    required this.userSharedPrefs,
  }) : super(MentorSessionState.initialState()) {
    getSessionByMentorId();
  }

  Future resetState() async {
    state = MentorSessionState.initialState();
    getSessionByMentorId();
  }

  Future<void> addSession(SessionEntity session, BuildContext context) async {
    print('view model');
    state = state.copyWith(isLoading: true);
    addSessionUsecase.addSession(session).then((value) {
      value.fold(
          (failure) => state = state.copyWith(
              isLoading: true,
              message: failure.error,
              isError: true,
              showMessage: true), (success) {
        state = state.copyWith(
            isLoading: false,
            showMessage: true,
            message: "Session Added Sucessfully",
            isError: false);

        // Navigator.popAndPushNamed(context, AppRoutes.mentorDashboard);
      });
    });
    // resetState();
  }

  Future<void> getSessionByMentorId() async {
    state = state.copyWith(isLoading: true);

    final result = await userSharedPrefs.getUserDetails();
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          isError: true,
          message: "Failed to get user details: ${failure.error}",
        );
      },
      (userData) async {
        final mentorId = userData['_id'] as String?;
        if (mentorId != null) {
          final sessionResult =
              await getSessionByMentorIdUsecase.getSessionByMentorId(mentorId);
          sessionResult.fold(
            (failure) => state = state.copyWith(isLoading: false),
            (data) => state = state.copyWith(sessions: data, isLoading: false),
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            isError: true,
            message: "Mentor ID not found in user details.",
          );
        }
      },
    );
  }

  // Future<void> getSessionByMentorId() async {
  //   state = state.copyWith(isLoading: true);

  //   userSharedPrefs.getUserDetails().then((result) {
  //     result.fold(
  //       (failure) => {
  //         state.copyWith(isError: true, message: "User id not fount"),
  //         print("Failed to get user details: ${failure.error}")
  //       },
  //       (userData) async {
  //         final mentorId = userData['_id'];

  //         // get data from data source
  //         final result =
  //             await getSessionByMentorIdUsecase.getSessionByMentorId(mentorId);
  //         result.fold((failure) => state = state.copyWith(isLoading: false),
  //             (data) {
  //           state = state.copyWith(
  //             sessions: data,
  //             isLoading: false,
  //           );
  //         });
  //       },
  //     );
  //   });
  // }

  Future<void> deleteSession(String id) async {
    state = state.copyWith(isLoading: true);
    deleteSessionUsecase.deleteSession(id).then((value) => value.fold(
        (failure) => state = state.copyWith(
            isLoading: true,
            message: failure.error,
            showMessage: true,
            isError: true),
        (success) => state = state.copyWith(
            isLoading: false,
            showMessage: true,
            message: "Deleted Sucessfully")));
    // resetState();
  }
}
