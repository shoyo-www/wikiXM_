import 'dart:convert';

ImageUploadResponse imageUploadResponseFromJson(String str) => ImageUploadResponse.fromJson(json.decode(str));


class ImageUploadResponse {
  final bool? success;
  final String? message;
  final ImageData? data;

  ImageUploadResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ImageUploadResponse.fromJson(Map<String, dynamic> json) => ImageUploadResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : ImageData.fromJson(json["data"]),
  );
}

class ImageData {
  final int? photoId;
  final int? itemId;
  final String? url;
  final int? webpurifyStatus;

  ImageData({
    this.photoId,
    this.itemId,
    this.url,
    this.webpurifyStatus,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
    photoId: json["photoId"],
    itemId: json["itemId"],
    url: json["url"],
    webpurifyStatus: json["webpurifyStatus"],
  );

}
