import 'package:app/core/provider/internet_connectivity.dart';
import 'package:app/features/articles/domain/entity/article_entity.dart';
import 'package:app/features/articles/domain/usecases/add_article_use_case.dart';
import 'package:app/features/articles/domain/usecases/delete_article_use_case.dart';
import 'package:app/features/articles/domain/usecases/get_articles_use_case.dart';
import 'package:app/features/articles/presentation/state/article_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final articleViewModelProvider =
    StateNotifierProvider.autoDispose<ArticleViewModel, ArticleState>((ref) =>
        ArticleViewModel(
            addArticleUsecase: ref.read(addArticleUsecaseProvider),
            getAllArticleUseCase: ref.read(getAllArticlesUsecaseProvider),
            deleteArticleUseCase: ref.read(deleteArticlUseCase),
            connectivityStatus: ref.watch(connectivityStatusProvider)));

class ArticleViewModel extends StateNotifier<ArticleState> {
  final AddArticleUsecase addArticleUsecase;
  final GetAllArticleUseCase getAllArticleUseCase;
  final DeleteArticleUseCase deleteArticleUseCase;
  final ConnectivityStatus connectivityStatus;

  ArticleViewModel(
      {required this.addArticleUsecase,
      required this.getAllArticleUseCase,
      required this.deleteArticleUseCase,
      required this.connectivityStatus})
      : super(ArticleState.initialState()) {
    getAllArticles();
  }

  Future resetState() async {
    state = ArticleState.initialState();
    getAllArticles();
  }

  void addArticle(ArticleEntity article) {
    state = state.copyWith(isLoading: true);
    addArticleUsecase.addArticle(article).then((value) {
      value.fold(
          (failure) => state = state.copyWith(
              isLoading: true,
              message: failure.error,
              isError: true,
              showMessage: true),
          (success) => state = state.copyWith(
              isLoading: false,
              showMessage: true,
              message: "Article Added Sucessfully",
              isError: false));
    });
    // resetState();
  }

  Future<void> getAllArticles() async {
    final internetStatus = connectivityStatus;
    if (internetStatus != ConnectivityStatus.isConnected) {
      final result = await getAllArticleUseCase.getAllArticle(1, 3);
      result.fold(
          (failure) => state = state.copyWith(
              isError: true,
              message: failure.error,
              showMessage: true,
              hasReachedMax: true,
              isLoading: false), (data) {
        state = state.copyWith(article: data, isLoading: false, page: 1);
      });
    } else {
      state = state.copyWith(isLoading: true);
      final currentState = state;
      final page = currentState.page + 1;
      final articles = currentState.article;
      final hasReachedMax = currentState.hasReachedMax;

      if (!hasReachedMax) {
        final result = await getAllArticleUseCase.getAllArticle(page, 3);
        result.fold(
            (failure) => state = state.copyWith(
                isError: true,
                message: failure.error,
                showMessage: true,
                hasReachedMax: true,
                isLoading: false), (data) {
          if (data.isEmpty) {
          
            state = state.copyWith(hasReachedMax: true, isLoading: false);
          } else {
            state = state.copyWith(
                article: [...articles, ...data], isLoading: false, page: page);
          }
        });
      }
    }
  }

  Future<void> deleteArticle(String id) async {
    state = state.copyWith(isLoading: true);
    // deleteSession(id);
    deleteArticleUseCase.deleteArticle(id).then((value) => value.fold(
        (failure) => state = state.copyWith(
            isLoading: true,
            message: failure.error,
            showMessage: true,
            isError: true),
        (success) => state = state.copyWith(
            isLoading: false,
            showMessage: true,
            message: "Deleted Sucessfully")));
    resetState();
  }
}
