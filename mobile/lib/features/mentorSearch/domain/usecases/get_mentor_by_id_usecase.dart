import 'package:app/core/error/failure.dart';
import 'package:app/features/mentorSearch/domain/entity/mentor_search_entity.dart';
import 'package:app/features/mentorSearch/domain/repository/mentor_search_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getMentorByIdUseCaseProvider = Provider((ref) => GetMentorByIdUsecase(
    mentorSearchRepository: ref.read(mentorSearchRepositoryProvider)));

class GetMentorByIdUsecase {
  final IMentorSearchRepository mentorSearchRepository;

  GetMentorByIdUsecase({required this.mentorSearchRepository});

  Future<Either<Failure, MentorSearchEntity>> getMentorById(String id) async {
    return await mentorSearchRepository.getMentorById(id);
  }
}
