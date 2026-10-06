import 'dart:convert';
String noParamsRequest(NoParamsRequest data) => json.encode(data.toJson());

class NoParamsRequest {
  NoParamsRequest();
  Map<String, dynamic> toJson() => {};
}
