import 'package:app/features/articles/presentation/view/article_list_view.dart';
import 'package:app/features/articles/presentation/view/article_list_view_mentor.dart';
import 'package:app/features/mentor_dashboard/presentation/view/mentor_mysessions.dart';
import 'package:app/features/mentor_dashboard/presentation/view/mentor_profile.dart';
import 'package:flutter/widgets.dart';

class MentorDashboardState {
  final int index;
  final List<Widget> listWidget;

  MentorDashboardState({required this.index, required this.listWidget});
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  MentorDashboardState.initialState()
      : index = 0,
        listWidget = [
          const MentorMySessions(),
          const ArticleListMentor(),
          const MentorProfile(),
        ];

  MentorDashboardState copyWith({
    int? index,
  }) {
    return MentorDashboardState(
        index: index ?? this.index, listWidget: listWidget);
  }
}
