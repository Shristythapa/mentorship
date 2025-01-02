import 'package:app/core/error/failure.dart';
import 'package:app/features/sessions/data/repository/session_remote_repo.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sessionRepositoryProvider = Provider<ISessionRepository>((ref) {
  // final connectivityStatus = ref.watch(connectivityStatusProvider);
  // if (connectivityStatus == ConnectivityStatus.isConnected) {
  //   return ref.read(sessionRemoteRepositoryProvider);
  // } else {
  return ref.read(sessionRemoteRepositoryProvider);
  // }
});

abstract class ISessionRepository {
  Future<Either<Failure, bool>> addSession(SessionEntity session);
  Future<Either<Failure, List<SessionEntity>>> getAllSession();
  Future<Either<Failure, SessionEntity>> getSessionById(String id);
  Future<Either<Failure, bool>> deleteSession(String id);
  Future<Either<Failure, bool>> joinSession(SessionEntity sessionEntity);
  Future<Either<Failure, List<SessionEntity>>> getSessionByMentorId(String id);
}
