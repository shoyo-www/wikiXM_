// To parse this JSON data, do
//
//     final communityFeedResponse = communityFeedResponseFromJson(jsonString);

import 'dart:convert';

CommunityFeedResponse communityFeedResponseFromJson(String str) => CommunityFeedResponse.fromJson(json.decode(str));

String communityFeedResponseToJson(CommunityFeedResponse data) => json.encode(data.toJson());

class CommunityFeedResponse {
  final bool? success;
  final String? message;
  final FeedData? data;

  CommunityFeedResponse({
    this.success,
    this.message,
    this.data,
  });

  factory CommunityFeedResponse.fromJson(Map<String, dynamic> json) => CommunityFeedResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : FeedData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class FeedData {
  final DataEngagement? engagement;
  final Conversations? conversations;
  final Memories? memories;
  final LocalIntelligence? localIntelligence;
  final LevelIntelligence? levelIntelligence;
  final RightRail? rightRail;

  FeedData({
    this.engagement,
    this.conversations,
    this.memories,
    this.localIntelligence,
    this.levelIntelligence,
    this.rightRail,
  });

  factory FeedData.fromJson(Map<String, dynamic> json) => FeedData(
    engagement: json["engagement"] == null ? null : DataEngagement.fromJson(json["engagement"]),
    conversations: json["conversations"] == null ? null : Conversations.fromJson(json["conversations"]),
    memories: json["memories"] == null ? null : Memories.fromJson(json["memories"]),
    localIntelligence: json["local_intelligence"] == null ? null : LocalIntelligence.fromJson(json["local_intelligence"]),
    levelIntelligence: json["level_intelligence"] == null ? null : LevelIntelligence.fromJson(json["level_intelligence"]),
    rightRail: json["right_rail"] == null ? null : RightRail.fromJson(json["right_rail"]),
  );

  Map<String, dynamic> toJson() => {
    "engagement": engagement?.toJson(),
    "conversations": conversations?.toJson(),
    "memories": memories?.toJson(),
    "local_intelligence": localIntelligence?.toJson(),
    "level_intelligence": levelIntelligence?.toJson(),
    "right_rail": rightRail?.toJson(),
  };
}

class Conversations {
  final TopStory? topStory;
  final TopicStages? topicStages;

  Conversations({
    this.topStory,
    this.topicStages,
  });

  factory Conversations.fromJson(Map<String, dynamic> json) => Conversations(
    topStory: json["top_story"] == null ? null : TopStory.fromJson(json["top_story"]),
    topicStages: json["topic_stages"] == null ? null : TopicStages.fromJson(json["topic_stages"]),
  );

  Map<String, dynamic> toJson() => {
    "top_story": topStory?.toJson(),
    "topic_stages": topicStages?.toJson(),
  };
}

class TopStory {
  final int? id;
  final String? title;
  final String? excerpt;
  final String? image;
  final TopStoryCategory? category;
  final String? author;
  final DateTime? publishedAt;
  final String? publishedLabel;
  final int? viewsCount;
  final int? commentsCount;
  final int? likesCount;
  final int? sharesCount;
  final String? url;
  final String? level;

  TopStory({
    this.id,
    this.title,
    this.excerpt,
    this.image,
    this.category,
    this.author,
    this.publishedAt,
    this.publishedLabel,
    this.viewsCount,
    this.commentsCount,
    this.likesCount,
    this.sharesCount,
    this.url,
    this.level,
  });

  factory TopStory.fromJson(Map<String, dynamic> json) => TopStory(
    id: json["id"],
    title: json["title"],
    excerpt: json["excerpt"],
    image: json["image"],
    category: json["category"] == null ? null : TopStoryCategory.fromJson(json["category"]),
    author: json["author"],
    publishedAt: json["published_at"] == null ? null : DateTime.parse(json["published_at"]),
    publishedLabel: json["published_label"],
    viewsCount: json["views_count"],
    commentsCount: json["comments_count"],
    likesCount: json["likes_count"],
    sharesCount: json["shares_count"],
    url: json["url"],
    level: json["level"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "excerpt": excerpt,
    "image": image,
    "category": category?.toJson(),
    "author": author,
    "published_at": publishedAt?.toIso8601String(),
    "published_label": publishedLabel,
    "views_count": viewsCount,
    "comments_count": commentsCount,
    "likes_count": likesCount,
    "shares_count": sharesCount,
    "url": url,
    "level": level,
  };
}

class TopStoryCategory {
  final int? id;
  final String? name;
  final String? slug;

  TopStoryCategory({
    this.id,
    this.name,
    this.slug,
  });

  factory TopStoryCategory.fromJson(Map<String, dynamic> json) => TopStoryCategory(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
  };
}

class TopicStages {
  final List<Definition>? definitions;
  final List<Topic>? topics;

  TopicStages({
    this.definitions,
    this.topics,
  });

  factory TopicStages.fromJson(Map<String, dynamic> json) => TopicStages(
    definitions: json["definitions"] == null ? [] : List<Definition>.from(json["definitions"]!.map((x) => Definition.fromJson(x))),
    topics: json["topics"] == null ? [] : List<Topic>.from(json["topics"]!.map((x) => Topic.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "definitions": definitions == null ? [] : List<dynamic>.from(definitions!.map((x) => x.toJson())),
    "topics": topics == null ? [] : List<dynamic>.from(topics!.map((x) => x.toJson())),
  };
}

class Definition {
  final String? key;
  final String? label;
  final int? step;
  final int? progress;

  Definition({
    this.key,
    this.label,
    this.step,
    this.progress,
  });

  factory Definition.fromJson(Map<String, dynamic> json) => Definition(
    key: json["key"],
    label: json["label"],
    step: json["step"],
    progress: json["progress"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "label": label,
    "step": step,
    "progress": progress,
  };
}

class Topic {
  final int? id;
  final String? title;
  final String? excerpt;
  final dynamic category;
  final Definition? stage;
  final int? commentsCount;
  final int? supportCount;
  final DateTime? updatedAt;
  final String? url;

  Topic({
    this.id,
    this.title,
    this.excerpt,
    this.category,
    this.stage,
    this.commentsCount,
    this.supportCount,
    this.updatedAt,
    this.url,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
    id: json["id"],
    title: json["title"],
    excerpt: json["excerpt"],
    category: json["category"],
    stage: json["stage"] == null ? null : Definition.fromJson(json["stage"]),
    commentsCount: json["comments_count"],
    supportCount: json["support_count"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "excerpt": excerpt,
    "category": category,
    "stage": stage?.toJson(),
    "comments_count": commentsCount,
    "support_count": supportCount,
    "updated_at": updatedAt?.toIso8601String(),
    "url": url,
  };
}

class DataEngagement {
  final Section? section;
  final List<Representative>? representatives;
  final List<CategoryElement>? categories;
  final String? townHallUrl;

  DataEngagement({
    this.section,
    this.representatives,
    this.categories,
    this.townHallUrl,
  });

  factory DataEngagement.fromJson(Map<String, dynamic> json) => DataEngagement(
    section: json["section"] == null ? null : Section.fromJson(json["section"]),
    representatives: json["representatives"] == null ? [] : List<Representative>.from(json["representatives"]!.map((x) => Representative.fromJson(x))),
    categories: json["categories"] == null ? [] : List<CategoryElement>.from(json["categories"]!.map((x) => CategoryElement.fromJson(x))),
    townHallUrl: json["town_hall_url"],
  );

  Map<String, dynamic> toJson() => {
    "section": section?.toJson(),
    "representatives": representatives == null ? [] : List<dynamic>.from(representatives!.map((x) => x.toJson())),
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "town_hall_url": townHallUrl,
  };
}

class CategoryElement {
  final int? id;
  final String? name;
  final String? slug;
  final dynamic parentId;
  final String? icon;

  CategoryElement({
    this.id,
    this.name,
    this.slug,
    this.parentId,
    this.icon,
  });

  factory CategoryElement.fromJson(Map<String, dynamic> json) => CategoryElement(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    parentId: json["parent_id"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "parent_id": parentId,
    "icon": icon,
  };
}

class Representative {
  final int? id;
  final String? name;
  final String? role;
  final dynamic district;
  final String? image;
  final String? website;
  final String? profileUrl;
  final bool? isClaimed;
  final String? accountStatus;
  final String? accountStatusIcon;
  final int? taggedTopicCount;
  final String? email;
  final bool? canMessage;
  final bool? canEmail;
  final bool? canFollow;
  final int? engagementRating;

  Representative({
    this.id,
    this.name,
    this.role,
    this.district,
    this.image,
    this.website,
    this.profileUrl,
    this.isClaimed,
    this.accountStatus,
    this.accountStatusIcon,
    this.taggedTopicCount,
    this.email,
    this.canMessage,
    this.canEmail,
    this.canFollow,
    this.engagementRating,
  });

  factory Representative.fromJson(Map<String, dynamic> json) => Representative(
    id: json["id"],
    name: json["name"],
    role: json["role"],
    district: json["district"],
    image: json["image"],
    website: json["website"],
    profileUrl: json["profile_url"],
    isClaimed: json["is_claimed"],
    accountStatus: json["account_status"],
    accountStatusIcon: json["account_status_icon"],
    taggedTopicCount: json["tagged_topic_count"],
    email: json["email"],
    canMessage: json["can_message"],
    canEmail: json["can_email"],
    canFollow: json["can_follow"],
    engagementRating: json["engagement_rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "role": role,
    "district": district,
    "image": image,
    "website": website,
    "profile_url": profileUrl,
    "is_claimed": isClaimed,
    "account_status": accountStatus,
    "account_status_icon": accountStatusIcon,
    "tagged_topic_count": taggedTopicCount,
    "email": email,
    "can_message": canMessage,
    "can_email": canEmail,
    "can_follow": canFollow,
    "engagement_rating": engagementRating,
  };
}

class Section {
  final String? title;
  final Actions? actions;
  final Topics? topics;
  final SectionEngagement? engagement;
  final AskRepresentative? askRepresentative;
  final ViewBackground? viewBackground;
  final DefaultAvatar? defaultAvatar;
  final EmptyMessages? emptyMessages;

  Section({
    this.title,
    this.actions,
    this.topics,
    this.engagement,
    this.askRepresentative,
    this.viewBackground,
    this.defaultAvatar,
    this.emptyMessages,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    title: json["title"],
    actions: json["actions"] == null ? null : Actions.fromJson(json["actions"]),
    topics: json["topics"] == null ? null : Topics.fromJson(json["topics"]),
    engagement: json["engagement"] == null ? null : SectionEngagement.fromJson(json["engagement"]),
    askRepresentative: json["ask_representative"] == null ? null : AskRepresentative.fromJson(json["ask_representative"]),
    viewBackground: json["view_background"] == null ? null : ViewBackground.fromJson(json["view_background"]),
    defaultAvatar: json["default_avatar"] == null ? null : DefaultAvatar.fromJson(json["default_avatar"]),
    emptyMessages: json["empty_messages"] == null ? null : EmptyMessages.fromJson(json["empty_messages"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "actions": actions?.toJson(),
    "topics": topics?.toJson(),
    "engagement": engagement?.toJson(),
    "ask_representative": askRepresentative?.toJson(),
    "view_background": viewBackground?.toJson(),
    "default_avatar": defaultAvatar?.toJson(),
    "empty_messages": emptyMessages?.toJson(),
  };
}

class Actions {
  final ViewBackground? message;
  final ViewBackground? email;
  final ViewBackground? follow;

  Actions({
    this.message,
    this.email,
    this.follow,
  });

  factory Actions.fromJson(Map<String, dynamic> json) => Actions(
    message: json["message"] == null ? null : ViewBackground.fromJson(json["message"]),
    email: json["email"] == null ? null : ViewBackground.fromJson(json["email"]),
    follow: json["follow"] == null ? null : ViewBackground.fromJson(json["follow"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message?.toJson(),
    "email": email?.toJson(),
    "follow": follow?.toJson(),
  };
}

class ViewBackground {
  final String? label;
  final String? icon;

  ViewBackground({
    this.label,
    this.icon,
  });

  factory ViewBackground.fromJson(Map<String, dynamic> json) => ViewBackground(
    label: json["label"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "icon": icon,
  };
}

class AskRepresentative {
  final String? icon;
  final String? title;
  final String? description;
  final ViewBackground? button;

  AskRepresentative({
    this.icon,
    this.title,
    this.description,
    this.button,
  });

  factory AskRepresentative.fromJson(Map<String, dynamic> json) => AskRepresentative(
    icon: json["icon"],
    title: json["title"],
    description: json["description"],
    button: json["button"] == null ? null : ViewBackground.fromJson(json["button"]),
  );

  Map<String, dynamic> toJson() => {
    "icon": icon,
    "title": title,
    "description": description,
    "button": button?.toJson(),
  };
}

class DefaultAvatar {
  final String? icon;

  DefaultAvatar({
    this.icon,
  });

  factory DefaultAvatar.fromJson(Map<String, dynamic> json) => DefaultAvatar(
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "icon": icon,
  };
}

class EmptyMessages {
  final String? unavailable;
  final String? noRepresentatives;

  EmptyMessages({
    this.unavailable,
    this.noRepresentatives,
  });

  factory EmptyMessages.fromJson(Map<String, dynamic> json) => EmptyMessages(
    unavailable: json["unavailable"],
    noRepresentatives: json["no_representatives"],
  );

  Map<String, dynamic> toJson() => {
    "unavailable": unavailable,
    "no_representatives": noRepresentatives,
  };
}

class SectionEngagement {
  final String? label;
  final int? maxRating;
  final String? starCharacter;

  SectionEngagement({
    this.label,
    this.maxRating,
    this.starCharacter,
  });

  factory SectionEngagement.fromJson(Map<String, dynamic> json) => SectionEngagement(
    label: json["label"],
    maxRating: json["max_rating"],
    starCharacter: json["star_character"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "max_rating": maxRating,
    "star_character": starCharacter,
  };
}

class Topics {
  final String? label;
  final String? singular;
  final String? plural;

  Topics({
    this.label,
    this.singular,
    this.plural,
  });

  factory Topics.fromJson(Map<String, dynamic> json) => Topics(
    label: json["label"],
    singular: json["singular"],
    plural: json["plural"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "singular": singular,
    "plural": plural,
  };
}

class LevelIntelligence {
  final List<Level>? levels;

  LevelIntelligence({
    this.levels,
  });

  factory LevelIntelligence.fromJson(Map<String, dynamic> json) => LevelIntelligence(
    levels: json["levels"] == null ? [] : List<Level>.from(json["levels"]!.map((x) => Level.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "levels": levels == null ? [] : List<dynamic>.from(levels!.map((x) => x.toJson())),
  };
}

class Level {
  final String? key;
  final String? label;
  final String? name;
  final List<TopStory>? items;

  Level({
    this.key,
    this.label,
    this.name,
    this.items,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
    key: json["key"],
    label: json["label"],
    name: json["name"],
    items: json["items"] == null ? [] : List<TopStory>.from(json["items"]!.map((x) => TopStory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "label": label,
    "name": name,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class LocalIntelligence {
  final List<CategoryElement>? categories;
  final dynamic selectedCategoryId;
  final List<TopStory>? items;
  final bool? hasMore;
  final String? viewAllUrl;

  LocalIntelligence({
    this.categories,
    this.selectedCategoryId,
    this.items,
    this.hasMore,
    this.viewAllUrl,
  });

  factory LocalIntelligence.fromJson(Map<String, dynamic> json) => LocalIntelligence(
    categories: json["categories"] == null ? [] : List<CategoryElement>.from(json["categories"]!.map((x) => CategoryElement.fromJson(x))),
    selectedCategoryId: json["selected_category_id"],
    items: json["items"] == null ? [] : List<TopStory>.from(json["items"]!.map((x) => TopStory.fromJson(x))),
    hasMore: json["has_more"],
    viewAllUrl: json["view_all_url"],
  );

  Map<String, dynamic> toJson() => {
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "selected_category_id": selectedCategoryId,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "has_more": hasMore,
    "view_all_url": viewAllUrl,
  };
}

class Memories {
  final List<MemoriesItem>? items;
  final int? total;
  final String? viewAllUrl;
  final Upload? upload;

  Memories({
    this.items,
    this.total,
    this.viewAllUrl,
    this.upload,
  });

  factory Memories.fromJson(Map<String, dynamic> json) => Memories(
    items: json["items"] == null ? [] : List<MemoriesItem>.from(json["items"]!.map((x) => MemoriesItem.fromJson(x))),
    total: json["total"],
    viewAllUrl: json["view_all_url"],
    upload: json["upload"] == null ? null : Upload.fromJson(json["upload"]),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "total": total,
    "view_all_url": viewAllUrl,
    "upload": upload?.toJson(),
  };
}

class MemoriesItem {
  final int? id;
  final String? image;
  final String? caption;
  final String? timeline;
  final String? section;
  final String? contributor;
  final int? reactionsCount;
  final int? commentsCount;
  final DateTime? createdAt;

  MemoriesItem({
    this.id,
    this.image,
    this.caption,
    this.timeline,
    this.section,
    this.contributor,
    this.reactionsCount,
    this.commentsCount,
    this.createdAt,
  });

  factory MemoriesItem.fromJson(Map<String, dynamic> json) => MemoriesItem(
    id: json["id"],
    image: json["image"],
    caption: json["caption"],
    timeline: json["timeline"],
    section: json["section"],
    contributor: json["contributor"],
    reactionsCount: json["reactions_count"],
    commentsCount: json["comments_count"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "caption": caption,
    "timeline": timeline,
    "section": section,
    "contributor": contributor,
    "reactions_count": reactionsCount,
    "comments_count": commentsCount,
    "created_at": createdAt?.toIso8601String(),
  };
}

class Upload {
  final List<String>? acceptedTypes;
  final int? maxSizeMb;
  final int? captionMin;
  final int? captionMax;
  final int? yearMin;
  final int? yearMax;

  Upload({
    this.acceptedTypes,
    this.maxSizeMb,
    this.captionMin,
    this.captionMax,
    this.yearMin,
    this.yearMax,
  });

  factory Upload.fromJson(Map<String, dynamic> json) => Upload(
    acceptedTypes: json["accepted_types"] == null ? [] : List<String>.from(json["accepted_types"]!.map((x) => x)),
    maxSizeMb: json["max_size_mb"],
    captionMin: json["caption_min"],
    captionMax: json["caption_max"],
    yearMin: json["year_min"],
    yearMax: json["year_max"],
  );

  Map<String, dynamic> toJson() => {
    "accepted_types": acceptedTypes == null ? [] : List<dynamic>.from(acceptedTypes!.map((x) => x)),
    "max_size_mb": maxSizeMb,
    "caption_min": captionMin,
    "caption_max": captionMax,
    "year_min": yearMin,
    "year_max": yearMax,
  };
}

class RightRail {
  final Config? config;
  final RightRailMorningBrief? morningBrief;
  final RightRailMeetings? meetings;
  final RightRailCommunityQuestion? communityQuestion;
  final RightRailSponsor? sponsor;
  final RightRailAiAssistant? aiAssistant;

  RightRail({
    this.config,
    this.morningBrief,
    this.meetings,
    this.communityQuestion,
    this.sponsor,
    this.aiAssistant,
  });

  factory RightRail.fromJson(Map<String, dynamic> json) => RightRail(
    config: json["config"] == null ? null : Config.fromJson(json["config"]),
    morningBrief: json["morning_brief"] == null ? null : RightRailMorningBrief.fromJson(json["morning_brief"]),
    meetings: json["meetings"] == null ? null : RightRailMeetings.fromJson(json["meetings"]),
    communityQuestion: json["community_question"] == null ? null : RightRailCommunityQuestion.fromJson(json["community_question"]),
    sponsor: json["sponsor"] == null ? null : RightRailSponsor.fromJson(json["sponsor"]),
    aiAssistant: json["ai_assistant"] == null ? null : RightRailAiAssistant.fromJson(json["ai_assistant"]),
  );

  Map<String, dynamic> toJson() => {
    "config": config?.toJson(),
    "morning_brief": morningBrief?.toJson(),
    "meetings": meetings?.toJson(),
    "community_question": communityQuestion?.toJson(),
    "sponsor": sponsor?.toJson(),
    "ai_assistant": aiAssistant?.toJson(),
  };
}

class RightRailAiAssistant {
  final List<Suggestion>? suggestions;

  RightRailAiAssistant({
    this.suggestions,
  });

  factory RightRailAiAssistant.fromJson(Map<String, dynamic> json) => RightRailAiAssistant(
    suggestions: json["suggestions"] == null ? [] : List<Suggestion>.from(json["suggestions"]!.map((x) => Suggestion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "suggestions": suggestions == null ? [] : List<dynamic>.from(suggestions!.map((x) => x.toJson())),
  };
}

class Suggestion {
  final String? label;
  final String? question;

  Suggestion({
    this.label,
    this.question,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) => Suggestion(
    label: json["label"],
    question: json["question"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "question": question,
  };
}

class RightRailCommunityQuestion {
  final int? topicId;
  final String? question;
  final String? scope;
  final int? totalVotes;
  final String? discussionUrl;

  RightRailCommunityQuestion({
    this.topicId,
    this.question,
    this.scope,
    this.totalVotes,
    this.discussionUrl,
  });

  factory RightRailCommunityQuestion.fromJson(Map<String, dynamic> json) => RightRailCommunityQuestion(
    topicId: json["topic_id"],
    question: json["question"],
    scope: json["scope"],
    totalVotes: json["total_votes"],
    discussionUrl: json["discussion_url"],
  );

  Map<String, dynamic> toJson() => {
    "topic_id": topicId,
    "question": question,
    "scope": scope,
    "total_votes": totalVotes,
    "discussion_url": discussionUrl,
  };
}

class Config {
  final ConfigMorningBrief? morningBrief;
  final ConfigMeetings? meetings;
  final ConfigCommunityQuestion? communityQuestion;
  final ConfigSponsor? sponsor;
  final ConfigAiAssistant? aiAssistant;

  Config({
    this.morningBrief,
    this.meetings,
    this.communityQuestion,
    this.sponsor,
    this.aiAssistant,
  });

  factory Config.fromJson(Map<String, dynamic> json) => Config(
    morningBrief: json["morning_brief"] == null ? null : ConfigMorningBrief.fromJson(json["morning_brief"]),
    meetings: json["meetings"] == null ? null : ConfigMeetings.fromJson(json["meetings"]),
    communityQuestion: json["community_question"] == null ? null : ConfigCommunityQuestion.fromJson(json["community_question"]),
    sponsor: json["sponsor"] == null ? null : ConfigSponsor.fromJson(json["sponsor"]),
    aiAssistant: json["ai_assistant"] == null ? null : ConfigAiAssistant.fromJson(json["ai_assistant"]),
  );

  Map<String, dynamic> toJson() => {
    "morning_brief": morningBrief?.toJson(),
    "meetings": meetings?.toJson(),
    "community_question": communityQuestion?.toJson(),
    "sponsor": sponsor?.toJson(),
    "ai_assistant": aiAssistant?.toJson(),
  };
}

class ConfigAiAssistant {
  final String? title;
  final String? betaLabel;
  final String? icon;
  final String? inputPlaceholder;
  final String? sendLabel;
  final String? sendIcon;
  final String? sourcesLabel;
  final String? moreQuestionsLabel;
  final String? fewerQuestionsLabel;
  final int? maxQuestionsCollapsed;
  final int? maxQuestionsExpanded;

  ConfigAiAssistant({
    this.title,
    this.betaLabel,
    this.icon,
    this.inputPlaceholder,
    this.sendLabel,
    this.sendIcon,
    this.sourcesLabel,
    this.moreQuestionsLabel,
    this.fewerQuestionsLabel,
    this.maxQuestionsCollapsed,
    this.maxQuestionsExpanded,
  });

  factory ConfigAiAssistant.fromJson(Map<String, dynamic> json) => ConfigAiAssistant(
    title: json["title"],
    betaLabel: json["beta_label"],
    icon: json["icon"],
    inputPlaceholder: json["input_placeholder"],
    sendLabel: json["send_label"],
    sendIcon: json["send_icon"],
    sourcesLabel: json["sources_label"],
    moreQuestionsLabel: json["more_questions_label"],
    fewerQuestionsLabel: json["fewer_questions_label"],
    maxQuestionsCollapsed: json["max_questions_collapsed"],
    maxQuestionsExpanded: json["max_questions_expanded"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "beta_label": betaLabel,
    "icon": icon,
    "input_placeholder": inputPlaceholder,
    "send_label": sendLabel,
    "send_icon": sendIcon,
    "sources_label": sourcesLabel,
    "more_questions_label": moreQuestionsLabel,
    "fewer_questions_label": fewerQuestionsLabel,
    "max_questions_collapsed": maxQuestionsCollapsed,
    "max_questions_expanded": maxQuestionsExpanded,
  };
}

class ConfigCommunityQuestion {
  final String? title;
  final String? questionMark;
  final String? voteLabel;
  final String? voteIcon;
  final String? discussionLabel;
  final String? discussionIcon;
  final String? votesLabel;
  final String? emptyMessage;

  ConfigCommunityQuestion({
    this.title,
    this.questionMark,
    this.voteLabel,
    this.voteIcon,
    this.discussionLabel,
    this.discussionIcon,
    this.votesLabel,
    this.emptyMessage,
  });

  factory ConfigCommunityQuestion.fromJson(Map<String, dynamic> json) => ConfigCommunityQuestion(
    title: json["title"],
    questionMark: json["question_mark"],
    voteLabel: json["vote_label"],
    voteIcon: json["vote_icon"],
    discussionLabel: json["discussion_label"],
    discussionIcon: json["discussion_icon"],
    votesLabel: json["votes_label"],
    emptyMessage: json["empty_message"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "question_mark": questionMark,
    "vote_label": voteLabel,
    "vote_icon": voteIcon,
    "discussion_label": discussionLabel,
    "discussion_icon": discussionIcon,
    "votes_label": votesLabel,
    "empty_message": emptyMessage,
  };
}

class ConfigMeetings {
  final String? title;
  final String? defaultIcon;
  final String? watchLiveLabel;
  final ViewBackground? viewAll;
  final String? emptyMessage;
  final String? emptyDescription;

  ConfigMeetings({
    this.title,
    this.defaultIcon,
    this.watchLiveLabel,
    this.viewAll,
    this.emptyMessage,
    this.emptyDescription,
  });

  factory ConfigMeetings.fromJson(Map<String, dynamic> json) => ConfigMeetings(
    title: json["title"],
    defaultIcon: json["default_icon"],
    watchLiveLabel: json["watch_live_label"],
    viewAll: json["view_all"] == null ? null : ViewBackground.fromJson(json["view_all"]),
    emptyMessage: json["empty_message"],
    emptyDescription: json["empty_description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "default_icon": defaultIcon,
    "watch_live_label": watchLiveLabel,
    "view_all": viewAll?.toJson(),
    "empty_message": emptyMessage,
    "empty_description": emptyDescription,
  };
}

class ConfigMorningBrief {
  final String? title;
  final String? icon;
  final String? updatedLabel;
  final String? itemIcon;
  final ViewBackground? viewAll;
  final String? emptyMessage;

  ConfigMorningBrief({
    this.title,
    this.icon,
    this.updatedLabel,
    this.itemIcon,
    this.viewAll,
    this.emptyMessage,
  });

  factory ConfigMorningBrief.fromJson(Map<String, dynamic> json) => ConfigMorningBrief(
    title: json["title"],
    icon: json["icon"],
    updatedLabel: json["updated_label"],
    itemIcon: json["item_icon"],
    viewAll: json["view_all"] == null ? null : ViewBackground.fromJson(json["view_all"]),
    emptyMessage: json["empty_message"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "icon": icon,
    "updated_label": updatedLabel,
    "item_icon": itemIcon,
    "view_all": viewAll?.toJson(),
    "empty_message": emptyMessage,
  };
}

class ConfigSponsor {
  final String? title;
  final String? sponsoredLabel;
  final String? impactLabel;
  final String? impactIcon;

  ConfigSponsor({
    this.title,
    this.sponsoredLabel,
    this.impactLabel,
    this.impactIcon,
  });

  factory ConfigSponsor.fromJson(Map<String, dynamic> json) => ConfigSponsor(
    title: json["title"],
    sponsoredLabel: json["sponsored_label"],
    impactLabel: json["impact_label"],
    impactIcon: json["impact_icon"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "sponsored_label": sponsoredLabel,
    "impact_label": impactLabel,
    "impact_icon": impactIcon,
  };
}

class RightRailMeetings {
  final List<MeetingsItem>? items;
  final String? viewCalendarUrl;

  RightRailMeetings({
    this.items,
    this.viewCalendarUrl,
  });

  factory RightRailMeetings.fromJson(Map<String, dynamic> json) => RightRailMeetings(
    items: json["items"] == null ? [] : List<MeetingsItem>.from(json["items"]!.map((x) => MeetingsItem.fromJson(x))),
    viewCalendarUrl: json["view_calendar_url"],
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "view_calendar_url": viewCalendarUrl,
  };
}

class MeetingsItem {
  final int? id;
  final String? title;
  final DateTime? startsAt;
  final String? startsLabel;
  final String? url;

  MeetingsItem({
    this.id,
    this.title,
    this.startsAt,
    this.startsLabel,
    this.url,
  });

  factory MeetingsItem.fromJson(Map<String, dynamic> json) => MeetingsItem(
    id: json["id"],
    title: json["title"],
    startsAt: json["starts_at"] == null ? null : DateTime.parse(json["starts_at"]),
    startsLabel: json["starts_label"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "starts_at": startsAt?.toIso8601String(),
    "starts_label": startsLabel,
    "url": url,
  };
}

class RightRailMorningBrief {
  final DateTime? updatedAt;
  final String? updatedLabel;
  final List<MorningBriefItem>? items;
  final String? readFullUrl;

  RightRailMorningBrief({
    this.updatedAt,
    this.updatedLabel,
    this.items,
    this.readFullUrl,
  });

  factory RightRailMorningBrief.fromJson(Map<String, dynamic> json) => RightRailMorningBrief(
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    updatedLabel: json["updated_label"],
    items: json["items"] == null ? [] : List<MorningBriefItem>.from(json["items"]!.map((x) => MorningBriefItem.fromJson(x))),
    readFullUrl: json["read_full_url"],
  );

  Map<String, dynamic> toJson() => {
    "updated_at": updatedAt?.toIso8601String(),
    "updated_label": updatedLabel,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "read_full_url": readFullUrl,
  };
}

class MorningBriefItem {
  final int? id;
  final String? title;
  final String? scope;
  final String? url;

  MorningBriefItem({
    this.id,
    this.title,
    this.scope,
    this.url,
  });

  factory MorningBriefItem.fromJson(Map<String, dynamic> json) => MorningBriefItem(
    id: json["id"],
    title: json["title"],
    scope: json["scope"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "scope": scope,
    "url": url,
  };
}

class RightRailSponsor {
  final String? name;
  final dynamic logo;
  final String? description;
  final String? sponsoredLabel;
  final List<Program>? programs;
  final Impact? impact;

  RightRailSponsor({
    this.name,
    this.logo,
    this.description,
    this.sponsoredLabel,
    this.programs,
    this.impact,
  });

  factory RightRailSponsor.fromJson(Map<String, dynamic> json) => RightRailSponsor(
    name: json["name"],
    logo: json["logo"],
    description: json["description"],
    sponsoredLabel: json["sponsored_label"],
    programs: json["programs"] == null ? [] : List<Program>.from(json["programs"]!.map((x) => Program.fromJson(x))),
    impact: json["impact"] == null ? null : Impact.fromJson(json["impact"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "logo": logo,
    "description": description,
    "sponsored_label": sponsoredLabel,
    "programs": programs == null ? [] : List<dynamic>.from(programs!.map((x) => x.toJson())),
    "impact": impact?.toJson(),
  };
}

class Impact {
  final String? label;
  final String? url;
  final String? icon;

  Impact({
    this.label,
    this.url,
    this.icon,
  });

  factory Impact.fromJson(Map<String, dynamic> json) => Impact(
    label: json["label"],
    url: json["url"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "url": url,
    "icon": icon,
  };
}

class Program {
  final int? id;
  final String? title;
  final String? detail;
  final String? icon;

  Program({
    this.id,
    this.title,
    this.detail,
    this.icon,
  });

  factory Program.fromJson(Map<String, dynamic> json) => Program(
    id: json["id"],
    title: json["title"],
    detail: json["detail"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "detail": detail,
    "icon": icon,
  };
}
