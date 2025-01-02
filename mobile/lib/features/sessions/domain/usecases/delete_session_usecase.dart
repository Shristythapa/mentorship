import 'package:app/core/error/failure.dart';
import 'package:app/features/sessions/domain/repository/session_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deleteSessionUseCaseProvider = Provider((ref) => DeleteSessionUsecase(
    sessionRepository: ref.read(sessionRepositoryProvider)));

class DeleteSessionUsecase {
  final ISessionRepository sessionRepository;

  DeleteSessionUsecase({required this.sessionRepository});

  Future<Either<Failure, bool>> deleteSession(String id) async {
    return await sessionRepository.deleteSession(id);
  }
}
