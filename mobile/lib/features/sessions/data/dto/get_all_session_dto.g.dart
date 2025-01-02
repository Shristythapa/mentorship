// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllSessionDTO _$GetAllSessionDTOFromJson(Map<String, dynamic> json) =>
    GetAllSessionDTO(
      success: json['success'] as bool,
      count: json['count'] as int,
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => SessionApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllSessionDTOToJson(GetAllSessionDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'sessions': instance.sessions,
    };
