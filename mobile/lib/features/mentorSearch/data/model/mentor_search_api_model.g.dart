// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_search_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MentorSearchApiModel _$MentorSearchApiModelFromJson(
        Map<String, dynamic> json) =>
    MentorSearchApiModel(
      id: json['_id'] as String,
      mentorProfileInformation: MentorProfileInformation.fromJson(
          json['mentorProfileInformation'] as Map<String, dynamic>),
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      profileUrl: json['profileUrl'] as String,
      v: json['__v'] as int,
    );

Map<String, dynamic> _$MentorSearchApiModelToJson(
        MentorSearchApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'mentorProfileInformation': instance.mentorProfileInformation,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'profileUrl': instance.profileUrl,
      '__v': instance.v,
    };

MentorProfileInformation _$MentorProfileInformationFromJson(
        Map<String, dynamic> json) =>
    MentorProfileInformation(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      address: json['address'] as String,
      skills:
          (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MentorProfileInformationToJson(
        MentorProfileInformation instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'address': instance.address,
      'skills': instance.skills,
    };
