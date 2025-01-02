import 'package:app/config/constants/api_endpoints.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/network/http_service.dart';
import 'package:app/core/shared_pref/user_shared_prefs.dart';
import 'package:app/core/provider/notification_view_model.dart';
import 'package:app/features/sessions/data/dto/get_all_session_dto.dart';
import 'package:app/features/sessions/data/model/session_api_model.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final sessionRemoteDataSourceProvider = Provider((ref) =>
    SessionRemoteDataSource(
        dio: ref.read(httpServiceProvider),
        userSharedPrefs: ref.read(userSharedPrefsProvider),
        notification: ref.read(notificationViewModelProvider)));

class SessionRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final NotificationViewModel notification;
  SessionRemoteDataSource(
      {required this.dio,
      required this.userSharedPrefs,
      required this.notification});

  Future<Either<Failure, List<SessionEntity>>> getAllSessions() async {
    try {
      print(ApiEndpoints.getAllSessions);
      Response response = await dio.get(
        ApiEndpoints.getAllSessions,
      );

      print(response);
      if (response.statusCode == 200) {
        GetAllSessionDTO getAllSessionDTO =
            GetAllSessionDTO.fromJson(response.data);

        List<SessionEntity> sessionList = getAllSessionDTO.sessions
            .map((session) => SessionApiModel.toEntity(session))
            .toList();

        return Right(sessionList);
      } else {
        return Left(Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      print((e));
      return Left(Failure(error: "Get All Session: Api connection error"));
    }
  }

  Future<Either<Failure, bool>> addSession(SessionEntity sessionEntity) async {
    notification.requestPermission();
    notification.getToken(sessionEntity.title);
    try {
      SessionApiModel sessionApiModel =
          SessionApiModel.fromEntity(sessionEntity);
      var response = await dio.post(ApiEndpoints.createSession,
          data: sessionApiModel.toJson());

      if (response.statusCode == 200) {
        return const Right(true);
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
      return Left(Failure(
          error: "Add Session: Api connection error", statusCode: "400"));
    }
  }

  Future<Either<Failure, SessionEntity>> getSessionById(String id) async {
    try {
      var response = await dio.get(ApiEndpoints.getSessionById + id);
      if (response.statusCode == 200) {
        final sessionData = response.data['session'];
        final session = SessionApiModel.fromJson(sessionData);
        final sessionEntity = SessionApiModel.toEntity(session);
        return Right(sessionEntity);
      } else {
        print(response);
        return Left(Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      print(e);
      return Left(Failure(error: "Get Sesison By Id: Api connection error"));
    }
  }

  Future<Either<Failure, bool>> deleteSession(String id) async {
    try {
      var response = await dio.delete(
        ApiEndpoints.deleteSession + id,
      );
      print(response);
      if (response.statusCode == 200) {
        return const Right(true);
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
      return Left(Failure(error: "Delete Session: Api connection error"));
    }
  }

  Future<Either<Failure, bool>> joinSession(SessionEntity session) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      if (token == null) {
        return left(Failure(error: "User Invalid"));
      }

      final decodedToken = JwtDecoder.decode(token!);

      // Ensure a minimum duration by waiting for both the splash screen duration and token retrieval process
      await Future.wait([
        Future.delayed(const Duration(seconds: 5)), // Adjust as needed
        Future.microtask(() => decodedToken), // Fetch the token concurrently
      ]);

      print('session ${session.id}');

      print(ApiEndpoints.joinSession + session.id!);

      final response = await dio.put(
        ApiEndpoints.joinSession + session.id!,
        data: {
          "menteeEmail": decodedToken["email"],
          "menteeId": decodedToken['id']
        },
      );
      print(response);

      if (response.statusCode == 200) {
        String? mentorToken = await notification.getUserToken(session.title);

        await notification.sendPushMessage(
            mentorToken!,
            "User with ${decodedToken['email']} email joined.",
            "Mentee Joined ${session.title} session.");
        return right(true);
      } else {
        print(response);
        return left(Failure(
          error: response.statusMessage ?? "Unknown error",
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(Failure(
          error: e.response!.data['message'],
          statusCode: "404",
        ));
      }
      print(e);
      return left(Failure(error: "Join Session: Unknown error"));
    }
  }

  Future<Either<Failure, List<SessionEntity>>> getSessionByMentorId(
      String id) async {
    try {
      Response response = await dio.get(ApiEndpoints.getSessionByMentorId + id);
      if (response.statusCode == 200) {
        GetAllSessionDTO getAllSessionDTO =
            GetAllSessionDTO.fromJson(response.data);

        List<SessionEntity> sessionList = getAllSessionDTO.sessions
            .map((session) => SessionApiModel.toEntity(session))
            .toList();

        return Right(sessionList);
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
      return Left(
          Failure(error: "Get Session By Mentor Id: Api connection error"));
    }
  }
}
