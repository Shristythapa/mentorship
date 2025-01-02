import 'package:app/core/error/failure.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/sessions/domain/repository/session_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAllSessionUsecaseProvider = Provider(
    (ref) => GetAllSessionsUsecase(repository: ref.read(sessionRepositoryProvider)));

class GetAllSessionsUsecase {
  final ISessionRepository repository;
  GetAllSessionsUsecase({required this.repository});

  Future<Either<Failure, List<SessionEntity>>> getAllSession() async {
    return await repository.getAllSession();
  }
}
