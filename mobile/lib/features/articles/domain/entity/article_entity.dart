class ArticleEntity {
  final String? id;
  final String mentorId;
  final String title;
  final String body;
  final String mentorName;
  final String mentorEmail;

  final String profileUrl;
  ArticleEntity(
      {this.id,
      required this.title,
      required this.body,
      required this.mentorId,
      required this.mentorName,
      required this.mentorEmail,
      required this.profileUrl});

        factory ArticleEntity.fromJson(Map<String, dynamic> json) {
    return ArticleEntity(
      id: json['_id'],
      title: json['title'],
      body: json['body'],
      mentorId: json['mentorId'],
      mentorName: json['mentorName'],
      mentorEmail: json['mentorEmail'],
      profileUrl: json['profileUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'body': body,
      'mentorId': mentorId,
      'mentorName': mentorName,
      'mentorEmail': mentorEmail,
      'profileUrl': profileUrl,
    };
  }
}
