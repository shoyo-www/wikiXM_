import 'dart:convert';

ActivityProfileResponse activityProfileResponseFromJson(String str) => ActivityProfileResponse.fromJson(json.decode(str));

class ActivityProfileResponse {
  final bool? success;
  final String? message;
  final ActivityProfileData? data;

  ActivityProfileResponse({this.success, this.message, this.data});

  factory ActivityProfileResponse.fromJson(Map<String, dynamic> json) => ActivityProfileResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : ActivityProfileData.fromJson(json["data"]),
  );
}

class ActivityProfileData {
  final ProfileUser? user;
  final bool? isOwner;
  final bool? canEdit;
  final bool? isPublic;
  final int? cityId;
  final String? detailUrl;
  final String? bio;
  final List<ProfileTab>? tabs;
  final List<ProfileActivity>? activities;
  final Map<String, SectionSchema>? sectionSchemas;
  final ProfilePrivacy? privacy;
  final ProfileStats? stats;
  final ProfileCommunity? community;

  ActivityProfileData({
    this.user,
    this.isOwner,
    this.canEdit,
    this.isPublic,
    this.cityId,
    this.detailUrl,
    this.bio,
    this.tabs,
    this.activities,
    this.sectionSchemas,
    this.privacy,
    this.stats,
    this.community,
  });

  factory ActivityProfileData.fromJson(Map<String, dynamic> json) => ActivityProfileData(
    user: json["user"] == null ? null : ProfileUser.fromJson(json["user"]),
    isOwner: json["is_owner"],
    canEdit: json["can_edit"],
    isPublic: json["is_public"],
    cityId: json["city_id"],
    detailUrl: json["detail_url"],
    bio: json["bio"],
    tabs: json["tabs"] == null ? [] : List<ProfileTab>.from(json["tabs"].map((x) => ProfileTab.fromJson(x))),
    activities: json["activities"] == null ? [] : List<ProfileActivity>.from(json["activities"].map((x) => ProfileActivity.fromJson(x))),
    sectionSchemas: json["section_schemas"] is Map ? {for (final e in (json["section_schemas"] as Map).entries) e.key.toString(): SectionSchema.fromJson(e.value)} : {},
    privacy: json["privacy"] == null ? null : ProfilePrivacy.fromJson(json["privacy"]),
    stats: json["stats"] == null ? null : ProfileStats.fromJson(json["stats"]),
    community: json["community"] == null ? null : ProfileCommunity.fromJson(json["community"]),
  );
}

class ProfileUser {
  final int? id;
  final String? name;
  final String? slug;
  final ProfileImage? image;

  ProfileUser({this.id, this.name, this.slug, this.image});

  factory ProfileUser.fromJson(Map<String, dynamic> json) => ProfileUser(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    image: json["image"] == null ? null : ProfileImage.fromJson(json["image"]),
  );
}

class ProfileImage {
  final String? url;
  final String? alt;
  final int? width;
  final int? height;

  ProfileImage({this.url, this.alt, this.width, this.height});

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
    url: json["url"],
    alt: json["alt"],
    width: json["width"],
    height: json["height"],
  );
}

class ProfileTab {
  final String? id;
  final String? label;
  final String? icon;

  ProfileTab({this.id, this.label, this.icon});

  factory ProfileTab.fromJson(Map<String, dynamic> json) => ProfileTab(
    id: json["id"],
    label: json["label"],
    icon: json["icon"],
  );
}

class ProfileActivity {
  final int? interestId;
  final String? slug;
  final String? name;
  final String? icon;
  final ProfileImage? image;
  final ProfileSections? sections;

  ProfileActivity({this.interestId, this.slug, this.name, this.icon, this.image, this.sections});

  factory ProfileActivity.fromJson(Map<String, dynamic> json) => ProfileActivity(
    interestId: json["interest_id"],
    slug: json["slug"],
    name: json["name"],
    icon: json["icon"],
    image: json["image"] == null ? null : ProfileImage.fromJson(json["image"]),
    sections: json["sections"] == null ? null : ProfileSections.fromJson(json["sections"]),
  );
}

class ProfileSections {
  final ProfileSection? skills;
  final ProfileSection? preferences;

  ProfileSections({this.skills, this.preferences});

  factory ProfileSections.fromJson(Map<String, dynamic> json) => ProfileSections(
    skills: json["skills"] == null ? null : ProfileSection.fromJson(json["skills"]),
    preferences: json["preferences"] == null ? null : ProfileSection.fromJson(json["preferences"]),
  );
}

class ProfileSection {
  final String? schemaId;
  final Map<String, dynamic>? values;
  final List<ProfileSummary>? summaries;

  ProfileSection({this.schemaId, this.values, this.summaries});

  factory ProfileSection.fromJson(Map<String, dynamic> json) => ProfileSection(
    schemaId: json["schema_id"],
    values: json["values"] is Map ? Map<String, dynamic>.from(json["values"]) : {},
    summaries: json["summaries"] == null ? [] : List<ProfileSummary>.from(json["summaries"].map((x) => ProfileSummary.fromJson(x))),
  );
}

class ProfileSummary {
  final String? name;
  final String? label;
  final String? kind;
  final String? icon;
  final String? text;
  final List<String>? items;
  final num? value;
  final num? max;

  ProfileSummary({this.name, this.label, this.kind, this.icon, this.text, this.items, this.value, this.max});

  factory ProfileSummary.fromJson(Map<String, dynamic> json) => ProfileSummary(
    name: json["name"],
    label: json["label"],
    kind: json["kind"],
    icon: json["icon"],
    text: json["text"],
    items: json["items"] == null ? [] : List<String>.from(json["items"].map((x) => x.toString())),
    value: json["value"],
    max: json["max"],
  );
}

class SectionSchema {
  final String? title;
  final String? intro;
  final String? detailsHeading;
  final String? saveLabel;
  final List<SchemaField>? fields;

  SectionSchema({this.title, this.intro, this.detailsHeading, this.saveLabel, this.fields});

  factory SectionSchema.fromJson(Map<String, dynamic> json) => SectionSchema(
    title: json["title"],
    intro: json["intro"],
    detailsHeading: json["details_heading"],
    saveLabel: json["save_label"],
    fields: json["fields"] == null ? [] : List<SchemaField>.from(json["fields"].map((x) => SchemaField.fromJson(x))),
  );
}

class SchemaField {
  final String? name;
  final String? label;
  final String? type;
  final String? display;
  final List<SchemaOption>? options;
  final num? min;
  final num? max;
  final num? step;
  final int? maxLength;
  final String? unit;
  final String? icon;
  final String? pair;
  final String? minimumField;
  final String? summaryLabel;

  SchemaField({
    this.name,
    this.label,
    this.type,
    this.display,
    this.options,
    this.min,
    this.max,
    this.step,
    this.maxLength,
    this.unit,
    this.icon,
    this.pair,
    this.minimumField,
    this.summaryLabel,
  });

  factory SchemaField.fromJson(Map<String, dynamic> json) => SchemaField(
    name: json["name"],
    label: json["label"],
    type: json["type"],
    display: json["display"],
    options: json["options"] == null ? [] : List<SchemaOption>.from(json["options"].map((x) => SchemaOption.fromJson(x))),
    min: json["min"],
    max: json["max"],
    step: json["step"],
    maxLength: json["max_length"],
    unit: json["unit"],
    icon: json["icon"],
    pair: json["pair"],
    minimumField: json["minimum_field"],
    summaryLabel: json["summary_label"],
  );
}

class SchemaOption {
  final dynamic value;
  final String? label;

  SchemaOption({this.value, this.label});

  factory SchemaOption.fromJson(Map<String, dynamic> json) => SchemaOption(
    value: json["value"],
    label: json["label"],
  );
}

class ProfilePrivacy {
  final String? visibility;
  final List<PrivacyOption>? options;

  ProfilePrivacy({this.visibility, this.options});

  factory ProfilePrivacy.fromJson(Map<String, dynamic> json) => ProfilePrivacy(
    visibility: json["visibility"],
    options: json["options"] == null ? [] : List<PrivacyOption>.from(json["options"].map((x) => PrivacyOption.fromJson(x))),
  );
}

class PrivacyOption {
  final String? value;
  final String? label;

  PrivacyOption({this.value, this.label});

  factory PrivacyOption.fromJson(Map<String, dynamic> json) => PrivacyOption(
    value: json["value"],
    label: json["label"],
  );
}

class ProfileStats {
  final int? organizedActivities;

  ProfileStats({this.organizedActivities});

  factory ProfileStats.fromJson(Map<String, dynamic> json) => ProfileStats(
    organizedActivities: json["organized_activities"],
  );
}

class ProfileCommunity {
  final int? total;
  final List<CommunityItem>? items;

  ProfileCommunity({this.total, this.items});

  factory ProfileCommunity.fromJson(Map<String, dynamic> json) => ProfileCommunity(
    total: json["total"],
    items: json["items"] == null ? [] : List<CommunityItem>.from(json["items"].map((x) => CommunityItem.fromJson(x))),
  );
}

class CommunityItem {
  final int? id;
  final String? name;

  CommunityItem({this.id, this.name});

  factory CommunityItem.fromJson(Map<String, dynamic> json) => CommunityItem(
    id: json["id"],
    name: json["name"],
  );
}
