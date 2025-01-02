import 'package:app/core/error/failure.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/sessions/domain/repository/session_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getSessionByIdUsecaseProvider = Provider((ref) => GetSessionByIdUsecase(
    sessionRepository: ref.read(sessionRepositoryProvider)));

class GetSessionByIdUsecase {
  final ISessionRepository sessionRepository;

  GetSessionByIdUsecase({required this.sessionRepository});

  Future<Either<Failure, SessionEntity>> getSessionById(String id) async {
    return await sessionRepository.getSessionById(id);
  }
}
