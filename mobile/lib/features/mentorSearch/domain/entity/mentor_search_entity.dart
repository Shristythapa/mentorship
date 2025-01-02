import 'package:app/features/mentor/domain/entity/mentor_entity.dart';

class MentorSearchEntity {
  final String? id;
  final String name;
  final String email;
  final String firstName;
  final String lastName;

  final String address;
  final List<String> skills;
  final String profileUrl;

  MentorSearchEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.skills,
    required this.profileUrl,
  });
  factory MentorSearchEntity.fromJson(Map<String, dynamic> json) {
    return MentorSearchEntity(
      id: json['_id'] as String?, // Ensure id is nullable
      name: json['name'] as String? ??
          '', // Use null-aware operator and provide a default value
      email: json['email'] as String? ??
          '', // Use null-aware operator and provide a default value
      firstName: json['mentorProfileInformation']?['firstName'] as String? ??
          '', // Use null-aware operator and provide a default value
      lastName: json['mentorProfileInformation']?['lastName'] as String? ??
          '', // Use null-aware operator and provide a default value
      address: json['mentorProfileInformation']?['address'] as String? ??
          '', // Use null-aware operator and provide a default value
      skills: (json['skills'] as List<dynamic>?)
              ?.map((skill) => skill.toString())
              .toList() ??
          [], // Use null-aware operator and provide a default value
      profileUrl: json['profileUrl'] as String? ??
          '', // Use null-aware operator and provide a default value
    );
  }

  // Map<String, dynamic> toJson(){
  //   return{
  //     "_id": id,
  //     "name": name,
  //     "email": email,

  //   }
  // }
}
