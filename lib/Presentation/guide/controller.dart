import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AskGuideController extends GetxController {
  final textController = TextEditingController();

  final messages = <AskGuideMessage>[];
  bool isFirstTime = true;

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    sendPrompt(text);
    textController.clear();
  }

  void sendPrompt(String prompt) {
    final text = prompt.trim().replaceAll('\n', ' ');
    if (text.isEmpty) return;

    isFirstTime = false;
    messages
      ..add(AskGuideMessage(text: text, isUser: true))
      ..add(
        const AskGuideMessage(
          text:
              'I can help with that. Here is the quick guide: check the latest town updates, compare upcoming events, and use the guide to jump into the right section.',
          isUser: false,
        ),
      );
    update();
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}

class AskGuideMessage {
  const AskGuideMessage({required this.text, required this.isUser});

  final String text;
  final bool isUser;
}
