import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_api_model.g.dart';

@JsonSerializable()
class Mentor {
  final String name;
  final String email;

  Mentor({required this.name, required this.email});

  factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
        name: json['name'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}

@JsonSerializable()
class SessionApiModel {
  @JsonKey(name: '_id')
  final String? id;
  final String mentorId;
  final Mentor mentor;
  final String title;
  final String description;
  final DateTime date;
  final String startTime;
  final String endTime;
  final bool isOngoing;
  final List<Map<String, String>> attendesSigned;
  final int noOfAttendesSigned;
  final int maxNumberOfAttendesTaking;

  SessionApiModel({
    this.id,
    required this.mentorId,
    required this.mentor,
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.isOngoing,
    required this.attendesSigned,
    required this.noOfAttendesSigned,
    required this.maxNumberOfAttendesTaking,
  });

  factory SessionApiModel.fromJson(Map<String, dynamic> json) =>
      _$SessionApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionApiModelToJson(this);

  // From entity to model
  factory SessionApiModel.fromEntity(SessionEntity entity) {
    return SessionApiModel(
      id: entity.id,
      mentorId: entity.mentorId,
      mentor: Mentor(
        name: entity.mentorName,
        email: entity.mentorEmail,
      ),
      title: entity.title,
      description: entity.description,
      date: entity.date,
      startTime: entity.startTime,
      endTime: entity.endTime,
      isOngoing: entity.isOngoing,
      attendesSigned: entity.attendesSigned,
      noOfAttendesSigned: entity.noOfAttendesSigned,
      maxNumberOfAttendesTaking: entity.maxNumberOfAttendesTaking,
    );
  }

  // From model to entity
  static SessionEntity toEntity(SessionApiModel session) {
    return SessionEntity(
      id: session.id,
      mentorId: session.mentorId,
      mentorName: session.mentor.name,
      mentorEmail: session.mentor.email,
      title: session.title,
      description: session.description,
      date: session.date,
      startTime: session.startTime,
      endTime: session.endTime,
      isOngoing: session.isOngoing,
      attendesSigned: session.attendesSigned,
      noOfAttendesSigned: session.noOfAttendesSigned,
      maxNumberOfAttendesTaking: session.maxNumberOfAttendesTaking,
    );
  }
}
