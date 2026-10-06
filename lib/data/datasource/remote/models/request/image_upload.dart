import 'dart:convert';

String fileUploadRequestToJson(FileUploadRequest data) => json.encode(data.toJson());

class FileUploadRequest {
  final String filePath;

  const FileUploadRequest({
    required this.filePath,
  });

  Map<String, dynamic> toJson() => {
    'file': filePath,
  };
}