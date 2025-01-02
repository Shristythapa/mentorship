import 'package:app/core/error/failure.dart';
import 'package:app/features/mentee/domain/repository/mentee_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menteeLoginUseCase = Provider(
    (ref) => LoginUseCase(menteeRepository: ref.read(menteeRepository)));

class LoginUseCase {
  final IMenteeRepository menteeRepository;

  LoginUseCase({required this.menteeRepository});

  Future<Either<Failure, bool>> loginMentee(
      String email, String password) async {
    return await menteeRepository.loginMentee(email, password);
  }
}
