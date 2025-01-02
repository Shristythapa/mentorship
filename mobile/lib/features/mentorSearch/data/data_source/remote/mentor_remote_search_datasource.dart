import 'package:app/config/constants/api_endpoints.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/network/http_service.dart';
import 'package:app/core/shared_pref/user_shared_prefs.dart';
import 'package:app/features/mentorSearch/data/dto/get_all_mentor.dart';
import 'package:app/features/mentorSearch/data/model/mentor_search_api_model.dart';
import 'package:app/features/mentorSearch/domain/entity/mentor_search_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mentorSearchRemoteDataSourceProvider =
    Provider((ref) => MentorSearchRemoteDataSource(
          dio: ref.read(httpServiceProvider),
          userSharedPrefs: ref.read(userSharedPrefsProvider),
        ));

class MentorSearchRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  MentorSearchRemoteDataSource({
    required this.dio,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, MentorSearchEntity>> getMentorById(String id) async {
    try {
      print(" end point ${ApiEndpoints.getMentorById + id}");
      Response response = await dio.get(ApiEndpoints.getMentorById + id);
      print("response");
      if (response.statusCode == 200) {
        MentorSearchApiModel mentorSearchApiModel =
            MentorSearchApiModel.fromJson(response.data['mentor']);

        return Right(MentorSearchApiModel.toEntity(mentorSearchApiModel));
      } else {
        return Left(Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      print(e);
      return Left(Failure(error: "Get Mentor By id : Api connection error"));
    }
  }

  Future<Either<Failure, List<MentorSearchEntity>>> getAllMentors() async {
    try {
      Response response = await dio.get(ApiEndpoints.getAllMentors);

      print(response);

      if (response.statusCode == 200) {
        GetAllMentorsDTO getAllMentorDTO =
            GetAllMentorsDTO.fromJson(response.data);

        List<MentorSearchEntity> mentorSearchEntity = getAllMentorDTO.mentors
            .map((mentor) => MentorSearchApiModel.toEntity(mentor))
            .toList();

        return Right(mentorSearchEntity);
      } else {
        return Left(Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(Failure(
          error: e.response!.data['message'],
          statusCode: "404",
        ));
      }
      print(e);

      return Left(Failure(error: "Api connection error"));
    }
  }
}
