class MenteeState {
  final bool isLoading;
  final String? error;
  final bool? showMessage;

  MenteeState({
    required this.isLoading,
    this.error,
    this.showMessage,
  });

  factory MenteeState.initial() {
    return MenteeState(
      isLoading: false,
      error: null,
 
      showMessage: false,
    );
  }

  MenteeState copyWith({
    bool? isLoading,
    String? error,
 
    bool? showMessage,
  }) {
    return MenteeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showMessage: showMessage ?? this.showMessage,
    );
  }

  @override
  String toString() => 'MenteeState(isLoading: $isLoading, error: $error)';
}
