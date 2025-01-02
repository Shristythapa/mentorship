import 'package:app/core/error/failure.dart';
import 'package:app/features/articles/data/data_source/local/article_local_database.dart';
import 'package:app/features/articles/data/data_source/remote/article_remote_datasource.dart';
import 'package:app/features/articles/domain/entity/article_entity.dart';
import 'package:app/features/articles/domain/repository/article_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final articleLocalRepositoryProvider = Provider((ref) => ArticleLocalRepository(
    articleLocalDataSource: ref.read(articleLocalDataSourceProvider)));

class ArticleLocalRepository implements IArticleRepository {
  final ArticleLocalDataSource articleLocalDataSource;

  ArticleLocalRepository({required this.articleLocalDataSource});
  @override
  Future<Either<Failure, bool>> addArticle(ArticleEntity article) {
    return articleLocalDataSource.addArticle(article);
  }

  @override
  Future<Either<Failure, bool>> deleteArticle(String id) {
    return articleLocalDataSource.deleteArticle(id);
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getAllArticle(
      int page, int limit) {
    return articleLocalDataSource.getAllArticle();
  }
}
