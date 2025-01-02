import 'package:app/core/error/failure.dart';
import 'package:app/features/forgot_password/data/repository/forgot_password_remote_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordRepository =
    Provider.autoDispose((ref) => ref.read(forgotPasswordRemoteRepository));

abstract class IForgotPasswordRepository {
  Future<Either<Failure, bool>> forgotPasswordMentee(String email);
  Future<Either<Failure, bool>> forgotPasswordMentor(String email);
  Future<Either<Failure, bool>> changePassowrdMentee(String updatedPassword);
  Future<Either<Failure, bool>> changePasswordMentor(String updatePassword);
}
