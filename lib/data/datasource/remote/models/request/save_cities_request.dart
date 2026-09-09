import 'dart:convert';

String loginRequestToJson(SaveCitiesRequest data) => json.encode(data.toJson());


class SaveCitiesRequest {
  final int primaryTown;
  final List<int> secondaryTowns;

  SaveCitiesRequest({
    required this.primaryTown,
    required this.secondaryTowns,
  });

  Map<String, dynamic> toJson() {
    return {
      "primary_town": primaryTown,
      "secondary_towns": secondaryTowns,
    };
  }
}