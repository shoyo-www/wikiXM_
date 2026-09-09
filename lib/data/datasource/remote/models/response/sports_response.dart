import 'dart:convert';

SportSectionResponse sportSectionResponseFromJson(String str) =>
    SportSectionResponse.fromJson(json.decode(str));

class SportSectionResponse {
  final bool? success;
  final String? message;
  final Data? data;
  final dynamic error;

  SportSectionResponse({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory SportSectionResponse.fromJson(Map<String, dynamic> json) =>
      SportSectionResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : Data.fromJson(json["data"]),
        error: json["error"],
      );
}

class Data {
  final bool? hasContent;
  final SportsData? widgets;

  Data({
    this.hasContent,
    this.widgets,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    hasContent: json["has_content"],
    widgets: json["widgets"] == null
        ? null
        : SportsData.fromJson(json["widgets"]),
  );
}

class SportsData {
  final SportsBrief? sportsBrief;
  final TopStory? topStory;
  final History? history;
  final CommunitySpotlight? communitySpotlight;
  final TeamHubs? teamHubs;
  final UpcomingGames? upcomingGames;
  final SupportingSportsBusinesses? supportingSportsBusinesses;
  final RecentActivity? recentActivity;
  final TopContributors? topContributors;
  final FanDiscussions? fanDiscussions;
  final FanPredictions? fanPredictions;

  SportsData({
    this.sportsBrief,
    this.topStory,
    this.history,
    this.communitySpotlight,
    this.teamHubs,
    this.upcomingGames,
    this.supportingSportsBusinesses,
    this.recentActivity,
    this.topContributors,
    this.fanDiscussions,
    this.fanPredictions,
  });

  factory SportsData.fromJson(Map<String, dynamic> json) => SportsData(
    sportsBrief: json["sports_brief"] == null
        ? null
        : SportsBrief.fromJson(json["sports_brief"]),
    topStory: json["top_story"] == null
        ? null
        : TopStory.fromJson(json["top_story"]),
    history: json["history"] == null
        ? null
        : History.fromJson(json["history"]),
    communitySpotlight: json["community_spotlight"] == null
        ? null
        : CommunitySpotlight.fromJson(
      json["community_spotlight"],
    ),
    teamHubs: json["team_hubs"] == null
        ? null
        : TeamHubs.fromJson(json["team_hubs"]),
    upcomingGames: json["upcoming_games"] == null
        ? null
        : UpcomingGames.fromJson(
      json["upcoming_games"],
    ),
    supportingSportsBusinesses:
    json["supporting_sports_businesses"] == null
        ? null
        : SupportingSportsBusinesses.fromJson(
      json["supporting_sports_businesses"],
    ),
    recentActivity: json["recent_activity"] == null
        ? null
        : RecentActivity.fromJson(
      json["recent_activity"],
    ),
    topContributors: json["top_contributors"] == null
      ? null
      : TopContributors.fromJson(
    json["top_contributors"],
  ),
    fanDiscussions: json["fan_discussions"] == null
        ? null
        : FanDiscussions.fromJson(
      json["fan_discussions"],
    ),

    fanPredictions: json["fan_predictions"] == null
        ? null
        : FanPredictions.fromJson(
      json["fan_predictions"],
    ),
  );
}
class FanDiscussions {
  final List<Discussion>? discussions;
  final String? viewAllUrl;
  final String? startDiscussionUrl;
  final bool? isFallback;
  final String? sourceTown;

  FanDiscussions({
    this.discussions,
    this.viewAllUrl,
    this.startDiscussionUrl,
    this.isFallback,
    this.sourceTown,
  });

  factory FanDiscussions.fromJson(Map<String, dynamic> json) =>
      FanDiscussions(
        discussions: json["discussions"] == null
            ? []
            : List<Discussion>.from(
          json["discussions"].map(
                (x) => Discussion.fromJson(x),
          ),
        ),
        viewAllUrl: json["view_all_url"],
        startDiscussionUrl: json["start_discussion_url"],
        isFallback: json["is_fallback"],
        sourceTown: json["source_town"],
      );
}

class Discussion {
  final String? id;
  final String? title;
  final int? commentsCount;
  final String? postedAt;
  final String? url;

  Discussion({
    this.id,
    this.title,
    this.commentsCount,
    this.postedAt,
    this.url,
  });

  factory Discussion.fromJson(Map<String, dynamic> json) =>
      Discussion(
        id: json["id"],
        title: json["title"],
        commentsCount: json["comments_count"],
        postedAt: json["posted_at"],
        url: json["url"],
      );
}

class FanPredictions {
  final List<Prediction>? predictions;
  final int? total;
  final String? viewAllUrl;

  FanPredictions({
    this.predictions,
    this.total,
    this.viewAllUrl,
  });

  factory FanPredictions.fromJson(Map<String, dynamic> json) =>
      FanPredictions(
        predictions: json["predictions"] == null
            ? []
            : List<Prediction>.from(
          json["predictions"].map(
                (x) => Prediction.fromJson(x),
          ),
        ),
        total: json["total"],
        viewAllUrl: json["view_all_url"],
      );
}

class Prediction {
  Prediction();

  factory Prediction.fromJson(Map<String, dynamic> json) =>
      Prediction();
}

class TopContributors {
  final String? title;
  final String? subtitle;
  final String? town;
  final List<TopContributor>? items;
  final String? viewAllUrl;

  TopContributors({
    this.title,
    this.subtitle,
    this.town,
    this.items,
    this.viewAllUrl,
  });

  factory TopContributors.fromJson(Map<String, dynamic> json) =>
      TopContributors(
        title: json["title"],
        subtitle: json["subtitle"],
        town: json["town"],
        items: json["items"] == null
            ? []
            : List<TopContributor>.from(
          json["items"].map(
                (x) => TopContributor.fromJson(x),
          ),
        ),
        viewAllUrl: json["view_all_url"],
      );
}

class TopContributor {
  final int? id;
  final String? name;
  final String? profileImage;

  TopContributor({
    this.id,
    this.name,
    this.profileImage,
  });

  factory TopContributor.fromJson(Map<String, dynamic> json) =>
      TopContributor(
        id: json["id"],
        name: json["name"],
        profileImage: json["profile_image"],
      );
}


class CommunitySpotlight {
  final String? town;
  final String? state;
  final List<Athlete>? athletes;
  final String? title;
  final String? subtitle;
  final String? howItWorksUrl;
  final String? nominationsUrl;
  final String? nominationsLabel;

  CommunitySpotlight({
    this.town,
    this.state,
    this.athletes,
    this.title,
    this.subtitle,
    this.howItWorksUrl,
    this.nominationsUrl,
    this.nominationsLabel,
  });

  factory CommunitySpotlight.fromJson(
      Map<String, dynamic> json,
      ) =>
      CommunitySpotlight(
        town: json["town"],
        state: json["state"],
        athletes: json["athletes"] == null
            ? []
            : List<Athlete>.from(
          json["athletes"].map(
                (x) => Athlete.fromJson(x),
          ),
        ),
        title: json["title"],
        subtitle: json["subtitle"],
        howItWorksUrl: json["how_it_works_url"],
        nominationsUrl: json["nominations_url"],
        nominationsLabel: json["nominations_label"],
      );
}

class Athlete {
  final String? name;
  final String? sport;
  final String? imageUrl;
  final String? sourceUrl;
  final String? achievement;
  final String? classLevel;
  final String? imageQuery;
  final String? officialAward;
  final String? schoolOrTeam;

  Athlete({
    this.name,
    this.sport,
    this.imageUrl,
    this.sourceUrl,
    this.achievement,
    this.classLevel,
    this.imageQuery,
    this.officialAward,
    this.schoolOrTeam,
  });

  factory Athlete.fromJson(Map<String, dynamic> json) =>
      Athlete(
        name: json["name"],
        sport: json["sport"],
        imageUrl: json["image_url"],
        sourceUrl: json["source_url"],
        achievement: json["achievement"],
        classLevel: json["class_level"],
        imageQuery: json["image_query"],
        officialAward: json["official_award"],
        schoolOrTeam: json["school_or_team"],
      );
}


// ============================================================
// HISTORY
// ============================================================

class History {
  final String? town;
  final String? state;
  final String? title;
  final String? country;
  final dynamic message;
  final String? subtitle;
  final List<Timeline>? timeline;
  final bool? hasHistory;

  History({
    this.town,
    this.state,
    this.title,
    this.country,
    this.message,
    this.subtitle,
    this.timeline,
    this.hasHistory,
  });

  factory History.fromJson(Map<String, dynamic> json) =>
      History(
        town: json["town"],
        state: json["state"],
        title: json["title"],
        country: json["country"],
        message: json["message"],
        subtitle: json["subtitle"],
        timeline: json["timeline"] == null
            ? []
            : List<Timeline>.from(
          json["timeline"].map(
                (x) => Timeline.fromJson(x),
          ),
        ),
        hasHistory: json["has_history"],
      );
}

class Timeline {
  final int? year;
  final String? sport;
  final String? title;
  final List<String>? sources;
  final String? confidence;
  final String? description;
  final String? imageUrl;
  final String? imageQuery;

  Timeline({
    this.year,
    this.sport,
    this.title,
    this.sources,
    this.confidence,
    this.description,
    this.imageUrl,
    this.imageQuery,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) =>
      Timeline(
        year: json["year"],
        sport: json["sport"],
        title: json["title"],
        sources: json["sources"] == null
            ? []
            : List<String>.from(
          json["sources"].map(
                (x) => x.toString(),
          ),
        ),
        confidence: json["confidence"],
        description: json["description"],
        imageUrl: json["image_url"],
        imageQuery: json["image_query"],
      );
}


// ============================================================
// RECENT ACTIVITY
// ============================================================

class RecentActivity {
  final String? title;
  final List<Item>? items;
  final int? total;
  final String? viewAllUrl;

  RecentActivity({
    this.title,
    this.items,
    this.total,
    this.viewAllUrl,
  });

  factory RecentActivity.fromJson(Map<String, dynamic> json) =>
      RecentActivity(
        title: json["title"],
        items: json["items"] == null
            ? []
            : List<Item>.from(
          json["items"].map(
                (x) => Item.fromJson(x),
          ),
        ),
        total: json["total"],
        viewAllUrl: json["view_all_url"],
      );
}

class Item {
  final String? key;
  final String? label;
  final int? count;

  Item({
    this.key,
    this.label,
    this.count,
  });

  factory Item.fromJson(Map<String, dynamic> json) =>
      Item(
        key: json["key"],
        label: json["label"],
        count: json["count"],
      );
}


// ============================================================
// SPORTS BRIEF
// ============================================================

class SportsBrief {
  final List<String>? sources;
  final String? summary;
  final String? headline;
  final List<String>? highlights;

  SportsBrief({
    this.sources,
    this.summary,
    this.headline,
    this.highlights,
  });

  factory SportsBrief.fromJson(Map<String, dynamic> json) =>
      SportsBrief(
        sources: json["sources"] == null
            ? []
            : List<String>.from(
          json["sources"].map(
                (x) => x.toString(),
          ),
        ),
        summary: json["summary"],
        headline: json["headline"],
        highlights: json["highlights"] == null
            ? []
            : List<String>.from(
          json["highlights"].map(
                (x) => x.toString(),
          ),
        ),
      );
}


// ============================================================
// SUPPORTING SPORTS BUSINESSES
// ============================================================

class SupportingSportsBusinesses {
  final List<Business>? businesses;
  final bool? isFallback;
  final String? sourceTown;

  SupportingSportsBusinesses({
    this.businesses,
    this.isFallback,
    this.sourceTown,
  });

  factory SupportingSportsBusinesses.fromJson(
      Map<String, dynamic> json,
      ) =>
      SupportingSportsBusinesses(
        businesses: json["businesses"] == null
            ? []
            : List<Business>.from(
          json["businesses"].map(
                (x) => Business.fromJson(x),
          ),
        ),
        isFallback: json["is_fallback"],
        sourceTown: json["source_town"],
      );
}

class Business {
  final int? id;
  final int? locationId;
  final String? name;
  final String? category;
  final String? description;
  final String? imageUrl;
  final String? address;
  final String? website;
  final String? phone;
  final bool? supportsYouthSports;
  final String? verificationStatus;

  Business({
    this.id,
    this.locationId,
    this.name,
    this.category,
    this.description,
    this.imageUrl,
    this.address,
    this.website,
    this.phone,
    this.supportsYouthSports,
    this.verificationStatus,
  });

  factory Business.fromJson(Map<String, dynamic> json) =>
      Business(
        id: json["id"],
        locationId: json["location_id"],
        name: json["name"],
        category: json["category"],
        description: json["description"],
        imageUrl: json["image_url"],
        address: json["address"],
        website: json["website"],
        phone: json["phone"],
        supportsYouthSports:
        json["supports_youth_sports"],
        verificationStatus:
        json["verification_status"],
      );
}


// ============================================================
// TEAM HUBS
// ============================================================

class TeamHubs {
  final List<Sport>? sports;
  final List<String>? sources;
  final bool? isFallback;
  final String? sourceTown;

  TeamHubs({
    this.sports,
    this.sources,
    this.isFallback,
    this.sourceTown,
  });

  factory TeamHubs.fromJson(
      Map<String, dynamic> json,
      ) =>
      TeamHubs(
        sports: json["sports"] == null
            ? []
            : List<Sport>.from(
          json["sports"].map(
                (x) => Sport.fromJson(x),
          ),
        ),
        sources: json["sources"] == null
            ? []
            : List<String>.from(
          json["sources"].map(
                (x) => x.toString(),
          ),
        ),
        isFallback: json["is_fallback"],
        sourceTown: json["source_town"],
      );
}

class Sport {
  final int? id;
  final int? sportId;
  final int? schoolId;
  final String? sport;
  final String? teamName;
  final String? mascot;
  final String? organization;
  final String? organizationType;
  final String? gender;
  final String? level;
  final String? season;
  final String? description;
  final int? wins;
  final int? losses;
  final String? record;
  final String? logoUrl;
  final String? sourceUrl;

  Sport({
    this.id,
    this.sportId,
    this.schoolId,
    this.sport,
    this.teamName,
    this.mascot,
    this.organization,
    this.organizationType,
    this.gender,
    this.level,
    this.season,
    this.description,
    this.wins,
    this.losses,
    this.record,
    this.logoUrl,
    this.sourceUrl,
  });

  factory Sport.fromJson(
      Map<String, dynamic> json,
      ) =>
      Sport(
        id: json["id"],
        sportId: json["sport_id"],
        schoolId: json["school_id"],
        sport: json["sport"],
        teamName: json["team_name"],
        mascot: json["mascot"],
        organization: json["organization"],
        organizationType:
        json["organization_type"],
        gender: json["gender"],
        level: json["level"],
        season: json["season"],
        description: json["description"],
        wins: json["wins"],
        losses: json["losses"],
        record: json["record"],
        logoUrl: json["logo_url"],
        sourceUrl: json["source_url"],
      );
}


// ============================================================
// TOP STORY
// ============================================================

class TopStory {
  final int? id;
  final String? title;
  final String? summary;
  final String? imageUrl;
  final String? imageQuery;
  final String? storyUrl;
  final String? sport;
  final int? year;
  final String? publishedAt;
  final String? reporterName;
  final int? totalComments;
  final int? totalViews;
  final int? totalLikes;
  final List<String>? sources;

  TopStory({
    this.id,
    this.title,
    this.summary,
    this.imageUrl,
    this.imageQuery,
    this.storyUrl,
    this.sport,
    this.year,
    this.publishedAt,
    this.reporterName,
    this.totalComments,
    this.totalViews,
    this.totalLikes,
    this.sources,
  });

  factory TopStory.fromJson(
      Map<String, dynamic> json,
      ) =>
      TopStory(
        id: json["id"],
        title: json["title"],
        summary: json["summary"],
        imageUrl: json["image_url"],
        imageQuery: json["image_query"],
        storyUrl: json["story_url"],
        sport: json["sport"],
        year: json["year"],
        publishedAt: json["published_at"],
        reporterName: json["reporter_name"],
        totalComments: json["total_comments"],
        totalViews: json["total_views"],
        totalLikes: json["total_likes"],
        sources: json["sources"] == null
            ? []
            : List<String>.from(
          json["sources"].map(
                (x) => x.toString(),
          ),
        ),
      );
}


// ============================================================
// UPCOMING GAMES
// ============================================================

class UpcomingGames {
  final List<Game>? games;
  final bool? isFallback;
  final String? sourceTown;

  UpcomingGames({
    this.games,
    this.isFallback,
    this.sourceTown,
  });

  factory UpcomingGames.fromJson(
      Map<String, dynamic> json,
      ) =>
      UpcomingGames(
        games: json["games"] == null
            ? []
            : List<Game>.from(
          json["games"].map(
                (x) => Game.fromJson(x),
          ),
        ),
        isFallback: json["is_fallback"],
        sourceTown: json["source_town"],
      );
}

class Game {
  final int? id;
  final int? schoolSportsTeamId;
  final String? school;
  final String? sport;
  final String? opponent;
  final String? startsAt;
  final String? date;
  final String? time;
  final String? venue;
  final String? homeAway;
  final dynamic ticketUrl;
  final String? sourceUrl;
  final int? teamScore;
  final int? opponentScore;
  final String? logoUrl;

  Game({
    this.id,
    this.schoolSportsTeamId,
    this.school,
    this.sport,
    this.opponent,
    this.startsAt,
    this.date,
    this.time,
    this.venue,
    this.homeAway,
    this.ticketUrl,
    this.sourceUrl,
    this.teamScore,
    this.opponentScore,
    this.logoUrl,
  });

  factory Game.fromJson(
      Map<String, dynamic> json,
      ) =>
      Game(
        id: json["id"],
        schoolSportsTeamId:
        json["school_sports_team_id"],
        school: json["school"],
        sport: json["sport"],
        opponent: json["opponent"],
        startsAt: json["starts_at"],
        date: json["date"],
        time: json["time"],
        venue: json["venue"],
        homeAway: json["home_away"],
        ticketUrl: json["ticket_url"],
        sourceUrl: json["source_url"],
        teamScore: json["team_score"],
        opponentScore: json["opponent_score"],
        logoUrl: json["logo_url"],
      );
}