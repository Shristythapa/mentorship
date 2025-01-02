import 'package:app/features/mentee/domain/entity/mentee_entity.dart';

class MenteeApiModel {

  final String? menteeId;
  final String name;
  final String email;
  final String password;

  MenteeApiModel({
    this.menteeId,
    required this.name,
    required this.email,
    required this.password,
  });

  factory MenteeApiModel.fromJson(Map<String, dynamic> json) {
    return MenteeApiModel(
      menteeId: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

   factory MenteeApiModel.fromEntity(MenteeEntity entity) {
    return MenteeApiModel(
      menteeId: entity.menteeId,
      name: entity.userName,
      email: entity.email,
      password: entity.password,
    );
  }
}
