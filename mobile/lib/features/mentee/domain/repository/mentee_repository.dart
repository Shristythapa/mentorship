import 'dart:io';

import 'package:app/core/error/failure.dart';
import 'package:app/features/mentee/data/repository/mentee_remote_repository.dart';
import 'package:app/features/mentee/domain/entity/mentee_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menteeRepository = Provider.autoDispose<IMenteeRepository>(
    (ref) => ref.read(menteeRemoteRepositoryProvider));

//NOTE: domaincan have only one repo file
abstract class IMenteeRepository {
  Future<Either<Failure, bool>> addMentee(File file, MenteeEntity mentee);
  Future<Either<Failure, bool>> loginMentee(String email, String password);
}
