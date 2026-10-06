import 'dart:convert';

CreateItemDraft createItemDraftFromJson(String str) => CreateItemDraft.fromJson(json.decode(str));

class CreateItemDraft {
  final bool? success;
  final String? message;
  final DraftData? data;

  CreateItemDraft({
    this.success,
    this.message,
    this.data,
  });

  factory CreateItemDraft.fromJson(Map<String, dynamic> json) => CreateItemDraft(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : DraftData.fromJson(json["data"]),
  );

}

class DraftData {
  final int? itemId;

  DraftData({this.itemId});

  factory DraftData.fromJson(Map<String, dynamic> json) => DraftData(
    itemId: json["itemId"],
  );
}
