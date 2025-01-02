import 'dart:convert';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:flutter/services.dart';

Future<List<SessionEntity>> getSessionListTest() async {
  final response = await rootBundle.loadString('test_data/session_test_data.json');
  final jsonList = await json.decode(response);
  final List<SessionEntity> sessionList = jsonList
      .map<SessionEntity>((json) => SessionEntity.fromJson(json))
      .toList();

  return Future.value(sessionList);
}
