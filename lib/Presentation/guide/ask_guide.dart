import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/guide/controller.dart';
import 'package:wikixm/Presentation/widgets/common_appbar.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/constants/fontsize.dart';

class AskGuide extends StatelessWidget {
  const AskGuide({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return GetBuilder<AskGuideController>(
      init: AskGuideController(),
      builder: (controller) {
        return AppScaffold(
          top: false,
          bottom: false,
          bodyPadding: EdgeInsets.zero,
          body: Stack(
            children: [
              Positioned.fill(
                child: controller.isFirstTime
                    ? _FirstTimeGuide(
                        topPadding: topPadding,
                        controller: controller,
                      )
                    : ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                          Dimensions.w_12,
                          topPadding + Dimensions.h_40,
                          Dimensions.w_12,
                          Dimensions.h_120,
                        ),
                        itemCount: controller.messages.length,
                        separatorBuilder: (_, _) =>
                            SizedBox(height: Dimensions.h_15),
                        itemBuilder: (context, index) {
                          final message = controller.messages[index];
                          return _GuideMessageBubble(message: message);
                        },
                      ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CommonBlurAppBar(
                  topPadding: topPadding,
                  blurOpacity: 1,
                  foregroundColor: Colors.black,
                  child: _GuideAppBar(),
                ),
              ),
              Positioned(
                left: Dimensions.w_18,
                right: Dimensions.w_18,
                bottom: Dimensions.h_28,
                child: _AskInputBar(controller: controller),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FirstTimeGuide extends StatelessWidget {
  const _FirstTimeGuide({required this.topPadding, required this.controller});

  final double topPadding;
  final AskGuideController controller;

  @override
  Widget build(BuildContext context) {
    final prompts = [
      (Icons.account_balance_outlined, "What's happening\nat Town Hall?"),
      (Icons.calendar_month_outlined, 'What events are\nthis weekend?'),
      (Icons.sports_football_outlined, 'When is the\nEagles game?'),
      (Icons.local_pizza_outlined, 'Recommend a\ngood pizza place.'),
      (Icons.construction_outlined, 'Why is Main\nStreet closed?'),
      (Icons.wb_cloudy_outlined, 'Will it rain\ntomorrow?'),
    ];
    return ListView(
      padding: EdgeInsets.fromLTRB(
        Dimensions.w_18,
        topPadding + Dimensions.h_55,
        Dimensions.w_18,
        Dimensions.h_120,
      ),
      children: [
        Text(
          'Ask me about local updates, events, businesses, weather, or anything happening around town.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black.withValues(alpha: 0.62),
            fontSize: FontSize.sp_12,
            height: 1.45,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: Dimensions.h_45),
        Text(
          'Try asking about...',
          style: TextStyle(
            color: const Color(0xFF06124F),
            fontSize: FontSize.sp_12,
            fontWeight: FontWeight.w600,
          ),
        ),
        GridView.builder(
          padding: EdgeInsets.only(top: Dimensions.h_10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: prompts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: Dimensions.h_5,
            crossAxisSpacing: Dimensions.w_5,
            childAspectRatio: 3,
          ),
          itemBuilder: (context, index) {
            final item = prompts[index];
            return _PromptCard(
              icon: item.$1,
              text: item.$2,
              onTap: () => controller.sendPrompt(item.$2),
            );
          },
        ),
      ],
    );
  }
}

class _PromptCard extends StatelessWidget {
  const _PromptCard({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(Dimensions.h_4),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: const Color(0xFF06124F),
                  fontSize: FontSize.sp_11,
                  height: 1.25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF06124F),
              size: Dimensions.h_15,
            ),
          ],
        ),
      ),
    );
  }
}

class _GuideMessageBubble extends StatelessWidget {
  const _GuideMessageBubble({required this.message});

  final AskGuideMessage message;

  @override
  Widget build(BuildContext context) {
    if (!message.isUser) {
      return Text(
        message.text,
        style: TextStyle(
          color: Colors.black,
          fontSize: FontSize.sp_12,
          height: 1.55,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: Dimensions.w_270),
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w_12,
          vertical: Dimensions.h_10,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(Dimensions.h_12),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: Colors.black,
            fontSize: FontSize.sp_12,
            height: 1.35,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _GuideAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Get.back(),
          child: Container(
            width: Dimensions.h_22,
            height: Dimensions.h_22,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF303030)),
            ),
            child: Icon(Icons.arrow_back_ios_sharp, size: Dimensions.h_10),
          ),
        ),
        SizedBox(width: Dimensions.w_15),
        Text(
          'TOWN AI GUIDE',
          style: TextStyle(
            fontSize: FontSize.sp_14,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _AskInputBar extends StatelessWidget {
  const _AskInputBar({required this.controller});

  final AskGuideController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.h_35,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.h_30),
        border: Border.all(color: const Color(0xFF333333), width: 0.5),
      ),
      child: Row(
        children: [
          SizedBox(width: Dimensions.w_8),
          Expanded(
            child: TextField(
              controller: controller.textController,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => controller.sendMessage(),
              style: TextStyle(
                color: Colors.black,
                fontSize: FontSize.sp_11,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'Ask guide...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              cursorColor: Colors.black,
              minLines: 1,
              maxLines: 1,
            ),
          ),
          Icon(Icons.mic_none, color: Colors.white, size: Dimensions.h_25),
          SizedBox(width: Dimensions.w_12),
          Container(
            width: Dimensions.h_25,
            height: Dimensions.h_25,
            decoration: const BoxDecoration(
              color: Color(0xFF3BA1FF),
              shape: BoxShape.circle,
            ),
            child: GestureDetector(
              onTap: controller.sendMessage,
              child: Icon(
                Icons.arrow_upward,
                color: Colors.white,
                size: Dimensions.h_15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
