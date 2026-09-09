import 'dart:convert';

HomeMarketPlace homeMarketPlaceFromJson(String str) => HomeMarketPlace.fromJson(json.decode(str));

String homeMarketPlaceToJson(HomeMarketPlace data) => json.encode(data.toJson());

class HomeMarketPlace {
  final bool? success;
  final dynamic message;
  final HomeMarketData? data;

  HomeMarketPlace({
    this.success,
    this.message,
    this.data,
  });

  factory HomeMarketPlace.fromJson(Map<String, dynamic> json) => HomeMarketPlace(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : HomeMarketData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class HomeMarketData {
  final Games? games;
  final BusinessSpotlight? businessSpotlight;

  HomeMarketData({
    this.games,
    this.businessSpotlight,
  });

  factory HomeMarketData.fromJson(Map<String, dynamic> json) => HomeMarketData(
    games: json["games"] == null ? null : Games.fromJson(json["games"]),
    businessSpotlight: json["business_spotlight"] == null ? null : BusinessSpotlight.fromJson(json["business_spotlight"]),
  );

  Map<String, dynamic> toJson() => {
    "games": games?.toJson(),
    "business_spotlight": businessSpotlight?.toJson(),
  };
}

class BusinessSpotlight {
  final int? id;
  final String? name;
  final String? tagline;
  final String? description;
  final String? image;
  final String? logo;
  final int? townId;
  final int? stateId;
  final Button? button;

  BusinessSpotlight({
    this.id,
    this.name,
    this.tagline,
    this.description,
    this.image,
    this.logo,
    this.townId,
    this.stateId,
    this.button,
  });

  factory BusinessSpotlight.fromJson(Map<String, dynamic> json) => BusinessSpotlight(
    id: json["id"],
    name: json["name"],
    tagline: json["tagline"],
    description: json["description"],
    image: json["image"],
    logo: json["logo"],
    townId: json["town_id"],
    stateId: json["state_id"],
    button: json["button"] == null ? null : Button.fromJson(json["button"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "tagline": tagline,
    "description": description,
    "image": image,
    "logo": logo,
    "town_id": townId,
    "state_id": stateId,
    "button": button?.toJson(),
  };
}

class Button {
  final String? text;
  final String? url;

  Button({
    this.text,
    this.url,
  });

  factory Button.fromJson(Map<String, dynamic> json) => Button(
    text: json["text"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "url": url,
  };
}

class Games {
  final String? title;
  final String? subTitle;
  final List<Card>? cards;
  final List<Leaderboard>? leaderboard;

  Games({
    this.title,
    this.subTitle,
    this.cards,
    this.leaderboard,
  });

  factory Games.fromJson(Map<String, dynamic> json) => Games(
    title: json["title"],
    subTitle: json["sub_title"],
    cards: json["cards"] == null ? [] : List<Card>.from(json["cards"]!.map((x) => Card.fromJson(x))),
    leaderboard: json["leaderboard"] == null ? [] : List<Leaderboard>.from(json["leaderboard"]!.map((x) => Leaderboard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "sub_title": subTitle,
    "cards": cards == null ? [] : List<dynamic>.from(cards!.map((x) => x.toJson())),
    "leaderboard": leaderboard == null ? [] : List<dynamic>.from(leaderboard!.map((x) => x.toJson())),
  };
}

class Card {
  final String? type;
  final String? title;
  final String? descriptionLine1;
  final String? descriptionLine2;
  final String? buttonText;
  final String? image;
  final String? url;

  Card({
    this.type,
    this.title,
    this.descriptionLine1,
    this.descriptionLine2,
    this.buttonText,
    this.image,
    this.url,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    type: json["type"],
    title: json["title"],
    descriptionLine1: json["description_line_1"],
    descriptionLine2: json["description_line_2"],
    buttonText: json["button_text"],
    image: json["image"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "title": title,
    "description_line_1": descriptionLine1,
    "description_line_2": descriptionLine2,
    "button_text": buttonText,
    "image": image,
    "url": url,
  };
}

class Leaderboard {
  final int? rank;
  final String? name;
  final String? avatar;
  final String? points;
  final bool? isCurrentUser;

  Leaderboard({
    this.rank,
    this.name,
    this.avatar,
    this.points,
    this.isCurrentUser,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
    rank: json["rank"],
    name: json["name"],
    avatar: json["avatar"],
    points: json["points"],
    isCurrentUser: json["is_current_user"],
  );

  Map<String, dynamic> toJson() => {
    "rank": rank,
    "name": name,
    "avatar": avatar,
    "points": points,
    "is_current_user": isCurrentUser,
  };
}
