import 'package:app/config/constants/api_endpoints.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/network/http_service.dart';
import 'package:app/core/shared_pref/user_shared_prefs.dart';
import 'package:app/features/articles/data/dto/get_all_article_dto.dart';
import 'package:app/features/articles/data/model/article_api_model.dart';
import 'package:app/features/articles/domain/entity/article_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final articleRemoteDataSourceProvider =
    Provider((ref) => ArticleRemoteDataSource(
          dio: ref.read(httpServiceProvider),
          userSharedPrefs: ref.read(userSharedPrefsProvider),
        ));

class ArticleRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  ArticleRemoteDataSource({required this.dio, required this.userSharedPrefs});

  Future<Either<Failure, bool>> addArticle(ArticleEntity articleEntity) async {
    try {
      ArticleApiModel apiModel = ArticleApiModel.fromEntity(articleEntity);
      print(apiModel.toJson());
      var response =
          await dio.post(ApiEndpoints.addArticle, data: apiModel.toJson());
      print(response);
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(Failure(
          error: e.response!.data['message'],
          statusCode: "404",
        ));
      }
      print(e);
      return Left(Failure(
          error: "Add Article: Api connection error", statusCode: "400"));
    }
  }

  Future<Either<Failure, List<ArticleEntity>>> getAllArticle(
      int page, int limit) async {
    try {
      print(ApiEndpoints.getArticle);
      Response response = await dio.get(ApiEndpoints.getArticle,
          queryParameters: {"page": page, "limit": limit});

      print(response);
      if (response.statusCode == 200) {
        GetAllArticleDTO getAllArticleDTO =
            GetAllArticleDTO.fromJson(response.data);

        // List<ArticleEntity> sessionList = response.data['session']

        List<ArticleEntity> articleList = getAllArticleDTO.articles
            .map((session) => ArticleApiModel.toEntity(session))
            .toList();

        return Right(articleList);
      } else {
        return Left(Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {

      print((e));
      return Left(Failure(error: "Get All Article: Api connection error"));
    }
  }

  Future<Either<Failure, bool>> deleteArticle(String id) async {
    try {
      print(ApiEndpoints.deleteArticle + id);
      var response = await dio.delete(ApiEndpoints.deleteArticle + id);

      print(response);
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(Failure(
          error: e.response!.data['message'],
          statusCode: "404",
        ));
      }
      print(e);
      return Left(Failure(error: "Delete Article : Api connection Error"));
    }
  }
}
