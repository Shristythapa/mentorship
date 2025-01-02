import 'dart:math';

import 'package:app/config/constants/hive_table_constant.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

part 'session_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.sessionTableId)
class SessionHiveModel {
  @HiveField(0)
  final String? sessionId;

  @HiveField(1)
  final String mentorId;

  @HiveField(2)
  final String mentorEmail;

  @HiveField(3)
  final String mentorName;

  @HiveField(4)
  final String title;

  @HiveField(5)
  final String description;

  @HiveField(6)
  final DateTime date;

  @HiveField(7)
  final String startTime;

  @HiveField(8)
  final String endTime;

  @HiveField(9)
  final bool isOngoing;

  @HiveField(10)
  final List<Map<String, String>>? attendesSigned;

  @HiveField(11)
  final int? noOfAttendesSigned;

  @HiveField(12)
  final int maxNumberOfAttendesTaking;


  SessionHiveModel.empty()
      : this(
            sessionId: '',
            mentorId: '',
            mentorEmail: '',
            mentorName: '',
            title: '',
            description: '',
            date: DateTime(0),
            startTime: '',
            endTime: '',
            isOngoing: false,
            noOfAttendesSigned: 0,
            attendesSigned: [],
            maxNumberOfAttendesTaking: 0,
            );

  SessionHiveModel({
    String? sessionId,
    required this.mentorId,
    required this.mentorEmail,
    required this.mentorName,
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.isOngoing,
    this.noOfAttendesSigned,
    this.attendesSigned,
    required this.maxNumberOfAttendesTaking,
  }) : sessionId = sessionId ?? const Uuid().v4();

  @override
  String toString() {
    return 'SessionHiveModel{'
        'sessionId: $sessionId, '
        'title: $title, '
        'description: $description, '
        'date: $date, '
        'startTime: $startTime, '
        'endTime: $endTime, '
        'attendesSigned: $attendesSigned, '
        'noOfAttendesSigned: $noOfAttendesSigned, '
        'maxNumberOfAttendesTaking: $maxNumberOfAttendesTaking, '
        'mentorId: $mentorId}';
  }

  static SessionEntity toEntity(SessionHiveModel hiveModel) => SessionEntity(
        id: hiveModel.sessionId ?? '',
        mentorEmail: hiveModel.mentorEmail,
        mentorName: hiveModel.mentorName,
        title: hiveModel.title,
        description: hiveModel.description,
        date: hiveModel.date,
        startTime: hiveModel.startTime,
        endTime: hiveModel.endTime,
        isOngoing: hiveModel.isOngoing,
        attendesSigned: hiveModel.attendesSigned?? [],
        noOfAttendesSigned: hiveModel.noOfAttendesSigned??0,
        maxNumberOfAttendesTaking: hiveModel.maxNumberOfAttendesTaking,
        mentorId: hiveModel.mentorId,
      );

  factory SessionHiveModel.toHiveModel(SessionEntity entity) {
    return SessionHiveModel(
      sessionId: entity.id,
      mentorEmail: entity.mentorEmail,
      mentorName: entity.mentorName,
      title: entity.title,
      description: entity.description,
      date: entity.date,
      startTime: entity.startTime,
      endTime: entity.endTime,
      isOngoing: entity.isOngoing,
      attendesSigned: entity.attendesSigned,
      noOfAttendesSigned: entity.noOfAttendesSigned,
      maxNumberOfAttendesTaking: entity.maxNumberOfAttendesTaking,
      mentorId: entity.mentorId,
    );
  }
}
