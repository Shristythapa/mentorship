import 'dart:io';
import 'package:app/core/error/failure.dart';
import 'package:app/features/mentor/domain/entity/mentor_entity.dart';

import 'package:app/features/mentor/domain/repository/mentor_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mentorRegistrationUseCase = Provider(
    (ref) => MentorRegisterUseCase(mentorRepository: ref.read(mentorRepository)));

class MentorRegisterUseCase {
  final IMentorRepository mentorRepository;

  MentorRegisterUseCase({required this.mentorRepository});

  Future<Either<Failure, bool>> registerMentor(
      File file, MentorEntity mentorEntity) async {
    print("usecase");
    return await mentorRepository.addMentor(file,mentorEntity );
  }
}
