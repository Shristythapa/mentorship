import 'package:app/core/error/failure.dart';
import 'package:app/features/forgot_password/data/data_source/remote/forgot_password_remote_data_source.dart';
import 'package:app/features/forgot_password/domain/repository/forgot_password_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordRemoteRepository = Provider.autoDispose((ref) =>
    ForgotPasswordRemoteRepository(
        forgotPasswordRemoteDataSource:
            ref.read(forgotPasswordRemoteDataSource)));

class ForgotPasswordRemoteRepository implements IForgotPasswordRepository {
  final ForgotPasswordRemoteDataSource forgotPasswordRemoteDataSource;

  ForgotPasswordRemoteRepository(
      {required this.forgotPasswordRemoteDataSource});
  @override
  Future<Either<Failure, bool>> changePassowrdMentee(String updatedPassword) {
    // TODO: implement changePassowrdMentee
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> changePasswordMentor(String updatePassword) {
    // TODO: implement changePasswordMentor
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> forgotPasswordMentee(String email) {
    return forgotPasswordRemoteDataSource.forgotPasswordMentee(email);
  }

  @override
  Future<Either<Failure, bool>> forgotPasswordMentor(String email) {
    // TODO: implement forgotPasswordMentor
    throw UnimplementedError();
  }
}
