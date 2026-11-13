import 'dart:convert';

GroupSettingsResponse groupSettingsResponseFromJson(String str) => GroupSettingsResponse.fromJson(json.decode(str));

String groupSettingsResponseToJson(GroupSettingsResponse data) => json.encode(data.toJson());

class GroupSettingsResponse {
  final bool? success;
  final String? message;
  final Data? data;

  GroupSettingsResponse({
    this.success,
    this.message,
    this.data,
  });

  factory GroupSettingsResponse.fromJson(Map<String, dynamic> json) => GroupSettingsResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final int? schemaVersion;
  final String? defaultSection;
  final String? notice;
  final List<Section>? sections;
  final Defaults? defaults;
  final Defaults? values;
  final bool? hasSavedPreferences;

  Data({
    this.schemaVersion,
    this.defaultSection,
    this.notice,
    this.sections,
    this.defaults,
    this.values,
    this.hasSavedPreferences,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    schemaVersion: json["schema_version"],
    defaultSection: json["default_section"],
    notice: json["notice"],
    sections: json["sections"] == null ? [] : List<Section>.from(json["sections"]!.map((x) => Section.fromJson(x))),
    defaults: json["defaults"] == null ? null : Defaults.fromJson(json["defaults"]),
    values: json["values"] == null ? null : Defaults.fromJson(json["values"]),
    hasSavedPreferences: json["has_saved_preferences"],
  );

  Map<String, dynamic> toJson() => {
    "schema_version": schemaVersion,
    "default_section": defaultSection,
    "notice": notice,
    "sections": sections == null ? [] : List<dynamic>.from(sections!.map((x) => x.toJson())),
    "defaults": defaults?.toJson(),
    "values": values?.toJson(),
    "has_saved_preferences": hasSavedPreferences,
  };
}

class Defaults {
  final Notifications? notifications;
  final Privacy? privacy;
  final Participation? participation;
  final Content? content;
  final Ai? ai;

  Defaults({
    this.notifications,
    this.privacy,
    this.participation,
    this.content,
    this.ai,
  });

  factory Defaults.fromJson(Map<String, dynamic> json) => Defaults(
    notifications: json["notifications"] == null ? null : Notifications.fromJson(json["notifications"]),
    privacy: json["privacy"] == null ? null : Privacy.fromJson(json["privacy"]),
    participation: json["participation"] == null ? null : Participation.fromJson(json["participation"]),
    content: json["content"] == null ? null : Content.fromJson(json["content"]),
    ai: json["ai"] == null ? null : Ai.fromJson(json["ai"]),
  );

  Map<String, dynamic> toJson() => {
    "notifications": notifications?.toJson(),
    "privacy": privacy?.toJson(),
    "participation": participation?.toJson(),
    "content": content?.toJson(),
    "ai": ai?.toJson(),
  };
}

class Ai {
  final bool? activityRecommendations;
  final bool? groupSuggestions;
  final bool? memberSuggestions;
  final bool? useActivityData;
  final bool? interestExpansion;

  Ai({
    this.activityRecommendations,
    this.groupSuggestions,
    this.memberSuggestions,
    this.useActivityData,
    this.interestExpansion,
  });

  factory Ai.fromJson(Map<String, dynamic> json) => Ai(
    activityRecommendations: json["activityRecommendations"],
    groupSuggestions: json["groupSuggestions"],
    memberSuggestions: json["memberSuggestions"],
    useActivityData: json["useActivityData"],
    interestExpansion: json["interestExpansion"],
  );

  Map<String, dynamic> toJson() => {
    "activityRecommendations": activityRecommendations,
    "groupSuggestions": groupSuggestions,
    "memberSuggestions": memberSuggestions,
    "useActivityData": useActivityData,
    "interestExpansion": interestExpansion,
  };
}

class Content {
  final List<String>? contentTypes;
  final String? sortOrder;

  Content({
    this.contentTypes,
    this.sortOrder,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    contentTypes: json["contentTypes"] == null ? [] : List<String>.from(json["contentTypes"]!.map((x) => x)),
    sortOrder: json["sortOrder"],
  );

  Map<String, dynamic> toJson() => {
    "contentTypes": contentTypes == null ? [] : List<dynamic>.from(contentTypes!.map((x) => x)),
    "sortOrder": sortOrder,
  };
}

class Notifications {
  final bool? postNotifications;
  final bool? activityInvites;
  final bool? activityReminders;
  final bool? directMessages;
  final bool? announcements;
  final bool? weeklyDigest;

  Notifications({
    this.postNotifications,
    this.activityInvites,
    this.activityReminders,
    this.directMessages,
    this.announcements,
    this.weeklyDigest,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
    postNotifications: json["postNotifications"],
    activityInvites: json["activityInvites"],
    activityReminders: json["activityReminders"],
    directMessages: json["directMessages"],
    announcements: json["announcements"],
    weeklyDigest: json["weeklyDigest"],
  );

  Map<String, dynamic> toJson() => {
    "postNotifications": postNotifications,
    "activityInvites": activityInvites,
    "activityReminders": activityReminders,
    "directMessages": directMessages,
    "announcements": announcements,
    "weeklyDigest": weeklyDigest,
  };
}

class Participation {
  final List<dynamic>? activityTypes;
  final String? skillLevel;

  Participation({
    this.activityTypes,
    this.skillLevel,
  });

  factory Participation.fromJson(Map<String, dynamic> json) => Participation(
    activityTypes: json["activityTypes"] == null ? [] : List<dynamic>.from(json["activityTypes"]!.map((x) => x)),
    skillLevel: json["skillLevel"],
  );

  Map<String, dynamic> toJson() => {
    "activityTypes": activityTypes == null ? [] : List<dynamic>.from(activityTypes!.map((x) => x)),
    "skillLevel": skillLevel,
  };
}

class Privacy {
  final String? profileVisibility;
  final String? participationVisibility;
  final String? showInMembers;
  final String? onlineStatus;

  Privacy({
    this.profileVisibility,
    this.participationVisibility,
    this.showInMembers,
    this.onlineStatus,
  });

  factory Privacy.fromJson(Map<String, dynamic> json) => Privacy(
    profileVisibility: json["profileVisibility"],
    participationVisibility: json["participationVisibility"],
    showInMembers: json["showInMembers"],
    onlineStatus: json["onlineStatus"],
  );

  Map<String, dynamic> toJson() => {
    "profileVisibility": profileVisibility,
    "participationVisibility": participationVisibility,
    "showInMembers": showInMembers,
    "onlineStatus": onlineStatus,
  };
}

class Section {
  final String? id;
  final String? label;
  final String? icon;
  final String? description;
  final String? kind;
  final String? title;
  final String? help;
  final String? quickTitle;
  final String? quickHelp;
  final List<QuickAction>? quickActions;
  final List<SectionField>? fields;
  final String? layout;
  final Footnote? footnote;
  final Summary? summary;
  final Capabilities? capabilities;

  Section({
    this.id,
    this.label,
    this.icon,
    this.description,
    this.kind,
    this.title,
    this.help,
    this.quickTitle,
    this.quickHelp,
    this.quickActions,
    this.fields,
    this.layout,
    this.footnote,
    this.summary,
    this.capabilities,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["id"],
    label: json["label"],
    icon: json["icon"],
    description: json["description"],
    kind: json["kind"],
    title: json["title"],
    help: json["help"],
    quickTitle: json["quick_title"],
    quickHelp: json["quick_help"],
    quickActions: json["quick_actions"] == null ? [] : List<QuickAction>.from(json["quick_actions"]!.map((x) => QuickAction.fromJson(x))),
    fields: json["fields"] == null ? [] : List<SectionField>.from(json["fields"]!.map((x) => SectionField.fromJson(x))),
    layout: json["layout"],
    footnote: json["footnote"] == null ? null : Footnote.fromJson(json["footnote"]),
    summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
    capabilities: json["capabilities"] == null ? null : Capabilities.fromJson(json["capabilities"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "icon": icon,
    "description": description,
    "kind": kind,
    "title": title,
    "help": help,
    "quick_title": quickTitle,
    "quick_help": quickHelp,
    "quick_actions": quickActions == null ? [] : List<dynamic>.from(quickActions!.map((x) => x.toJson())),
    "fields": fields == null ? [] : List<dynamic>.from(fields!.map((x) => x.toJson())),
    "layout": layout,
    "footnote": footnote?.toJson(),
    "summary": summary?.toJson(),
    "capabilities": capabilities?.toJson(),
  };
}

class Capabilities {
  final bool? search;
  final bool? block;
  final bool? unblock;

  Capabilities({
    this.search,
    this.block,
    this.unblock,
  });

  factory Capabilities.fromJson(Map<String, dynamic> json) => Capabilities(
    search: json["search"],
    block: json["block"],
    unblock: json["unblock"],
  );

  Map<String, dynamic> toJson() => {
    "search": search,
    "block": block,
    "unblock": unblock,
  };
}

class SectionField {
  final String? type;
  final String? name;
  final String? label;
  final String? help;
  final dynamic fieldDefault;
  final List<Option>? options;
  final String? layout;
  final List<FieldField>? fields;
  final int? maxLength;

  SectionField({
    this.type,
    this.name,
    this.label,
    this.help,
    this.fieldDefault,
    this.options,
    this.layout,
    this.fields,
    this.maxLength,
  });

  factory SectionField.fromJson(Map<String, dynamic> json) => SectionField(
    type: json["type"],
    name: json["name"],
    label: json["label"],
    help: json["help"],
    fieldDefault: json["default"],
    options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
    layout: json["layout"],
    fields: json["fields"] == null ? [] : List<FieldField>.from(json["fields"]!.map((x) => FieldField.fromJson(x))),
    maxLength: json["max_length"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "name": name,
    "label": label,
    "help": help,
    "default": fieldDefault,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
    "layout": layout,
    "fields": fields == null ? [] : List<dynamic>.from(fields!.map((x) => x.toJson())),
    "max_length": maxLength,
  };
}

class FieldField {
  final String? type;
  final String? name;
  final String? label;
  final String? help;
  final List<Option>? options;
  final String? fieldDefault;

  FieldField({
    this.type,
    this.name,
    this.label,
    this.help,
    this.options,
    this.fieldDefault,
  });

  factory FieldField.fromJson(Map<String, dynamic> json) => FieldField(
    type: json["type"],
    name: json["name"],
    label: json["label"],
    help: json["help"],
    options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
    fieldDefault: json["default"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "name": name,
    "label": label,
    "help": help,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
    "default": fieldDefault,
  };
}

class Option {
  final String? value;
  final String? label;

  Option({
    this.value,
    this.label,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    value: json["value"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "label": label,
  };
}

class Footnote {
  final String? icon;
  final String? text;
  final Action? action;

  Footnote({
    this.icon,
    this.text,
    this.action,
  });

  factory Footnote.fromJson(Map<String, dynamic> json) => Footnote(
    icon: json["icon"],
    text: json["text"],
    action: json["action"] == null ? null : Action.fromJson(json["action"]),
  );

  Map<String, dynamic> toJson() => {
    "icon": icon,
    "text": text,
    "action": action?.toJson(),
  };
}

class Action {
  final String? label;
  final String? type;

  Action({
    this.label,
    this.type,
  });

  factory Action.fromJson(Map<String, dynamic> json) => Action(
    label: json["label"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "type": type,
  };
}

class QuickAction {
  final String? section;
  final String? title;
  final String? description;
  final String? icon;

  QuickAction({
    this.section,
    this.title,
    this.description,
    this.icon,
  });

  factory QuickAction.fromJson(Map<String, dynamic> json) => QuickAction(
    section: json["section"],
    title: json["title"],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "section": section,
    "title": title,
    "description": description,
    "icon": icon,
  };
}

class Summary {
  final String? label;
  final String? icon;
  final String? format;
  final String? suffix;
  final String? field;
  final List<String>? fields;
  final String? onLabel;
  final String? offLabel;
  final String? text;

  Summary({
    this.label,
    this.icon,
    this.format,
    this.suffix,
    this.field,
    this.fields,
    this.onLabel,
    this.offLabel,
    this.text,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    label: json["label"],
    icon: json["icon"],
    format: json["format"],
    suffix: json["suffix"],
    field: json["field"],
    fields: json["fields"] == null ? [] : List<String>.from(json["fields"]!.map((x) => x)),
    onLabel: json["on_label"],
    offLabel: json["off_label"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "icon": icon,
    "format": format,
    "suffix": suffix,
    "field": field,
    "fields": fields == null ? [] : List<dynamic>.from(fields!.map((x) => x)),
    "on_label": onLabel,
    "off_label": offLabel,
    "text": text,
  };
}
