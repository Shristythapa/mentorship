import 'package:app/core/error/failure.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/sessions/domain/repository/session_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final joinSessionUsecaseProvider = Provider((ref) =>
    JoinSessionUsecase(sessionRepository: ref.read(sessionRepositoryProvider)));

class JoinSessionUsecase {
  final ISessionRepository sessionRepository;

  JoinSessionUsecase({required this.sessionRepository});

  Future<Either<Failure, bool>> joinSession(SessionEntity sessionEntity) async {
    return await sessionRepository.joinSession(sessionEntity);
  }
}
