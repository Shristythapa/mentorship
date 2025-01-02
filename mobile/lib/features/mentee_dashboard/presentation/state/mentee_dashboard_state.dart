import 'package:app/features/articles/presentation/view/article_list_view.dart';
import 'package:app/features/mentee_dashboard/presentation/view/mentee_my_sessions.dart';
import 'package:app/features/mentee_dashboard/presentation/view/mentee_profile.dart';
import 'package:app/features/mentee_dashboard/presentation/view/mentee_session_list.dart';
import 'package:app/features/mentee_dashboard/presentation/view/mentor_list.dart';
import 'package:flutter/widgets.dart';

class MenteeDashboardState {
  final int index;
  final List<Widget> listWidgets;

  MenteeDashboardState({required this.index, required this.listWidgets});
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  MenteeDashboardState.initialState()
      : index = 0,
        listWidgets = [
          const MenteeMySessions(),
          const MenteeSessionList(),
          const MentorList(),
          const ArticleList(),
          const MenteeProfile(),
        ];

  MenteeDashboardState copyWith({int? index}) {
    {
      return MenteeDashboardState(
          index: index ?? this.index, listWidgets: listWidgets);
    }
  }
}
