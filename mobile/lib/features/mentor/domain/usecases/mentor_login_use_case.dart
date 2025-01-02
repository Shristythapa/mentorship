
import 'package:app/core/error/failure.dart';
import 'package:app/features/mentor/domain/repository/mentor_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mentorLoginUseCase = Provider(
    (ref) => MentorLoginUseCase(mentorRepository: ref.read(mentorRepository)));

class MentorLoginUseCase {
  final IMentorRepository mentorRepository;

  MentorLoginUseCase({required this.mentorRepository});

  Future<Either<Failure, bool>> loginMentee(String email, String password) async {
    return await mentorRepository.login(email,password);
  }
}
