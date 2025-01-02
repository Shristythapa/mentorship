import 'package:app/core/error/failure.dart';
import 'package:app/core/provider/internet_connectivity.dart';
import 'package:app/features/articles/data/repository/article_local_repository.dart';
import 'package:app/features/articles/data/repository/article_remote_repository.dart';
import 'package:app/features/articles/domain/entity/article_entity.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final articleRepositoryProvider = Provider<IArticleRepository>(
  (ref) {
    final internetStatus = ref.watch(connectivityStatusProvider);

    if (ConnectivityStatus.isConnected != internetStatus) {
      return ref.watch(articleLocalRepositoryProvider);
    } else {
      return ref.watch(articleRemoteRepositoryProvider);
    }
  },
);

abstract class IArticleRepository {
  Future<Either<Failure, bool>> addArticle(ArticleEntity session);
  Future<Either<Failure, List<ArticleEntity>>> getAllArticle(
      int page, int limit);
  Future<Either<Failure, bool>> deleteArticle(String id);
}
