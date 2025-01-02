import 'package:app/config/constants/api_endpoints.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/network/http_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordRemoteDataSource = Provider((ref) =>
    ForgotPasswordRemoteDataSource(dio: ref.read(httpServiceProvider)));

class ForgotPasswordRemoteDataSource {
  final Dio dio;

  ForgotPasswordRemoteDataSource({required this.dio});

  Future<Either<Failure, bool>> forgotPasswordMentee(String email) async {
    FormData formData = FormData.fromMap(
      {
        'email': email,
      },
    );
    try {
      Response response =
          await dio.post(ApiEndpoints.forgotPasswordMentee, data: formData);

      if (response.statusCode == 200) {
        print(response);
        return const Right(true);
      } else {
        return Left(Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      print(e);
      return Left(Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString()));
    }
  }
  //  Future<Either<Failure, bool>> forgotPasswordMentor(){

  //  }
}
