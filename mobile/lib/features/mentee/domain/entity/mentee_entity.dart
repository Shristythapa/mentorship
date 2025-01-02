class MenteeEntity {
  final String? menteeId;
  final String userName;
  final String email;
  final String password;

  MenteeEntity({
    this.menteeId,
    required this.userName,
    required this.email,
    required this.password,
  });

  factory MenteeEntity.fromJson(Map<String, dynamic> json) => MenteeEntity(
      menteeId: json["menteeId"],
      userName: json["userName"],
      email: json["email"],
      password: json["password"]);

  Map<String, dynamic> toJson() => {
        "menteeId": menteeId,
        "userName": userName,
        "email": email,
        "password": password
      };

  @override
  String toString() {
    return 'MenteeEntity(menteeId: $menteeId, userName: $userName, email: $email, password: $password)';
  }
}
