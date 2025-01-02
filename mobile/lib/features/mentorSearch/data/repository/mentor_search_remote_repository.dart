import 'package:app/core/error/failure.dart';
import 'package:app/features/mentorSearch/data/data_source/remote/mentor_remote_search_datasource.dart';
import 'package:app/features/mentorSearch/domain/entity/mentor_search_entity.dart';
import 'package:app/features/mentorSearch/domain/repository/mentor_search_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mentorSearchRemoteRepository =
    Provider.autoDispose<IMentorSearchRepository>((ref) =>
        MentorSearchRemoteRepository(
            mentorSearchRemoteDataSource:
                ref.read(mentorSearchRemoteDataSourceProvider)));

class MentorSearchRemoteRepository implements IMentorSearchRepository {
  final MentorSearchRemoteDataSource mentorSearchRemoteDataSource;

  const MentorSearchRemoteRepository(
      {required this.mentorSearchRemoteDataSource});
  @override
  Future<Either<Failure, MentorSearchEntity>> getMentorById(String id) {
    return mentorSearchRemoteDataSource.getMentorById(id);
  }

  @override
  Future<Either<Failure, List<MentorSearchEntity>>> getAllMentors() {
    return mentorSearchRemoteDataSource.getAllMentors();
  }
}
