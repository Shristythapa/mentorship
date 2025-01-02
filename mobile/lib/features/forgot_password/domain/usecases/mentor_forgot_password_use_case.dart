import 'package:app/core/error/failure.dart';
import 'package:app/features/forgot_password/domain/repository/forgot_password_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mentorForgotPasswordUseCase = Provider((ref) =>
    MentorForogotPasswordUseCase(
        forgotPasswordRepository: ref.read(forgotPasswordRepository)));

class MentorForogotPasswordUseCase {
  final IForgotPasswordRepository forgotPasswordRepository;

  MentorForogotPasswordUseCase({required this.forgotPasswordRepository});

  Future<Either<Failure, bool>> mentorForgotPassword(String email) async {
    return await forgotPasswordRepository.forgotPasswordMentor(email);
  }
}
