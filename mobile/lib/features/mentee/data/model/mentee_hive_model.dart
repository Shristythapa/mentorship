// import 'package:app/config/constants/hive_table_constant.dart';
// import 'package:app/features/mentee/domain/entity/mentee_entity.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:uuid/uuid.dart';

// part 'mentee_hive_model.g.dart';

// @HiveType(typeId: HiveTableConstant.menteeTableId)
// class MenteeHiveModel {
//   @HiveField(0)
//   final String? menteeId;
//   @HiveField(1)
//   final String userName;
//   @HiveField(2)
//   final String email;
//   @HiveField(3)
//   final String password;

//   MenteeHiveModel.empty()
//       : this(menteeId: '', userName: '', email: '', password: '');

//   MenteeHiveModel({
//     String? menteeId,
//     required this.userName,
//     required this.email,
//     required this.password,
//   }) : menteeId = menteeId ?? const Uuid().v4();

//   @override
//   String toString() {
//     return 'menteeId: $menteeId, username: $userName, email: $email, password: $password,';
//   }

//   //data -> domain
//    MenteeEntity toEntity() => MenteeEntity(
//       menteeId: menteeId, userName: userName, email: email, password: password);

//   factory MenteeHiveModel.fromEntity(MenteeEntity entity) {
//     return MenteeHiveModel(
//         menteeId: entity.menteeId,
//         userName: entity.userName,
//         email: entity.email,
//         password: entity.password);
//   }
// }
