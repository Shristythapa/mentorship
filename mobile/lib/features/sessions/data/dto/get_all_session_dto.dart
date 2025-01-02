import 'package:app/features/sessions/data/model/session_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_session_dto.g.dart';

@JsonSerializable()
class GetAllSessionDTO {
  final bool success;
  final int count;
  final List<SessionApiModel> sessions;

  GetAllSessionDTO({
    required this.success,
    required this.count,
    required this.sessions,
  });

  factory GetAllSessionDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllSessionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllSessionDTOToJson(this);
}
