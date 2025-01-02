import 'package:app/features/articles/data/model/article_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_article_dto.g.dart';

@JsonSerializable()
class GetAllArticleDTO {
  final bool success;
  final int count;
  final List<ArticleApiModel> articles;

  GetAllArticleDTO(
      {required this.success, required this.count, required this.articles});

  factory GetAllArticleDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllArticleDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllArticleDTOToJson(this);
}
