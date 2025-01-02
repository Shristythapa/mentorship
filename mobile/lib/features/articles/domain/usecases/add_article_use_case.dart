import 'package:app/core/error/failure.dart';
import 'package:app/features/articles/domain/entity/article_entity.dart';
import 'package:app/features/articles/domain/repository/article_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addArticleUsecaseProvider = Provider((ref) =>
    AddArticleUsecase(articleRepository: ref.read(articleRepositoryProvider)));

class AddArticleUsecase {
  final IArticleRepository articleRepository;

  AddArticleUsecase({required this.articleRepository});

  Future<Either<Failure, bool>> addArticle(ArticleEntity articleEntity) async {
    print("add reticle use case");
    return await articleRepository.addArticle(articleEntity);
  }
}
