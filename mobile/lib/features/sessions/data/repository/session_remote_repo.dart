import 'package:app/core/error/failure.dart';
import 'package:app/features/sessions/data/data_source/remote/sessions_remote_data_source.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/sessions/domain/repository/session_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sessionRemoteRepositoryProvider =
    Provider.autoDispose<ISessionRepository>((ref) => SessionRemoteRepo(
        sessionRemoteDataSource: ref.read(sessionRemoteDataSourceProvider)));

class SessionRemoteRepo implements ISessionRepository {
  final SessionRemoteDataSource sessionRemoteDataSource;

  const SessionRemoteRepo({required this.sessionRemoteDataSource});
  @override
  Future<Either<Failure, bool>> addSession(SessionEntity session) {
    return sessionRemoteDataSource.addSession(session);
  }

  @override
  Future<Either<Failure, List<SessionEntity>>> getAllSession() {
    return sessionRemoteDataSource.getAllSessions();
  }

  @override
  Future<Either<Failure, SessionEntity>> getSessionById(String id) {
    return sessionRemoteDataSource.getSessionById(id);
  }

  @override
  Future<Either<Failure, bool>> deleteSession(String id) {
    return sessionRemoteDataSource.deleteSession(id);
  }
  
  @override
  Future<Either<Failure, bool>> joinSession(SessionEntity sessionEntity) {
    return sessionRemoteDataSource.joinSession(sessionEntity);
  }

  @override
  Future<Either<Failure, List<SessionEntity>>> getSessionByMentorId(String id) {
    return sessionRemoteDataSource.getSessionByMentorId(id);
  }
}
