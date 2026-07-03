import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

class LoginResponse {
    final int? code;
    final NewsLetters? newsLetters;
    final List<UserInformation>? userInformation;
    final String? message;
    final String? token;

    LoginResponse({
        this.code,
        this.newsLetters,
        this.userInformation,
        this.message,
        this.token,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) {
        String? parsedMessage;
        if (json["message"] is String) {
            parsedMessage = json["message"];
        } else if (json["message"] is List) {
            final messages = json["message"] as List;
            parsedMessage = messages.isNotEmpty ? messages.first.toString() : null;
        }
        return LoginResponse(
            code: json["code"],
            newsLetters: json["news_letters"] == null
                ? null
                : NewsLetters.fromJson(json["news_letters"]),
            userInformation: json["user_information"] == null
                ? []
                : List<UserInformation>.from(
                json["user_information"].map((x) => UserInformation.fromJson(x)),
            ),
            message: parsedMessage,
            token: json["token"],
        );
    }

}

class NewsLetters {
    NewsLetters();

    factory NewsLetters.fromJson(Map<String, dynamic> json) => NewsLetters(
    );

    Map<String, dynamic> toJson() => {
    };
}

class UserInformation {
    final String? currentCity;
    final User? user;
    final String? wikipediaUrl;
    final int? currentCityId;
    final int? numberToStartNews;
    final int? currentStateId;
    final String? email;
    final String? stateAbbrevation;
    final String? cityAbbrevation;

    UserInformation({
        this.currentCity,
        this.user,
        this.wikipediaUrl,
        this.currentCityId,
        this.numberToStartNews,
        this.currentStateId,
        this.email,
        this.stateAbbrevation,
        this.cityAbbrevation,
    });

    factory UserInformation.fromJson(Map<String, dynamic> json) => UserInformation(
        currentCity: json["current_city"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        wikipediaUrl: json["wikipedia_url"],
        currentCityId: json["current_city_id"],
        numberToStartNews: json["number_to_start_news"],
        currentStateId: json["current_state_id"],
        email: json["email"],
        stateAbbrevation: json["state_abbrevation"],
        cityAbbrevation: json["city_abbrevation"],
    );

}

class User {
    final int? id;
    final dynamic roleId;
    final String? username;
    final String? firstName;
    final String? lastName;
    final String? profileName;
    final String? profileImage;
    final int? primaryCityId;
    final bool? isFounder;
    final bool? isEmailVerified;
    final bool? isPhoneVerified;
    final bool? ageVerified;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final DateTime? lastActivityAt;
    final dynamic deletedAt;
    final List<AuthIdentity>? authIdentities;

    User({
        this.id,
        this.roleId,
        this.username,
        this.firstName,
        this.lastName,
        this.profileName,
        this.profileImage,
        this.primaryCityId,
        this.isFounder,
        this.isEmailVerified,
        this.isPhoneVerified,
        this.ageVerified,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.lastActivityAt,
        this.deletedAt,
        this.authIdentities,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        roleId: json["role_id"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profileName: json["profile_name"],
        profileImage: json["profile_image"],
        primaryCityId: json["primary_city_id"],
        isFounder: json["is_founder"],
        isEmailVerified: json["is_email_verified"],
        isPhoneVerified: json["is_phone_verified"],
        ageVerified: json["age_verified"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        lastActivityAt: json["last_activity_at"] == null ? null : DateTime.parse(json["last_activity_at"]),
        deletedAt: json["deleted_at"],
        authIdentities: json["auth_identities"] == null ? [] : List<AuthIdentity>.from(json["auth_identities"]!.map((x) => AuthIdentity.fromJson(x))),
    );

}

class AuthIdentity {
    final int? id;
    final int? userId;
    final String? provider;
    final String? providerIdentifier;
    final String? passwordHash;
    final String? authenticationSalt;
    final bool? isVerified;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    AuthIdentity({
        this.id,
        this.userId,
        this.provider,
        this.providerIdentifier,
        this.passwordHash,
        this.authenticationSalt,
        this.isVerified,
        this.createdAt,
        this.updatedAt,
    });

    factory AuthIdentity.fromJson(Map<String, dynamic> json) => AuthIdentity(
        id: json["id"],
        userId: json["user_id"],
        provider: json["provider"],
        providerIdentifier: json["provider_identifier"],
        passwordHash: json["password_hash"],
        authenticationSalt: json["authentication_salt"],
        isVerified: json["is_verified"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

}
