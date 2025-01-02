import 'package:app/core/error/failure.dart';
import 'package:app/features/mentorSearch/data/repository/mentor_search_remote_repository.dart';
import 'package:app/features/mentorSearch/domain/entity/mentor_search_entity.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mentorSearchRepositoryProvider = Provider<IMentorSearchRepository>(
    (ref) => ref.read(mentorSearchRemoteRepository));

abstract class IMentorSearchRepository {
  Future<Either<Failure, MentorSearchEntity>> getMentorById(String id);
  Future<Either<Failure, List<MentorSearchEntity>>> getAllMentors();
}
