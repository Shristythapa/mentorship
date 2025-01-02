import 'package:app/core/error/failure.dart';
import 'package:app/core/network/hive_service.dart';
import 'package:app/features/articles/data/model/article_hive_model.dart';
import 'package:app/features/articles/domain/entity/article_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final articleLocalDataSourceProvider = Provider((ref) =>
    ArticleLocalDataSource(hiveService: ref.read(hiveServiceProvider)));

class ArticleLocalDataSource {
  final HiveService hiveService;

  ArticleLocalDataSource({required this.hiveService});

  Future<Either<Failure, bool>> addArticle(ArticleEntity article) async {
    try {
      ArticleHiveModel articleHiveModel = ArticleHiveModel.toHiveModel(article);
      hiveService.addArticle(articleHiveModel);
      print('local data source add session');
      print(article);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<ArticleEntity>>> getAllArticle() async {
    try {
      List<ArticleHiveModel> articles = await hiveService.getAllArticle();
      List<ArticleEntity> articleEntity =
          articles.map((e) => ArticleHiveModel.toEntity(e)).toList();
      print("sesssssssi0on $articleEntity");
      return Right(articleEntity);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
    Future<Either<Failure, bool>> deleteArticle(String id) async {
    try {
  
      hiveService.deleteArticle(id);
      print('local data source deleted article');
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
  
}
