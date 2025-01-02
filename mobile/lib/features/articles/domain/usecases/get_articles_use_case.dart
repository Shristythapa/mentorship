import 'package:app/core/error/failure.dart';
import 'package:app/features/articles/domain/entity/article_entity.dart';
import 'package:app/features/articles/domain/repository/article_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAllArticlesUsecaseProvider = Provider((ref) =>
    GetAllArticleUseCase(repository: ref.read(articleRepositoryProvider)));


class GetAllArticleUseCase {
  final IArticleRepository repository;

  GetAllArticleUseCase({required this.repository});

  Future<Either<Failure, List<ArticleEntity>>> getAllArticle(int page, int limit) async {
    
    return await repository.getAllArticle(page, limit);
  }
}
