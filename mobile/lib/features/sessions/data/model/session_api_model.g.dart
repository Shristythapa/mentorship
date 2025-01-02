// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mentor _$MentorFromJson(Map<String, dynamic> json) => Mentor(
      name: json['name'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$MentorToJson(Mentor instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
    };

SessionApiModel _$SessionApiModelFromJson(Map<String, dynamic> json) =>
    SessionApiModel(
      id: json['_id'] as String?,
      mentorId: json['mentorId'] as String,
      mentor: Mentor.fromJson(json['mentor'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      isOngoing: json['isOngoing'] as bool,
      attendesSigned: (json['attendesSigned'] as List<dynamic>)
          .map((e) => Map<String, String>.from(e as Map))
          .toList(),
      noOfAttendesSigned: json['noOfAttendesSigned'] as int,
      maxNumberOfAttendesTaking: json['maxNumberOfAttendesTaking'] as int,
    );

Map<String, dynamic> _$SessionApiModelToJson(SessionApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'mentorId': instance.mentorId,
      'mentor': instance.mentor,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'isOngoing': instance.isOngoing,
      'attendesSigned': instance.attendesSigned,
      'noOfAttendesSigned': instance.noOfAttendesSigned,
      'maxNumberOfAttendesTaking': instance.maxNumberOfAttendesTaking,
    };
