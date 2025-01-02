import 'package:app/features/mentor/domain/entity/mentor_entity.dart';

class MentorApiModel {
  final String? menteeId;
  final String name;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String address;
  final List<String> skills;

  MentorApiModel({
    this.menteeId,
    required this.name,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.address,
    required this.skills,
  });

  factory MentorApiModel.fromJson(Map<String, dynamic> json) {
    return MentorApiModel(
      menteeId: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dateOfBirth: json['dateOfBirth'],
      address: json['address'],
      skills: List<String>.from(json['skills']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': menteeId,
      'name': name,
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'skills': skills,
    };
  }

  factory MentorApiModel.fromEntity(MentorEntity entity) {
    return MentorApiModel(
      menteeId: entity.mentorId,
      name: entity.userName,
      email: entity.email,
      password: entity.password,
      firstName: entity.firstName,
      lastName: entity.lastName,
      dateOfBirth: entity.dateOfBirth,
      address: entity.address,
      skills: entity.skills,
    );
  }
}
