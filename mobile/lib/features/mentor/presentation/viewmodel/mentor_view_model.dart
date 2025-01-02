import 'dart:io';

import 'package:app/config/routes/app_routes.dart';
import 'package:app/features/Mentor/presentation/state/Mentor_state.dart';
import 'package:app/features/mentor/domain/usecases/mentor_login_use_case.dart';
import 'package:app/features/mentor/domain/usecases/mentor_registeration_use_case.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/mentor_entity.dart';

final mentorViewModelProvider =
    StateNotifierProvider<MentorViewModel, MentorState>(
  (ref) => MentorViewModel(
      registerUseCase: ref.read(mentorRegistrationUseCase),
      loginUseCase: ref.read(mentorLoginUseCase)),
);

class MentorViewModel extends StateNotifier<MentorState> {
  final MentorRegisterUseCase registerUseCase;
  final MentorLoginUseCase loginUseCase;

  MentorViewModel({required this.registerUseCase, required this.loginUseCase})
      : super(MentorState.initial());

  void registerMentor(
      BuildContext context, File file, MentorEntity mentorEntity) {
    state = state.copyWith(isLoading: true);
    registerUseCase.registerMentor(file, mentorEntity).then((value) {
      value.fold(
        (failure) => state = state.copyWith(
            error: failure.error, isLoading: false, showMessage: true),
        (success) {
          state = state.copyWith(
            isLoading: false,
            showMessage: false,
          );
          Navigator.pushNamed(context, AppRoutes.mentorLoginPage);
        },
      );
    });
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    state = state.copyWith(isLoading: true);
    loginUseCase.loginMentee(email, password).then((value) {
      value.fold(
        (failure) => state = state.copyWith(
            isLoading: false, error: failure.error, showMessage: true),
        (success) {
          state =
              state.copyWith(isLoading: false, showMessage: false, error: null);
          Navigator.pushNamed(context, AppRoutes.mentorDashboard);
        },
      );
    });
  }

  void setUser(Map<String, dynamic> user) {
    state = state.copyWith(user: user);
  }

  void reset() {
    state = state.copyWith(
      isLoading: false,
      error: null,
      showMessage: false,
    );
  }
}
