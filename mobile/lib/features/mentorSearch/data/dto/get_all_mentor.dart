import 'package:app/features/mentor/data/model/mentor_api_model.dart';
import 'package:app/features/mentorSearch/data/model/mentor_search_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_mentor.g.dart';

@JsonSerializable()
class GetAllMentorsDTO {
  final bool success;
  final String message;
  final List<MentorSearchApiModel> mentors;

  GetAllMentorsDTO({
    required this.success,
    required this.message,
    required this.mentors,
  });

  factory GetAllMentorsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllMentorsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllMentorsDTOToJson(this);
}
