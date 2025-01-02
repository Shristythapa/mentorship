// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginMenteeDTO _$LoginMenteeDTOFromJson(Map<String, dynamic> json) =>
    LoginMenteeDTO(
      success: json['success'] as bool,
      token: json['token'] as String?,
      message: json['message'] as String,
    );

Map<String, dynamic> _$LoginMenteeDTOToJson(LoginMenteeDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'token': instance.token,
      'message': instance.message,
    };
