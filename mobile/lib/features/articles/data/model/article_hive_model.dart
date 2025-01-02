import 'package:app/config/constants/hive_table_constant.dart';
import 'package:app/features/articles/domain/entity/article_entity.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

part 'article_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.articleTableId)
class ArticleHiveModel {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String body;

  @HiveField(3)
  final String mentorName;

  @HiveField(4)
  final String mentorEmail;

  @HiveField(5)
  final String profileUrl;

  @HiveField(6)
  final String mentroId;

  ArticleHiveModel.empty()
      : id = null,
        title = '',
        body = '',
        mentroId='',
        mentorName = '',
        mentorEmail = '',
        profileUrl = '';

  ArticleHiveModel({
    String? id,
    required this.mentroId,
    required this.title,
    required this.body,
    required this.mentorName,
    required this.mentorEmail,
    required this.profileUrl,
  }) : id = id ?? const Uuid().v4();

  @override
  String toString() {
    return 'ArticleHiveModel{'
        'id: $id, '
        'title: $title, '
        'body: $body, '
        'mentorId: $mentroId'
        'mentorName: $mentorName, '
        'mentorEmail: $mentorEmail, '
        'profileUrl: $profileUrl}';
  }

  static ArticleEntity toEntity(ArticleHiveModel hiveModel) => ArticleEntity(
        id: hiveModel.id ?? '',
        title: hiveModel.title,
        body: hiveModel.body,
        mentorId: hiveModel.mentroId,
        mentorName: hiveModel.mentorName,
        mentorEmail: hiveModel.mentorEmail,
        profileUrl: hiveModel.profileUrl,
      );

  factory ArticleHiveModel.toHiveModel(ArticleEntity entity) {
    return ArticleHiveModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      mentroId: entity.mentorId,
      mentorName: entity.mentorName,
      mentorEmail: entity.mentorEmail,
      profileUrl: entity.profileUrl,
    );
  }
}
