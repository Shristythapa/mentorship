// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_mentor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllMentorsDTO _$GetAllMentorsDTOFromJson(Map<String, dynamic> json) =>
    GetAllMentorsDTO(
      success: json['success'] as bool,
      message: json['message'] as String,
      mentors: (json['mentors'] as List<dynamic>)
          .map((e) => MentorSearchApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllMentorsDTOToJson(GetAllMentorsDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'mentors': instance.mentors,
    };
