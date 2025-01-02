import 'dart:io';

import 'package:app/core/error/failure.dart';
import 'package:app/features/mentee/domain/entity/mentee_entity.dart';
import 'package:app/features/mentee/domain/repository/mentee_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menteeRegisterUseCase = Provider(
    (ref) => RegisterUseCase(menteeRepository: ref.read(menteeRepository)));

class RegisterUseCase {
  final IMenteeRepository menteeRepository;

  RegisterUseCase({required this.menteeRepository});

  Future<Either<Failure, bool>> registerMentee(
      File file, MenteeEntity menteeEntity) async {
    return await menteeRepository.addMentee(file, menteeEntity);
  }
}
