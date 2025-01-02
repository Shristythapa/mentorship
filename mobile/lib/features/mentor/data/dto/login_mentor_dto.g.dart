// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_mentor_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginMentorDTO _$LoginMentorDTOFromJson(Map<String, dynamic> json) =>
    LoginMentorDTO(
      success: json['success'] as bool,
      token: json['token'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$LoginMentorDTOToJson(LoginMentorDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'token': instance.token,
      'message': instance.message,
    };
