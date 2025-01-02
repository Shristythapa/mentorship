import 'dart:convert';
import 'package:app/features/mentorSearch/domain/entity/mentor_search_entity.dart';
import 'package:flutter/services.dart';

Future<List<MentorSearchEntity>> getMentorSearchListTest() async {
  final response =
      await rootBundle.loadString('test_data/article_test_data.json');
  final jsonList = await json.decode(response);
  final List<MentorSearchEntity> mentorList = jsonList
      .map<MentorSearchEntity>((json) => MentorSearchEntity.fromJson(json))
      .toList();

  return Future.value(mentorList);
}
