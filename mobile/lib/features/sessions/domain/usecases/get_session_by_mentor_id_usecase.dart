import 'package:app/core/error/failure.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/sessions/domain/repository/session_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getSessionByMentorIdUsecaseProvider = Provider((ref) =>
    GetSessionByMentorIdUsecase(
        repository: ref.read(sessionRepositoryProvider)));

class GetSessionByMentorIdUsecase {
  final ISessionRepository repository;

  GetSessionByMentorIdUsecase({required this.repository});

  Future<Either<Failure, List<SessionEntity>>> getSessionByMentorId(
      String id) async {
    return await repository.getSessionByMentorId(id);
  }
}
