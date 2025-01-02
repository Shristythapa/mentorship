// import 'dart:html';
import 'dart:io';
import 'package:app/config/routes/app_routes.dart';
import 'package:app/features/mentee/domain/usecases/login_use_case.dart';
import 'package:app/features/mentee/domain/usecases/register_use_case.dart';
import 'package:app/features/mentee/presentation/state/mentee_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/mentee/domain/entity/mentee_entity.dart';

final menteeViewModelProvider =
    StateNotifierProvider.autoDispose<MenteeViewModel, MenteeState>(
  (ref) => MenteeViewModel(
      registerUseCase: ref.read(menteeRegisterUseCase),
      loginUseCase: ref.read(menteeLoginUseCase)),
);

class MenteeViewModel extends StateNotifier<MenteeState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;

  MenteeViewModel({required this.registerUseCase, required this.loginUseCase})
      : super(MenteeState.initial());

  void registerMentee(BuildContext context, File file, MenteeEntity mentee) {
    state = state.copyWith(isLoading: true);
    registerUseCase.registerMentee(file, mentee).then((value) {
      value.fold(
        (failure) =>
            state = state.copyWith(error: failure.error, showMessage: true),
        (success) {
          state = state.copyWith(
            isLoading: false,
            showMessage: false,
            error: null,
          );
          Navigator.pushNamed(context, AppRoutes.menteeLoginPage);
        },
      );
    });
    resetMessage();
  }

  Future<void> loginMentee(
      BuildContext context, String email, String password) async {
    state = state.copyWith(isLoading: true);
    loginUseCase.loginMentee(email, password).then((value) {
      state = state.copyWith(isLoading: false);
      value.fold(
        (failure) =>
            state = state.copyWith(error: failure.error, showMessage: true),
        (success) {
          state = state.copyWith(
            isLoading: false,
            showMessage: true,
            error: null,
          );
          Navigator.pushNamed(context, AppRoutes.menteeDashboard);
        },
      );
    });
    resetMessage();
  }

  void resetMessage() {
    state = state.copyWith(error: null, isLoading: false, showMessage: false);
  }
}
