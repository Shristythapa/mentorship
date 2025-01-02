import 'package:app/core/error/failure.dart';
import 'package:app/features/articles/data/data_source/remote/article_remote_datasource.dart';
import 'package:app/features/articles/domain/entity/article_entity.dart';
import 'package:app/features/articles/domain/repository/article_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final articleRemoteRepositoryProvider = Provider((ref) => ArticleRemoteRepo(
    articleRemoteDataSource: ref.read(articleRemoteDataSourceProvider)));

class ArticleRemoteRepo implements IArticleRepository {
  final ArticleRemoteDataSource articleRemoteDataSource;
  const ArticleRemoteRepo({required this.articleRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addArticle(ArticleEntity articleEntity) {
    return articleRemoteDataSource.addArticle(articleEntity);
  }

  @override
  Future<Either<Failure, bool>> deleteArticle(String id) {
    return articleRemoteDataSource.deleteArticle(id);
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getAllArticle(
      int page, int limit) {
    return articleRemoteDataSource.getAllArticle(page, limit);
  }
}
