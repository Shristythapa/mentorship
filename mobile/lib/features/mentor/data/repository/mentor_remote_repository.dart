import 'dart:io';

import 'package:app/core/error/failure.dart';
import 'package:app/features/mentor/data/data_source/remote/mentor_remote_data_source.dart';
import 'package:app/features/mentor/domain/entity/mentor_entity.dart';
import 'package:app/features/mentor/domain/repository/mentor_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mentorRemoteRepositoryProvider = Provider.autoDispose<IMentorRepository>(
    (ref) => MentorRemoteRepository(
        mentorRemoteDataSource: ref.read(mentorRemoteDataSourceProvider)));

class MentorRemoteRepository implements IMentorRepository {
  final MentorRemoteDataSource mentorRemoteDataSource;

  MentorRemoteRepository({required this.mentorRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addMentor(File file, MentorEntity mentor) {
  
    return mentorRemoteDataSource.register(file, mentor);
  }

  @override
  Future<Either<Failure, bool>> login(String email, String password) {
    return mentorRemoteDataSource.login(email, password);
  }
}
