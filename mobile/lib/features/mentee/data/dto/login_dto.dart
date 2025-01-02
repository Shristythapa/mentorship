import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class LoginMenteeDTO {
  final bool success;
  final String? token;
  final String message;

  LoginMenteeDTO({required this.success, this.token, required this.message});

  factory LoginMenteeDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginMenteeDTOFromJson(json);
  Map<String, dynamic> toJson() => _$LoginMenteeDTOToJson(this);
}
