import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/social_button.dart';
import '../../constants/fontsize.dart';
import '../../constants/images.dart';
import '../widgets/cache_image.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      top: false,
      bodyPadding: EdgeInsets.zero,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter,colors: [
                  Color(0xFF011c62),
                  Color(0xFF001e67),
                  Color(0xFF14327b),
                  Colors.white,
                ],   stops: [0.2, 0.35, 0.5,0.75])
              ),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      AppCacheImage(
                        size: Dimensions.h_200,
                        imageUrl: Images.firstVisitSeattle,
                        isShadow: false,
                        fit: BoxFit.cover,
                        widthSize: Get.width,
                      ),
                      const Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xE6020B15),
                                Color(0x99020B15),
                                Color(0x00000000),
                                Color(0x00000000),
                              ],
                              stops: [0.35, 0.55, 0.78, 1],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: Dimensions.h_45,
                          left: Dimensions.w_30,
                          right: Dimensions.w_10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image.asset(Images.appLogoGif,height: Dimensions.h_50,width: Dimensions.h_50),
                            Text(
                              'Good evening,',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: FontSize.sp_24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'Sean! 👋',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: FontSize.sp_24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: Dimensions.h_3),
                            Row(
                              children: [
                                Text(
                                  'Dallas missed you.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSize.sp_14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_4),
                                Icon(CupertinoIcons.heart_fill,color: Colors.red,size: Dimensions.h_20)
                              ],
                            ),
                            SizedBox(height: Dimensions.h_5),
                            Text(
                              'Stay informed. Join the conversation',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSize.sp_9,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Together, we build a stronger Dallas.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSize.sp_9,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: Dimensions.h_3),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.h_38,left: Dimensions.w_8,right: Dimensions.w_8),
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w_8,
                        vertical: Dimensions.h_5
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xff000e34),
                        border: Border.all(
                            color: Colors.grey.shade500,width: 0.5
                        ),
                        borderRadius: BorderRadius.circular(Dimensions.h_4)
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    height: Dimensions.h_8,
                                    width: Dimensions.h_8,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green
                                    ),
                                    ),
                                SizedBox(width: Dimensions.w_4),
                                Text(
                                  'SINCE YOUR LAST VISIT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSize.sp_11,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'See all updates',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSize.sp_8_5,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_2),
                                Icon(CupertinoIcons.arrow_right,size: Dimensions.h_11,color: Colors.white)
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: Dimensions.h_5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: Dimensions.w_3),
                                Icon(CupertinoIcons.chat_bubble_fill,color: Colors.white,size: Dimensions.h_10),
                                SizedBox(width: Dimensions.w_4),
                                Text(
                                  'Mayor Johnson answered 5',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSize.sp_9,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '28m ago',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.sp_8,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: Dimensions.h_2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: Dimensions.w_3),
                                Icon(CupertinoIcons.chat_bubble_fill,color: Colors.white,size: Dimensions.h_10),
                                SizedBox(width: Dimensions.w_4),
                                Text(
                                  'Mayor Johnson answered 5',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSize.sp_9,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '28m ago',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.sp_8,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: Dimensions.h_2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: Dimensions.w_3),
                                Icon(CupertinoIcons.chat_bubble_fill,color: Colors.white,size: Dimensions.h_10),
                                SizedBox(width: Dimensions.w_4),
                                Text(
                                  'Mayor Johnson answered 5',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSize.sp_9,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '28m ago',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.sp_8,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: Dimensions.h_2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: Dimensions.w_3),
                                Icon(CupertinoIcons.chat_bubble_fill,color: Colors.white,size: Dimensions.h_10),
                                SizedBox(width: Dimensions.w_4),
                                Text(
                                  'Mayor Johnson answered 5',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontSize.sp_9,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '28m ago',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSize.sp_8,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  buildSignIn(),
                ],
              ),
            ),
            Positioned(
              left:Dimensions.w_8,
              right: Dimensions.w_8,
              top: Dimensions.h_165,
              child: IgnorePointer(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w_4,
                    vertical: Dimensions.h_5
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.h_4)
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: Dimensions.w_4),
                              Container(
                                height: Dimensions.h_18,
                                width: Dimensions.h_18,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff00127f)
                                  ),
                                  child: Icon(CupertinoIcons.calendar,size: Dimensions.h_12)),
                              SizedBox(width: Dimensions.w_8),
                              Text(
                                'TODAY IN DALLAS',
                                style: TextStyle(
                                  color: Color(0xff00127f),
                                  fontSize: FontSize.sp_11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: Dimensions.w_6),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4,vertical: Dimensions.h_1),
                                  decoration: BoxDecoration(
                                      color: Color(0xfff50309),
                                    borderRadius: BorderRadius.circular(4)
                                  ),
                                  child:  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: Dimensions.h_3,
                                        height: Dimensions.h_3,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.w_2),
                                      Text(
                                        'LIVE',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: FontSize.sp_8_5,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'View all',
                                style: TextStyle(
                                  color: Color(0xff0607fa),
                                  fontSize: FontSize.sp_9,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: Dimensions.w_2),
                              Icon(CupertinoIcons.arrow_right,size: Dimensions.h_11,color: Color(0xff0607fa)),
                              SizedBox(width: Dimensions.w_2),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: Dimensions.h_8),
                      buildInfo(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildSignIn() {
    return Container(
      margin: EdgeInsets.only(
          top: Dimensions.h_6, left: Dimensions.w_8, right: Dimensions.w_8),
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w_10,
          vertical: Dimensions.h_5
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.h_4),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade400,
                offset: Offset(4, 4),
                blurRadius: 20,
                spreadRadius: 1),
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      height: Dimensions.h_18,
                      width: Dimensions.h_18,
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff00127f)
                      ),
                      child: Icon(Icons.lock, size: Dimensions.h_12)),
                  SizedBox(width: Dimensions.w_8),
                  Text(
                    'Sign in to your WikiXM account',
                    style: TextStyle(
                      color: Color(0xff00127f),
                      fontSize: FontSize.sp_16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                ],
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_5),
          Text(
            "Welcome back! Let's pick up where you left",
            style: TextStyle(
              color: Color(0xff00127f),
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: Dimensions.h_5),
          Text(
            "Email or Mobile Number",
            style: TextStyle(
              color: Color(0xff00127f),
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: Dimensions.h_3),
          SizedBox(
            height: Dimensions.h_30,
            child: TextFormField(
              style: TextStyle(
                color: Colors.black87,
                fontSize: FontSize.sp_11,
              ),
              cursorColor: Colors.black87,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: FontSize.sp_10
                ),
                hintText: "Enter your email or mobile number",
                prefixIcon: Icon(
                  Icons.email_outlined,
                  size: Dimensions.h_15,
                  color: Color(0xff00127f),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: Dimensions.h_2),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                      color: Colors.grey.shade500,
                      width: 0.5
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                      color: Colors.grey.shade500,
                      width: 0.5
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_8),
          Text(
            "Password",
            style: TextStyle(
              color: Color(0xff00127f),
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: Dimensions.h_3),
          SizedBox(
            height: Dimensions.h_30,
            child: TextFormField(
              style: TextStyle(
                color: Colors.black87,
                fontSize: FontSize.sp_11,
              ),
              cursorColor: Colors.black87,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: FontSize.sp_10
                ),
                hintText: "Enter your password",
                prefixIcon: Icon(
                  Icons.lock_outline,
                  size: Dimensions.h_15,
                  color: Color(0xff00127f),
                ),
                suffixIcon: Icon(
                  Icons.remove_red_eye,
                  size: Dimensions.h_15,
                  color: Color(0xff00127f),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: Dimensions.h_2),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                      color: Colors.grey.shade500,
                      width: 0.5
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                      color: Colors.grey.shade500,
                      width: 0.5
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: Dimensions.h_12,
                      width: Dimensions.h_12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                              color: Color(0xff00127f),
                              width: 1
                          )
                      ),
                    ),
                    SizedBox(width: Dimensions.w_8),
                    Text(
                      "Keep me signed in",
                      style: TextStyle(
                        color: Color(0xff00127f),
                        fontSize: FontSize.sp_10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    color: Color(0xff0607fa),
                    fontSize: FontSize.sp_10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w_1,
                vertical: Dimensions.h_6,
              ),
              decoration: BoxDecoration(
                color: Color(0xff001dca),
                borderRadius: BorderRadius.circular(Dimensions.h_4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock,
                    size: Dimensions.h_16,
                    color: Colors.white,
                  ),
                  SizedBox(width: Dimensions.w_5),
                  Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontSize.sp_16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_5),
          Row(
            children: [
              Expanded(child: Container(
                margin: EdgeInsets.only(right: Dimensions.w_5),
                height: 0.5,
                color: Colors.grey,
              )),
              Text(
                "OR",
                style: TextStyle(
                  color: Color(0xff00127f),
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(child: Container(
                margin: EdgeInsets.only(left: Dimensions.w_5),
                height: 0.5,
                color: Colors.grey,
              )),
            ],
          ),
          SizedBox(height: Dimensions.h_2),
          Center(
            child: Text(
              "Continue with",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff00127f),
                fontSize: FontSize.sp_9_5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_8),
          SocialLoginButtons(),
          SizedBox(height: Dimensions.h_10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'New to WikiXM?',
                style: TextStyle(
                  color: Color(0xff00127f),
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: Dimensions.w_4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Create a free account',
                    style: TextStyle(
                      color: Color(0xFF1D4ED8),
                      fontSize: FontSize.sp_10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                   SizedBox(width: Dimensions.w_1),
                  Icon(
                    CupertinoIcons.arrow_right,
                    size: Dimensions.h_11,
                    color: Color(0xFF1D4ED8),
                  ),
                ],
              )

            ],
          ),
        ],
      ),
    );
  }

  Widget buildInfo() {
    final items = [
      (
      icon: null,
      value: '36',
      title: 'New Stories',
      ),
      (
      icon: CupertinoIcons.chat_bubble_fill,
      value: '18',
      title: 'Discussions',
      ),
      (
      icon: CupertinoIcons.cloud_bolt_rain,
      value: '4',
      title: 'Alerts',
      ),
      (
      icon: CupertinoIcons.building_2_fill,
      value: '7',
      title: 'Responses',
      ),
      (
      icon: CupertinoIcons.calendar,
      value: '6',
      title: 'Events',
      ),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(items.length, (index) {
        final item = items[index];
        return Expanded(
          child: Container(
            padding: EdgeInsets.only(right: index != items.length - 1 ? Dimensions.w_4 : 0,left: index== 0 ? 0: Dimensions.w_6),
            decoration: BoxDecoration(
              border: index != items.length - 1
                  ? Border(
                right: BorderSide(
                  color: Colors.grey.shade500,
                  width: .5,
                ),
              )
                  : null,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Dimensions.h_1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (item.icon == null)
                    Text(
                      item.value,
                      style: TextStyle(
                        color: const Color(0xff001072),
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Poppins',
                        fontSize: FontSize.sp_12,
                      ),
                    ),

                  if (item.icon != null)
                    const SizedBox(height: 2),
                  if (item.icon != null)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          color: const Color(0xff001072),
                          size: Dimensions.h_13,
                        ),
                        SizedBox(width: Dimensions.w_5),
                        Text(
                          item.value,
                          style: TextStyle(
                            color: const Color(0xff001072),
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Poppins',
                            fontSize: FontSize.sp_12,
                          ),
                        ),
                      ],
                    ),
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xff001072),
                      fontSize: FontSize.sp_9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
