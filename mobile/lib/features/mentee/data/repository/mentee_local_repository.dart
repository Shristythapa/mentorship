// import 'dart:io';

// import 'package:app/core/error/failure.dart';
// import 'package:app/features/mentee/data/data_source/local/mentee_local_data_source.dart';
// import 'package:app/features/mentee/data/model/mentee_hive_model.dart';
// import 'package:app/features/mentee/domain/entity/mentee_entity.dart';
// import 'package:app/features/mentee/domain/repository/mentee_repository.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final menteeLocalRepositoryProvider = Provider((ref) => MenteeLocalRepository(
//     menteeLocalDataSource: ref.read(menteeLocalDataSourceProvider)));

// class MenteeLocalRepository implements IMenteeRepository {
//   final MenteeLocalDataSource menteeLocalDataSource;

//   MenteeLocalRepository({required this.menteeLocalDataSource});
//   @override
//   Future<Either<Failure, bool>> addMentee(File file,MenteeEntity mentee) async {
//     try {
// //convert batch entiry to model
//       MenteeHiveModel batchHiveModel = MenteeHiveModel.fromEntity(mentee);
// //use add batch function of batchlocaldatasource
//       await menteeLocalDataSource.addMentee(batchHiveModel);
//       //return true in case of success
//       return const Right(true);
//     } catch (e) {
//       //return error in case of failure
//       return Left(Failure(error: e.toString()));
//     }
//   }
  
//   @override
//   Future<Either<Failure, bool>> loginMentee(String email, String password) {
//     // TODO: implement loginMentee
//     throw UnimplementedError();
//   }




// }
