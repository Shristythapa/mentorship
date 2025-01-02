// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleApiModel _$ArticleApiModelFromJson(Map<String, dynamic> json) =>
    ArticleApiModel(
      id: json['_id'] as String?,
      title: json['title'] as String,
      body: json['body'] as String,
      mentorId: json['mentorId'] as String,
      mentorName: json['mentorName'] as String,
      mentorEmail: json['mentorEmail'] as String,
      profileUrl: json['profileUrl'] as String,
    );

Map<String, dynamic> _$ArticleApiModelToJson(ArticleApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'mentorId': instance.mentorId,
      'mentorName': instance.mentorName,
      'mentorEmail': instance.mentorEmail,
      'profileUrl': instance.profileUrl,
    };
