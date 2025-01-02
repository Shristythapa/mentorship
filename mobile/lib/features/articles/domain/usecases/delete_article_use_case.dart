import 'package:app/core/error/failure.dart';
import 'package:app/features/articles/domain/repository/article_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deleteArticlUseCase = Provider((ref) => DeleteArticleUseCase(
    articleRepository: ref.read(articleRepositoryProvider)));

class DeleteArticleUseCase {
  final IArticleRepository articleRepository;

  DeleteArticleUseCase({required this.articleRepository});

  Future<Either<Failure, bool>> deleteArticle(String id) async {
    print("Article use case");
    return await articleRepository.deleteArticle(id);
  }
}
