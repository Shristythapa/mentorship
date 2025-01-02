import 'dart:io';
import 'package:app/core/error/failure.dart';
import 'package:app/features/mentor/data/repository/mentor_remote_repository.dart';
import 'package:app/features/mentor/domain/entity/mentor_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final mentorRepository = Provider.autoDispose<IMentorRepository>(
    (ref) => ref.read(mentorRemoteRepositoryProvider));

abstract class IMentorRepository {

  Future<Either<Failure, bool>> addMentor(File file, MentorEntity mentor);
    Future<Either<Failure, bool>> login(String email,String password);
  
}
