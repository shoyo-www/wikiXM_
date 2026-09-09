class CompleteRegistrationRequest {
  final List<int> interests;
  final List<int> notifications;
  final List<int> deliveryChannels;

  CompleteRegistrationRequest({
    required this.interests,
    required this.notifications,
    required this.deliveryChannels,
  });

  Map<String, dynamic> toJson() {
    return {
      "interests": interests,
      "notifications": notifications,
      "delivery_channels": deliveryChannels,
    };
  }
}