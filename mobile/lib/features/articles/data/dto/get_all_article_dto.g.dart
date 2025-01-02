// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_article_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllArticleDTO _$GetAllArticleDTOFromJson(Map<String, dynamic> json) =>
    GetAllArticleDTO(
      success: json['success'] as bool,
      count: json['count'] as int,
      articles: (json['articles'] as List<dynamic>)
          .map((e) => ArticleApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllArticleDTOToJson(GetAllArticleDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'articles': instance.articles,
    };
