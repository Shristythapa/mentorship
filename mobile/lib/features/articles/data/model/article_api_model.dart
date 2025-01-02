import 'package:app/features/articles/domain/entity/article_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_api_model.g.dart';

@JsonSerializable()
class ArticleApiModel {
  @JsonKey(name: '_id')
  final String? id;
  final String title;
  final String body;
  final String mentorId;
  final String mentorName;
  final String mentorEmail;
  final String profileUrl;

  ArticleApiModel(
      {this.id,
      required this.title,
      required this.body,
      required this.mentorId,
      required this.mentorName,
      required this.mentorEmail,
      required this.profileUrl});

  factory ArticleApiModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleApiModelToJson(this);

  factory ArticleApiModel.fromEntity(ArticleEntity articleEntity) {
    return ArticleApiModel(
        id: articleEntity.id,
        title: articleEntity.title,
        body: articleEntity.body,
        mentorId: articleEntity.mentorId,
        mentorName: articleEntity.mentorName,
        mentorEmail: articleEntity.mentorEmail,
        profileUrl: articleEntity.profileUrl);
  }

  static ArticleEntity toEntity(ArticleApiModel articleApiModel) {
    return ArticleEntity(
        id: articleApiModel.id,
        title: articleApiModel.title,
        body: articleApiModel.body,
        mentorId: articleApiModel.mentorId,
        mentorName: articleApiModel.mentorName,
        mentorEmail: articleApiModel.mentorEmail,
        profileUrl: articleApiModel.profileUrl);
  }
}
