import 'package:app/features/articles/domain/entity/article_entity.dart';

class ArticleState {
  final bool isLoading;
  final bool isError;
  final List<ArticleEntity> article;
  final bool showMessage;
  final String message;
  final bool hasReachedMax;
  final int page;

  ArticleState({
    required this.isError,
    required this.isLoading,
    required this.article,
    required this.hasReachedMax,
    required this.page,
    required this.showMessage,
    required this.message,
  });

  factory ArticleState.initialState() => ArticleState(
        isError: false,
        isLoading: false,
        article: [],
        showMessage: false,
        message: "",
        hasReachedMax: false,
        page: 0,
      );

  ArticleState copyWith(
      {bool? isError,
      bool? isLoading,
      List<ArticleEntity>? article,
      bool? showMessage,
      bool? hasReachedMax,
      int? page,
      String? message}) {
    return ArticleState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      article: article ?? this.article,
      showMessage: showMessage ?? this.showMessage,
      message: message ?? this.message,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }
}
