// final forgotPasswor

import 'package:app/config/routes/app_routes.dart';
import 'package:app/features/forgot_password/domain/usecases/mentee_forgot_password_use_case.dart';
import 'package:app/features/forgot_password/domain/usecases/mentor_forgot_password_use_case.dart';
import 'package:app/features/forgot_password/presentation/state/forgot_password_state.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final forgotPasswordViewModelProvider = StateNotifierProvider.autoDispose<
        ForgotPasswordViewModel, ForgotPasswordState>(
    (ref) => ForgotPasswordViewModel(
        menteeForgotPasswordUseCase: ref.read(menteeForgotPasswordUseCase), mentorForgotPasswordUseCase: ref.read(mentorForgotPasswordUseCase)));

class ForgotPasswordViewModel extends StateNotifier<ForgotPasswordState> {
  final MenteeForgotPasswordUseCase menteeForgotPasswordUseCase;
  final MentorForogotPasswordUseCase mentorForgotPasswordUseCase;
  var SessionState;

  ForgotPasswordViewModel({required this.menteeForgotPasswordUseCase, required this.mentorForgotPasswordUseCase})
      : super(ForgotPasswordState.initial());

  Future<void> menteeForgotPassword(String email, BuildContext context) async {
    state = state.copyWith(isLoading: true);

    final result =
        await menteeForgotPasswordUseCase.menteeForgotPassword(email);

    result.fold(
        (failure) => state = state.copyWith(
            isLoading: false,
            message: failure.error,
            showMessage: true,
            isError: true), (done) {
      state.copyWith(
          isLoading: false,
          message: "Mail Send",
          isError: false,
          showMessage: true);
      Navigator.pushNamed(context, AppRoutes.menteeLoginPage);
    });
    resetState();
  }

  Future<void> mentorForgotPassword(String email, BuildContext context) async {
    state = state.copyWith(isLoading: true);

    final result =
        await menteeForgotPasswordUseCase.menteeForgotPassword(email);

    result.fold(
        (failure) => state = state.copyWith(
            isLoading: false,
            message: failure.error,
            showMessage: true,
            isError: true), (done) {
      state.copyWith(
          isLoading: false,
          message: "Mail Send",
          isError: false,
          showMessage: true);
      Navigator.pushNamed(context, AppRoutes.mentorLoginPage);
    });
    resetState();
  }

  Future resetState() async {
    state = SessionState.initialState();
  }
}
