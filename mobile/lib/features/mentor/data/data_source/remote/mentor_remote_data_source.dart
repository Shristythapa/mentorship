import 'dart:io';
import 'package:app/config/constants/api_endpoints.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/network/http_service.dart';
import 'package:app/core/shared_pref/user_shared_prefs.dart';
import 'package:app/features/mentor/data/model/mentor_api_model.dart';
import 'package:app/features/mentor/domain/entity/mentor_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mentorRemoteDataSourceProvider = Provider((ref) => MentorRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider),
    ));

class MentorRemoteDataSource {
  final Dio dio;

  final UserSharedPrefs userSharedPrefs;

  MentorRemoteDataSource({required this.userSharedPrefs, required this.dio});

  Future<Either<Failure, bool>> register(
      File image, MentorEntity mentorEntity) async {
    try {
      MentorApiModel mentorApiModel = MentorApiModel.fromEntity(mentorEntity);
      String fileName = image.path.split('/').last;

      FormData formData = FormData.fromMap(
        {
          'name': mentorApiModel.name,
          'email': mentorApiModel.email,
          'password': mentorApiModel.password,
          'firstName': mentorApiModel.firstName,
          'lastName': mentorApiModel.lastName,
          'dateOfBirth': mentorApiModel.dateOfBirth,
          'address': mentorApiModel.address,
          'skills': mentorApiModel.skills,
          'profilePicture': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        },
      );

      Response response = await dio.post(
        ApiEndpoints.mentorRegister,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      }

      return Left(Failure(
          error: response.data["data"],
          statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      if (e.response != null) {

        return Left(Failure(
          error: e.response!.data['message'],
          statusCode: "404",
        ));
      }

      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> login(String email, String password) async {

    try {
      FormData formData = FormData.fromMap(
        {
          'email': email,
          'password': password,
        },
      );

      Response response = await dio.post(
        ApiEndpoints.mentorLogin,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        var token = response.data['token'];
        await userSharedPrefs.setUserDetails(response.data['mentor']);
        await userSharedPrefs.setUserToken(token);
        return const Right(true);
      }
      return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      if (e.response != null) {
   
        return Left(Failure(
          error: e.response!.data['message'],
          statusCode: "404",
        ));
      }
 
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
