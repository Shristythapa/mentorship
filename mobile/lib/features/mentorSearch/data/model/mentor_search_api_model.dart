import 'package:app/features/mentorSearch/domain/entity/mentor_search_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mentor_search_api_model.g.dart';

@JsonSerializable()
class MentorSearchApiModel {
  @JsonKey(name: '_id')
  final String id;
  final MentorProfileInformation mentorProfileInformation;
  final String name;
  final String email;
  final String password;
  final String profileUrl;
  @JsonKey(name: '__v')
  final int v;

  MentorSearchApiModel({
    required this.id,
    required this.mentorProfileInformation,
    required this.name,
    required this.email,
    required this.password,
    required this.profileUrl,
    required this.v,
  });

  static MentorSearchEntity toEntity(
      MentorSearchApiModel mentorSearchApiModel) {
    return MentorSearchEntity(
        id: mentorSearchApiModel.id,
        name: mentorSearchApiModel.name,
        email: mentorSearchApiModel.email,
        firstName: mentorSearchApiModel.mentorProfileInformation.firstName,
        lastName: mentorSearchApiModel.mentorProfileInformation.lastName,
        address: mentorSearchApiModel.mentorProfileInformation.address,
        skills: mentorSearchApiModel.mentorProfileInformation.skills,
        profileUrl: mentorSearchApiModel.profileUrl);
  }

  factory MentorSearchApiModel.fromJson(Map<String, dynamic> json) =>
      _$MentorSearchApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$MentorSearchApiModelToJson(this);
}

@JsonSerializable()
class MentorProfileInformation {
  final String firstName;
  final String lastName;
  final String address;
  final List<String> skills;

  MentorProfileInformation({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.skills,
  });

  factory MentorProfileInformation.fromJson(Map<String, dynamic> json) =>
      _$MentorProfileInformationFromJson(json);

  Map<String, dynamic> toJson() => _$MentorProfileInformationToJson(this);
}
