import 'package:app/core/error/failure.dart';
import 'package:app/features/mentorSearch/domain/entity/mentor_search_entity.dart';
import 'package:app/features/mentorSearch/domain/repository/mentor_search_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAllMentorUseCaseProvider = Provider((ref) => GetAllMentorsUseCase(
    mentorSearchRepository: ref.read(mentorSearchRepositoryProvider)));


class GetAllMentorsUseCase {
  final IMentorSearchRepository mentorSearchRepository;

  GetAllMentorsUseCase({required this.mentorSearchRepository});

  Future<Either<Failure, List<MentorSearchEntity>>> getAllMentors() async {
    return await mentorSearchRepository.getAllMentors();
  }
}
