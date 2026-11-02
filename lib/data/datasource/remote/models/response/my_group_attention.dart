import 'dart:convert';

MyGroupAttentionResponse myGroupAttentionResponseFromJson(String str) => MyGroupAttentionResponse.fromJson(json.decode(str));

class MyGroupAttentionResponse {
  final bool? success;
  final String? message;
  final MyGroupAttentionData? data;

  MyGroupAttentionResponse({
    this.success,
    this.message,
    this.data,
  });

  factory MyGroupAttentionResponse.fromJson(Map<String, dynamic> json) => MyGroupAttentionResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : MyGroupAttentionData.fromJson(json["data"]),
  );
}

class MyGroupAttentionData {
  final Map<String, int>? counts;
  final int? total;
  final List<AttentionItem>? items;
  final AttentionPagination? pagination;

  MyGroupAttentionData({
    this.counts,
    this.total,
    this.items,
    this.pagination,
  });

  factory MyGroupAttentionData.fromJson(Map<String, dynamic> json) => MyGroupAttentionData(
    counts: json["counts"] == null ? {} : {for (final e in (json["counts"] as Map).entries) e.key.toString(): (e.value as num?)?.toInt() ?? 0},
    total: json["total"],
    items: json["items"] == null ? [] : List<AttentionItem>.from(json["items"].map((x) => AttentionItem.fromJson(x))),
    pagination: json["pagination"] == null ? null : AttentionPagination.fromJson(json["pagination"]),
  );
}

class AttentionItem {
  final int? id;
  final String? type;
  final bool? isBanned;
  final String? name;
  final String? subject;
  final String? body;
  final String? status;
  final List<AttentionHistory>? history;
  final int? groupId;
  final String? createdAt;

  AttentionItem({
    this.id,
    this.type,
    this.isBanned,
    this.name,
    this.subject,
    this.body,
    this.status,
    this.history,
    this.groupId,
    this.createdAt,
  });

  factory AttentionItem.fromJson(Map<String, dynamic> json) => AttentionItem(
    id: json["id"],
    type: json["type"],
    isBanned: json["is_banned"],
    name: json["name"],
    subject: json["subject"],
    body: json["body"],
    status: json["status"],
    history: json["history"] == null ? [] : List<AttentionHistory>.from(json["history"].map((x) => AttentionHistory.fromJson(x))),
    groupId: json["group_id"],
    createdAt: json["created_at"],
  );
}

class AttentionHistory {
  final String? action;
  final int? userId;
  final List<AttentionQuestion>? questions;
  final String? createdAt;

  AttentionHistory({
    this.action,
    this.userId,
    this.questions,
    this.createdAt,
  });

  factory AttentionHistory.fromJson(Map<String, dynamic> json) => AttentionHistory(
    action: json["action"],
    userId: json["user_id"],
    questions: json["questions"] == null ? [] : List<AttentionQuestion>.from(json["questions"].map((x) => AttentionQuestion.fromJson(x))),
    createdAt: json["created_at"],
  );
}

class AttentionQuestion {
  final String? question;
  final String? answer;
  final String? questionId;

  AttentionQuestion({
    this.question,
    this.answer,
    this.questionId,
  });

  factory AttentionQuestion.fromJson(Map<String, dynamic> json) => AttentionQuestion(
    question: json["question"],
    answer: json["answer"],
    questionId: json["question_id"],
  );
}

class AttentionPagination {
  final int? page;
  final bool? hasMore;

  AttentionPagination({
    this.page,
    this.hasMore,
  });

  factory AttentionPagination.fromJson(Map<String, dynamic> json) => AttentionPagination(
    page: json["page"],
    hasMore: json["has_more"],
  );
}
