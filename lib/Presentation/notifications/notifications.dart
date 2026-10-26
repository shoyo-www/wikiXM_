import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wikixm/Presentation/widgets/cache_image.dart';
import 'package:wikixm/Presentation/widgets/common_blur_scaffold.dart';
import 'package:wikixm/constants/fontsize.dart';
import 'package:wikixm/constants/appcolor.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColor.notificationsPrimaryColor(context);
    final secondaryColor = AppColor.secondaryColor(context);
    final blueColor = AppColor.blueColor(context);
    final newsBackground = AppColor.newsBackground(context);
    final avatarBorder = AppColor.avatarBorder(context);
    return CommonBlurScaffold(
      backgroundColor: Theme.of(context).cardColor,
      showBack: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.h_80),
            Text(
              'Notification',
              style: TextStyle(color: Theme.of(context).highlightColor, fontWeight: FontWeight.w900, fontSize: FontSize.sp_22),
            ),
            Text(
              'You have 4 new notifications',
              style: TextStyle(color: secondaryColor, fontWeight: FontWeight.w400, fontSize: FontSize.sp_11),
            ),
            SizedBox(height: Dimensions.h_20),
            Text(
              'New',
              style: TextStyle(color: primaryColor, fontWeight: FontWeight.w700, fontSize: FontSize.sp_14),
            ),
            SizedBox(height: Dimensions.h_10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: Dimensions.h_30,
                      height: Dimensions.h_30,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.notificationsGreySoft(context)),
                      child: AppCacheImage(imageUrl: 'https://i.pravatar.cc/100?img=12', size: Dimensions.h_60, widthSize: Dimensions.h_60, isCircle: true),
                    ),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        width: Dimensions.h_15,
                        height: Dimensions.h_15,
                        decoration: BoxDecoration(
                          color: blueColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: avatarBorder, width: 3),
                        ),
                        child: Icon(CupertinoIcons.chat_bubble_fill, color: Colors.white, size: Dimensions.h_8),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: Dimensions.w_6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: primaryColor, fontSize: FontSize.sp_11),
                          children: const [
                            TextSpan(
                              text: '@Mitchl',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            TextSpan(
                              text: ' replied on your comment',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.h_4),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.w_8),
                        child: Text(
                          "I agree with u! that's such a horrible way, and that doesn't make sense 😂",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.w400, color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, height: 1.2),
                        ),
                      ),
                      SizedBox(height: Dimensions.h_4),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.w_8),
                        child: Text(
                          'now',
                          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8_5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Dimensions.w_5),
                Padding(
                  padding: EdgeInsets.only(top: Dimensions.h_5),
                  child: Container(
                    width: Dimensions.h_4,
                    height: Dimensions.h_4,
                    decoration: BoxDecoration(color: blueColor, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.h_15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: Dimensions.h_30,
                      height: Dimensions.h_30,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.notificationsGreySoft(context)),
                      child: AppCacheImage(imageUrl: 'https://i.pravatar.cc/100?img=47', size: Dimensions.h_60, widthSize: Dimensions.h_60, isCircle: true),
                    ),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        width: Dimensions.h_15,
                        height: Dimensions.h_15,
                        decoration: BoxDecoration(
                          color: blueColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: avatarBorder, width: 3),
                        ),
                        child: Icon(CupertinoIcons.check_mark, color: Colors.white, size: Dimensions.h_8),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: Dimensions.w_6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: primaryColor, fontSize: FontSize.sp_11),
                          children: const [
                            TextSpan(
                              text: '@Ema',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            TextSpan(
                              text: ' Started following you',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.h_4),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.w_6),
                        child: Text(
                          '2 min ago',
                          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8_5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Dimensions.w_5),
                Padding(
                  padding: EdgeInsets.only(top: Dimensions.h_5),
                  child: Container(
                    width: Dimensions.h_4,
                    height: Dimensions.h_4,
                    decoration: BoxDecoration(color: blueColor, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.h_15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: Dimensions.h_30,
                      height: Dimensions.h_30,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.notificationsGreySoft(context)),
                      child: AppCacheImage(imageUrl: 'https://i.pravatar.cc/100?img=11', size: Dimensions.h_60, widthSize: Dimensions.h_60, isCircle: true),
                    ),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        width: Dimensions.h_15,
                        height: Dimensions.h_15,
                        decoration: BoxDecoration(
                          color: blueColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: avatarBorder, width: 3),
                        ),
                        child: Icon(CupertinoIcons.hand_thumbsup_fill, color: Colors.white, size: Dimensions.h_8),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: Dimensions.w_6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: primaryColor, fontSize: FontSize.sp_11),
                          children: const [
                            TextSpan(
                              text: '@David',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            TextSpan(
                              text: ' liked your comment',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.h_4),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.w_6),
                        child: Text(
                          '12 mins ago',
                          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8_5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Dimensions.w_5),
                Padding(
                  padding: EdgeInsets.only(top: Dimensions.h_5),
                  child: Container(
                    width: Dimensions.h_4,
                    height: Dimensions.h_4,
                    decoration: BoxDecoration(color: blueColor, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.h_15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: Dimensions.h_30,
                      height: Dimensions.h_30,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.notificationsGreySoft(context)),
                      child: AppCacheImage(imageUrl: 'https://i.pravatar.cc/100?img=48', size: Dimensions.h_60, widthSize: Dimensions.h_60, isCircle: true),
                    ),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        width: Dimensions.h_15,
                        height: Dimensions.h_15,
                        decoration: BoxDecoration(
                          color: blueColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: avatarBorder, width: 3),
                        ),
                        child: Icon(CupertinoIcons.music_note, color: Colors.white, size: Dimensions.h_7),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: Dimensions.w_6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: primaryColor, fontSize: FontSize.sp_11),
                          children: const [
                            TextSpan(
                              text: '@Tammie',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            TextSpan(
                              text: ' created an new event',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.h_4),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.w_6),
                        child: Text(
                          '30 mins ago',
                          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8_5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Dimensions.w_5),
                Padding(
                  padding: EdgeInsets.only(top: Dimensions.h_5),
                  child: Container(
                    width: Dimensions.h_4,
                    height: Dimensions.h_4,
                    decoration: BoxDecoration(color: blueColor, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.h_20),
            Text(
              'Today',
              style: TextStyle(color: primaryColor, fontWeight: FontWeight.w700, fontSize: FontSize.sp_14),
            ),
            SizedBox(height: Dimensions.h_10),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Dimensions.h_5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Dimensions.h_30,
                    height: Dimensions.h_30,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.notificationsGreenSoft(context)),
                    child: Icon(Icons.public, size: Dimensions.h_15, color: AppColor.notificationsGreen(context)),
                  ),
                  SizedBox(width: Dimensions.w_6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: primaryColor, fontSize: FontSize.sp_11, height: 1.15),
                            children: const [
                              TextSpan(
                                text: 'Sophie',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                              TextSpan(
                                text: ' posted recent news, let’s read it',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.h_5),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(Dimensions.w_4),
                          decoration: BoxDecoration(color: newsBackground, borderRadius: BorderRadius.circular(Dimensions.h_8)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppCacheImage(imageUrl: 'https://images.unsplash.com/photo-1495020689067-958852a7765e?w=300', widthSize: Dimensions.w_65, size: Dimensions.h_40, fit: BoxFit.cover),
                              SizedBox(width: Dimensions.w_6),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '5 mins read',
                                      style: TextStyle(color: secondaryColor, fontSize: FontSize.sp_9),
                                    ),

                                    SizedBox(height: Dimensions.h_4),

                                    Text(
                                      'AI Taking Over Jobs: What to Know About the Future...',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: primaryColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600, height: 1.1),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: Dimensions.h_2),

                        Text(
                          '5h ago',
                          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8_5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.h_10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: Dimensions.h_30,
                      height: Dimensions.h_30,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.notificationsGreySoft(context)),
                      child: AppCacheImage(imageUrl: 'https://i.pravatar.cc/100?img=50', size: Dimensions.h_60, widthSize: Dimensions.h_60, isCircle: true),
                    ),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        width: Dimensions.h_15,
                        height: Dimensions.h_15,
                        decoration: BoxDecoration(
                          color: blueColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: avatarBorder, width: 3),
                        ),
                        child: Icon(CupertinoIcons.home, color: Colors.white, size: Dimensions.h_7),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: Dimensions.w_6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: primaryColor, fontSize: FontSize.sp_11),
                          children: const [
                            TextSpan(
                              text: '@James',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            TextSpan(
                              text: ' invited you to group',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.h_4),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.w_6),
                        child: Text(
                          '3 hrs ago',
                          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8_5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.h_15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: Dimensions.h_30,
                      height: Dimensions.h_30,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.notificationsGreySoft(context)),
                      child: AppCacheImage(imageUrl: 'https://i.pravatar.cc/100?img=43', size: Dimensions.h_60, widthSize: Dimensions.h_60, isCircle: true),
                    ),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        width: Dimensions.h_15,
                        height: Dimensions.h_15,
                        decoration: BoxDecoration(
                          color: blueColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: avatarBorder, width: 3),
                        ),
                        child: Icon(CupertinoIcons.music_note, color: Colors.white, size: Dimensions.h_7),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: Dimensions.w_6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: primaryColor, fontSize: FontSize.sp_11),
                          children: const [
                            TextSpan(
                              text: '@Jessie',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            TextSpan(
                              text: ' posted garage sale',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.h_4),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.w_6),
                        child: Text(
                          '5 hrs ago',
                          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8_5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.h_20),
          ],
        ),
      ),
    );
  }
}
