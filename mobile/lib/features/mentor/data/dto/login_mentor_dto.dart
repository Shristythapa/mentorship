import 'package:json_annotation/json_annotation.dart';

part 'login_mentor_dto.g.dart';

@JsonSerializable()
class LoginMentorDTO {
  final bool success;
  final String token;
  final String message;

  LoginMentorDTO(
      {required this.success, required this.token, required this.message});

  factory LoginMentorDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginMentorDTOFromJson(json);
  Map<String, dynamic> toJson() => _$LoginMentorDTOToJson(this);
}
