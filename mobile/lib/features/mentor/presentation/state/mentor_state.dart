class MentorState {
  final bool isLoading;
  final String? error;
  final bool? showMessage;
  final Map<String, dynamic>? user;

  MentorState(
      {required this.isLoading, this.error, this.showMessage, this.user});

  factory MentorState.initial() {
    return MentorState(isLoading: false, error: null, showMessage: false);
  }

  MentorState copyWith(
      {bool? isLoading,
      String? error,
      bool? showMessage,
      Map<String, dynamic>? user}) {
    return MentorState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage,
        user: user ?? user);
  }

  @override
  String toString() => 'MentorState(isLoading: $isLoading, error: $error)';
}
