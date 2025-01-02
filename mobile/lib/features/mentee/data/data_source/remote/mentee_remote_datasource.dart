import 'dart:io';
import 'package:app/config/constants/api_endpoints.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/network/http_service.dart';
import 'package:app/core/shared_pref/user_shared_prefs.dart';
import 'package:app/features/mentee/domain/entity/mentee_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menteeRemoteDataSourceProvider = Provider((ref) => MenteeRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider),
    ));

class MenteeRemoteDataSource {
  final UserSharedPrefs userSharedPrefs;

  final Dio dio;

  MenteeRemoteDataSource({
    required this.userSharedPrefs,
    required this.dio,
    // required this.sharedPref
  });

  Future<Either<Failure, bool>> register(
      File image, MenteeEntity menteeEntity) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'name': menteeEntity.userName,
          'email': menteeEntity.email,
          'password': menteeEntity.password,
          'profilePicture': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        },
      );

      Response response = await dio.post(
        ApiEndpoints.menteeRegister,
        data: formData,
      );

      if (response.statusCode == 200) {
        return const Right(true);
      }
      return Left(Failure(
          error: "Server error", statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      if (e.response != null) {
        print("Error: ${e.response!.data}");
        return Left(Failure(
          error: e.response!.data['message'],
          statusCode: "404",
        ));
      }
      print("sign up failed $e");
      return Left(
        Failure(
          error: "Api connection error",
          statusCode: "Error",
        ),
      );
    }
  }

  Future<Either<Failure, bool>> login(String email, String password) async {
    print("loging");
    print(email);
    print(password);
    try {
      FormData formData = FormData.fromMap(
        {
          'email': email,
          'password': password,
        },
      );

      Response response = await dio.post(
        ApiEndpoints.menteeLogin,
        data: formData,
      );

      print("responseee $response");

      if (response.statusCode == 200) {
        String token = response.data['token'];
        await userSharedPrefs.setUserDetails(response.data['mentee']);
        await userSharedPrefs.setUserToken(token);
        print(response);
        return const Right(true);
      } else {
        return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("Error: ${e.response!.data}");
        return Left(Failure(
          error: e.response!.data['message'],
          statusCode: "404",
        ));
      }
      print("login failed $e");
      return Left(
        Failure(
          error: "Api connection error",
          statusCode: "Error",
        ),
      );
    }
  }
}
