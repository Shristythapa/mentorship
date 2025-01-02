import 'package:app/core/error/failure.dart';
import 'package:app/features/forgot_password/domain/repository/forgot_password_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menteeForgotPasswordUseCase = Provider.autoDispose<MenteeForgotPasswordUseCase>((ref) =>
    MenteeForgotPasswordUseCase(
        forgotPasswordRepository: ref.read(forgotPasswordRepository)));

class MenteeForgotPasswordUseCase {
  final IForgotPasswordRepository forgotPasswordRepository;

  MenteeForgotPasswordUseCase({required this.forgotPasswordRepository});

  Future<Either<Failure, bool>> menteeForgotPassword(String email) async {
    return await forgotPasswordRepository.forgotPasswordMentee(email);
  }
}
