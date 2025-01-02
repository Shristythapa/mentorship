import 'dart:io';

import 'package:app/core/error/failure.dart';
import 'package:app/features/mentee/data/data_source/remote/mentee_remote_datasource.dart';
import 'package:app/features/mentee/domain/entity/mentee_entity.dart';
import 'package:app/features/mentee/domain/repository/mentee_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menteeRemoteRepositoryProvider = Provider.autoDispose<IMenteeRepository>(
    (ref) => MenteeRemoteRepository(
        menteeRemoteDataSource: ref.read(menteeRemoteDataSourceProvider)));

class MenteeRemoteRepository implements IMenteeRepository {
  final MenteeRemoteDataSource menteeRemoteDataSource;

  MenteeRemoteRepository({required this.menteeRemoteDataSource});
  @override
  Future<Either<Failure, bool>> addMentee(File file, MenteeEntity mentee) {
    print("remote repo");
    return menteeRemoteDataSource.register(file, mentee);
  }

  @override
  Future<Either<Failure, bool>> loginMentee(String email, String password) {
    return menteeRemoteDataSource.login(email, password);
  }
}
