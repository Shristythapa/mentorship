
import 'package:app/features/mentee_dashboard/presentation/state/mentee_dashboard_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final menteeDashboardViewModelProvider = StateNotifierProvider.autoDispose<
    MenteeDashboardViewModel,
    MenteeDashboardState>((ref) => MenteeDashboardViewModel());


class MenteeDashboardViewModel extends StateNotifier<MenteeDashboardState> {
  MenteeDashboardViewModel() : super(MenteeDashboardState.initialState());

  void changeIndex(int index) {
    state = state.copyWith(index: index);
  }
}
