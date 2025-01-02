import 'package:app/features/mentor_dashboard/presentation/state/session_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mentorMySessionsControllerProvider =
    StateNotifierProvider<MentorMySessionsController, MentorMySessionsState>(
  (ref) => MentorMySessionsController(),
);

class MentorMySessionsController extends StateNotifier<MentorMySessionsState> {
  MentorMySessionsController() : super(MentorMySessionsState.initialState());

  void setSelectedIndex(String index) {
    state = state.copyWith(selectedIndex: index);
  }
}
