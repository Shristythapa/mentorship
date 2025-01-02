import 'dart:convert';
import 'package:app/features/articles/domain/entity/article_entity.dart';
import 'package:flutter/services.dart';

Future<List<ArticleEntity>> getArticleListTest() async {
  final response =
      await rootBundle.loadString('test_data/article_test_data.json');
  final jsonList = await json.decode(response);
  final List<ArticleEntity> sessionList = jsonList
      .map<ArticleEntity>((json) => ArticleEntity.fromJson(json))
      .toList();

  return Future.value(sessionList);
}
