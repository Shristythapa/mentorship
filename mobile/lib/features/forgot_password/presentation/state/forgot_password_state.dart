class ForgotPasswordState {
  final bool isLoading;
  final String? message;
  final bool? isError;
  final bool? showMessage;

  ForgotPasswordState(
      {required this.isLoading, this.isError, this.message, this.showMessage});

  factory ForgotPasswordState.initial() {
    return ForgotPasswordState(
        isLoading: false, isError: null, message: null, showMessage: null);
  }

  ForgotPasswordState copyWith(
      {bool? isLoading, String? message, bool? isError, bool? showMessage}) {
    return ForgotPasswordState(
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        message: message ?? this.message,
        showMessage: showMessage ?? this.showMessage);
  }

  @override
  String toString() => '';
}
