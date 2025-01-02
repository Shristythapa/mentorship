class MentorMySessionsState {
  final String selectedIndex;

  MentorMySessionsState({
    required this.selectedIndex,
  });

  factory MentorMySessionsState.initialState() {
    return MentorMySessionsState(selectedIndex: "all");
  }

  MentorMySessionsState copyWith({
    String? selectedIndex,
  }) {
    return MentorMySessionsState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
