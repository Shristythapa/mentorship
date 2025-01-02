import 'package:app/core/error/failure.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/sessions/domain/repository/session_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addSessionUsecaseProvider = Provider((ref) =>
    AddSessionUsecase(sessionRepository: ref.read(sessionRepositoryProvider)));

class AddSessionUsecase {
  final ISessionRepository sessionRepository;

  AddSessionUsecase({required this.sessionRepository});

  Future<Either<Failure, bool>> addSession(SessionEntity sessionEntity) async {
    return await sessionRepository.addSession(sessionEntity);
  }
}
