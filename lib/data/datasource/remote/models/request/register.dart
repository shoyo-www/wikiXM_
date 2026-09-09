import 'dart:convert';

String registerRequestToJson(RegisterRequest data) =>
    json.encode(data.toJson());

class RegisterRequest {
  String email;
  String firstName;
  String lastName;
  String password;
  String passwordConfirmation;
  int termsAccepted;

  RegisterRequest({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.passwordConfirmation,
    required this.termsAccepted,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "password": password,
    "password_confirmation": passwordConfirmation,
    "terms_accepted": termsAccepted,
  };
}