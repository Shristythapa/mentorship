class MentorEntity {
  final String? mentorId;
  final String userName;
  final String email;
  final String password;
  final String firstName; 
  final String lastName; 
  final String dateOfBirth;
  final String address; 
  final List<String> skills; 
  
  MentorEntity({
    this.mentorId,
    required this.userName,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.address,
    required this.skills,
  });

  factory MentorEntity.fromJson(Map<String, dynamic> json) => MentorEntity(
        mentorId: json['mentorId'],
        userName: json['userName'],
        email: json['email'],
        password: json['password'],
        firstName: json['firstName'], 
        lastName: json['lastName'], 
        dateOfBirth: json['dateOfBirth'], 
        address: json['address'], 
        skills: List<String>.from(json['skills']), 
      );

  Map<String, dynamic> toJson() => {
        "mentorId": mentorId,
        "userName": userName,
        "email": email,
        "password": password,
        "firstName": firstName, 
        "lastName": lastName, 
        "dateOfBirth": dateOfBirth,
        "address": address,
        "skills": skills, 
      };

  @override
  String toString() {
    return 'MentorEntity(mentorId: $mentorId, userName: $userName, email: $email, password: $password,  firstName: $firstName, lastName: $lastName, dateOfBirth: $dateOfBirth, address: $address, skills: $skills)';
  }
}
