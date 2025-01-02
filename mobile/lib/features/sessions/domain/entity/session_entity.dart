// This class represents your entity, you need to define it based on your needs
class SessionEntity {
  final String? id;
  final String mentorId;
  final String mentorName;
  final String mentorEmail;
  final String title;
  final String description;
  final DateTime date;
  final String startTime;
  final String endTime;
  final bool isOngoing;
  final List<Map<String, String>> attendesSigned;
  final int noOfAttendesSigned;
  final int maxNumberOfAttendesTaking;

  SessionEntity({
    this.id,
    required this.mentorId,
    required this.mentorName,
    required this.mentorEmail,
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

  factory SessionEntity.fromJson(Map<String, dynamic> json) => SessionEntity(
        id: json['_id'],
        mentorId: json['mentorId'],
        mentorName: json['mentor']['name'],
        mentorEmail: json['mentor']['email'],
        title: json['title'],
        description: json['description'],
        date: DateTime.parse(json['date']),
        startTime: json['startTime'],
        endTime: json['endTime'],
        isOngoing: json['isOngoing'],
        attendesSigned: List<Map<String, String>>.from(json['attendesSigned']
            .map((x) => {"email": x['email'].toString()})),
        noOfAttendesSigned: json['noOfAttendesSigned'],
        maxNumberOfAttendesTaking: json['maxNumberOfAttendesTaking'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "mentorId": mentorId,
        "mentor": {"name": mentorName, "email": mentorEmail},
        "title": title,
        "description": description,
        "date": {"$date": date.toIso8601String()},
        "startTime": startTime,
        "endTime": endTime,
        "isOngoing": isOngoing,
        "attendesSigned": attendesSigned,
        "noOfAttendesSigned": noOfAttendesSigned,
        "maxNumberOfAttendesTaking": maxNumberOfAttendesTaking,
      };
}
