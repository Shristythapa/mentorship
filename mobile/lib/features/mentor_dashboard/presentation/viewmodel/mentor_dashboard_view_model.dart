import 'package:app/features/mentor_dashboard/presentation/state/mentor_dashboard_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mentorDashboardViewModelProvider = StateNotifierProvider.autoDispose<
    MentorDashboardViewModel,
    MentorDashboardState>((ref) => MentorDashboardViewModel());

class MentorDashboardViewModel extends StateNotifier<MentorDashboardState> {
  MentorDashboardViewModel() : super(MentorDashboardState.initialState());

  void changeIndex(int index) {
    state = state.copyWith(index: index);
  }
}
