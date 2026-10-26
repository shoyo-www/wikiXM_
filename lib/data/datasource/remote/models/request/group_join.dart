import 'dart:convert';
String groupRequestToJson(GroupJoinRequest data) => json.encode(data.toJson());

class GroupJoinRequest {
  int cityId;
  int groupId;

  GroupJoinRequest({
    required this.cityId,
    required this.groupId,
  });


  Map<String, dynamic> toJson() => {
    "city_id": cityId,
    "group_id": groupId,
  };
}
