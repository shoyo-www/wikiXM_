import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/auth/auth_controller.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/social_button.dart';
import '../../constants/fontsize.dart';
import '../../constants/images.dart';
import '../widgets/cache_image.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
    return AppScaffold(
      top: false,
      bodyPadding: EdgeInsets.zero,
        body: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: Dimensions.h_15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,colors: [
                    Color(0xE6001244).withValues(alpha: 0.95),
                    Color(0xFF011c62),
                    Color(0xFF001e67),
                    Color(0xFF14327b),
                    Colors.white,
                  ],   stops: [0.1,0.2, 0.33, 0.5,0.75])
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
                         Positioned.fill(
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
                            left: Dimensions.w_10,
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
                      margin: EdgeInsets.only(top: Dimensions.h_280,left: Dimensions.w_8,right: Dimensions.w_8),
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w_4,
                          vertical: Dimensions.h_5
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Dimensions.h_8)
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
                          SizedBox(height: Dimensions.h_10),
                          Padding(
                            padding:  EdgeInsets.only(left: Dimensions.w_2),
                            child: buildInfo(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Dimensions.h_5,left: Dimensions.w_8,right: Dimensions.w_8),
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w_8,
                          vertical: Dimensions.h_5
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12,
                                offset: Offset(0, 2),
                                blurRadius: 2,
                                spreadRadius: 1)],
                          borderRadius: BorderRadius.circular(Dimensions.h_8)
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
                                      color: Color(0xff00127f),
                                      fontSize: FontSize.sp_11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'See all updates',
                                    style: TextStyle(
                                      color: Color(0xff0607fa),
                                      fontSize: FontSize.sp_8_5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.w_2),
                                  Icon(CupertinoIcons.arrow_right,size: Dimensions.h_11,color: Color(0xff0607fa))
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
                                  Icon(CupertinoIcons.chat_bubble_fill, color: Color(0xff00127f),size: Dimensions.h_10),
                                  SizedBox(width: Dimensions.w_4),
                                  Text(
                                    'Mayor Johnson answered 5',
                                    style: TextStyle(
                                      color: Color(0xff00127f),
                                      fontSize: FontSize.sp_9,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '28m ago',
                                style: TextStyle(
                                    color: Color(0xff00127f),
                                    fontSize: FontSize.sp_8,
                                    fontWeight: FontWeight.w500,
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
                                  Icon(CupertinoIcons.chat_bubble_fill, color: Color(0xff00127f),size: Dimensions.h_10),
                                  SizedBox(width: Dimensions.w_4),
                                  Text(
                                    'Mayor Johnson answered 5',
                                    style: TextStyle(
                                      color: Color(0xff00127f),
                                      fontSize: FontSize.sp_9,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '28m ago',
                                style: TextStyle(
                                    color: Color(0xff00127f),
                                    fontSize: FontSize.sp_8,
                                    fontWeight: FontWeight.w500,
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
                                  Icon(CupertinoIcons.chat_bubble_fill, color: Color(0xff00127f),size: Dimensions.h_10),
                                  SizedBox(width: Dimensions.w_4),
                                  Text(
                                    'Mayor Johnson answered 5',
                                    style: TextStyle(
                                      color: Color(0xff00127f),
                                      fontSize: FontSize.sp_9,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '28m ago',
                                style: TextStyle(
                                    color: Color(0xff00127f),
                                    fontSize: FontSize.sp_8,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins'
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Dimensions.h_5,left: Dimensions.w_7,right: Dimensions.w_7),
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w_1,
                          vertical: Dimensions.h_8
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Dimensions.h_8),
                        border: Border.all(color: const Color(0xffE8E8E8)),
                        boxShadow: [
                          BoxShadow(color: Colors.black12,
                              offset: Offset(0, 4),
                              blurRadius: 2,
                              spreadRadius: 1)
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: Dimensions.w_8),
                            child: Row(
                              children: [
                                 Icon(Icons.account_balance,
                                    color: Color(0xff001072),size: Dimensions.h_13),
                                 SizedBox(width: Dimensions.w_6),
                                 Text(
                                  "YOUR COMMUNITY JOURNEY",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff001072),
                                    fontSize: FontSize.sp_11,
                                  ),
                                ),
                                Spacer(),
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
                                ),
                                SizedBox(width: Dimensions.w_4)
                              ],
                            ),
                          ),
                           SizedBox(height: Dimensions.h_10),
                          Padding(
                            padding:  EdgeInsets.only(left: Dimensions.w_4),
                            child: Row(
                              children:  [
                                SizedBox(
                                  width: Dimensions.w_100,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: Dimensions.h_30,
                                        height: Dimensions.h_30,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff6D28D9),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: Dimensions.h_15,
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.w_8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Level 3",
                                              style: TextStyle(
                                                fontSize: FontSize.sp_13,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xff001072),
                                              ),
                                            ),
                                            Text(
                                              "Community\nChampion",
                                              style: TextStyle(
                                                fontSize: FontSize.sp_8,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: Dimensions.w_3,left: Dimensions.w_5),
                                  width: 0.5,
                                  color: Colors.grey,
                                  height: Dimensions.h_30,
                                ),
                                Expanded(
                                  child: JourneyItem(
                                    icon: Icons.star,
                                    iconColor: Color(0xff7117c7),
                                    value: "1250",
                                    title: "Community Points",
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: Dimensions.w_5,left: Dimensions.w_5),
                                  width: 0.5,
                                  color: Colors.grey,
                                  height: Dimensions.h_30,
                                ),
                                Expanded(
                                  child: JourneyItem(
                                    icon: Icons.local_fire_department,
                                    iconColor: Color(0xffff9007),
                                    value: "7",
                                    title: "Days Streak",
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: Dimensions.w_3,right: Dimensions.w_3),
                                  width: 0.5,
                                  color: Colors.grey,
                                  height: Dimensions.h_30,
                                ),
                                Expanded(
                                  child: JourneyItem(
                                    icon: Icons.bar_chart,
                                    iconColor: Color(0xff0389a4),
                                    value: "68%",
                                    title: "to Level 4",
                                  ),
                                ),
                              ],
                              ),
                          ),
                           SizedBox(height: Dimensions.h_10),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: Dimensions.w_10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: LinearProgressIndicator(
                                      value: .68,
                                      minHeight: 6,
                                      backgroundColor: Colors.grey.shade300,
                                      color: const Color(0xff7C3AED),
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.w_8),
                                Text(
                                  "68% to Level 4",
                                  style: TextStyle(
                                    fontSize: FontSize.sp_8,
                                    color: const Color(0xff16A34A),
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: Dimensions.h_10),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
                            padding: EdgeInsets.symmetric(vertical: Dimensions.h_4),
                            decoration: BoxDecoration(
                              color: const Color(0xfffef6ef),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xfffef6ef),
                              )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(left: Dimensions.w_6),
                                  child: Text(
                                     "TODAY'S FASTEST WAY TO PROGRESS",
                                     style: TextStyle(
                                       fontWeight: FontWeight.w500,
                                       color: Colors.black87,
                                       fontSize: FontSize.sp_9_5,
                                     ),
                                   ),
                                ),
                                SizedBox(height: Dimensions.h_8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(right: Dimensions.w_2 ,left: Dimensions.w_2),
                                        padding: EdgeInsets.only(right: Dimensions.w_1,left: Dimensions.w_1,
                                            top: Dimensions.h_1,bottom: Dimensions.h_1),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color: Color(0xffe9f0fa),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                color:  Color(0xffd2e3fc),
                                              ),
                                              child: Icon(
                                                CupertinoIcons.chat_bubble_fill,
                                                color: Color(0xff0563fb),
                                                size: Dimensions.h_15,
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.w_6),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Join a Town Hall discussion',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: 'Poppins',
                                                        fontSize: FontSize.sp_8
                                                    ),
                                                  ),
                                                  SizedBox(height: Dimensions.h_4),
                                                  Text(
                                                    '+10pts',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color(0xff001072),
                                                      fontSize: FontSize.sp_9_5,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(right: Dimensions.w_2 ,left: Dimensions.w_2),
                                        padding: EdgeInsets.only(right: Dimensions.w_1,left: Dimensions.w_1,
                                            top: Dimensions.h_1,bottom: Dimensions.h_1),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color: Color(0xffecf4e8),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Icon(
                                                CupertinoIcons.camera,
                                                color: Color(0xff089731),
                                                size: Dimensions.h_15,
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.w_6),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Upload a local photo',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: 'Poppins',
                                                        fontSize: FontSize.sp_8
                                                    ),
                                                  ),
                                                  SizedBox(height: Dimensions.h_4),
                                                  Text(
                                                    '+5pts',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color(0xff277e3e),
                                                      fontSize: FontSize.sp_9_5,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(right: Dimensions.w_2 ,left: Dimensions.w_2),
                                        padding: EdgeInsets.only(right: Dimensions.w_1,left: Dimensions.w_1,
                                            top: Dimensions.h_1,bottom: Dimensions.h_1),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color: Color(0xfffef2d7),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Icon(
                                                CupertinoIcons.group_solid,
                                                color: Color(0xfffb8b03),
                                                size: Dimensions.h_18,
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.w_6),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Welcome new resident',
                                                    style: TextStyle(
                                                        color: Colors.black87,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: 'Poppins',
                                                        fontSize: FontSize.sp_8
                                                    ),
                                                  ),
                                                  SizedBox(height: Dimensions.h_4),
                                                  Text(
                                                    '+3pts',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: const Color(0xff277e3e),
                                                      fontSize: FontSize.sp_9_5,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ContinueWhereLeftOffWidget()
                  ],
                ),
              ),
              Positioned(
                left:Dimensions.w_8,
                right: Dimensions.w_8,
                top: Dimensions.h_165,
                child: buildSignIn(controller),
              ),
            ],
          ),
        ));
  }

  Widget buildSignIn(AuthController controller) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w_10,
          vertical: Dimensions.h_5
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.h_8),
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    height: Dimensions.h_30,
                    width: Dimensions.h_30,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff00127f)
                    ),
                    child: Icon(Icons.lock, size: Dimensions.h_20)),
                SizedBox(width: Dimensions.w_8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back! ",
                        style: TextStyle(
                          color: Color(0xff00127f),
                          fontSize: FontSize.sp_16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Sign in to your WikiXM account',
                        style: TextStyle(
                          color: Color(0xff00127f),
                          fontSize: FontSize.sp_10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.h_10),
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
              height: Dimensions.h_50,
              child: TextFormField(
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: FontSize.sp_11,
                ),
                controller: controller.email,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
        
                  if (!GetUtils.isEmail(value.trim())) {
                    return 'Please enter a valid email';
                  }
        
                  return null;
                },
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
                  errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: FontSize.sp_8
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: Dimensions.h_1),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                        color: Colors.grey.shade500,
                        width: 0.5
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                        color: Colors.grey.shade500,
                        width: 0.5
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                        color: Colors.grey.shade500,
                        width: 0.5
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
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
              height: Dimensions.h_50,
              child: Obx(()=>TextFormField(
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: FontSize.sp_11,
                ),
                controller: controller.password,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
        
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                obscureText: controller.isVisible.value,
                cursorColor: Colors.black87,
                decoration: InputDecoration(
                  isDense: true,
                  hintStyle: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: FontSize.sp_10
                  ),
        
                  hintText: "Enter your password",
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    size: Dimensions.h_15,
                    color: Color(0xff00127f)
                  ),
                  suffixIcon: GestureDetector(
                    onTap: (){
                      controller.isVisible.value = !controller.isVisible.value;
                    },
                    child: Obx(()=>Icon(
                      controller.isVisible.value ? Icons.visibility_outlined :Icons.visibility_off_outlined,
                      size: Dimensions.h_15,
                      color: Color(0xff00127f),
                    )),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  errorStyle: TextStyle(
                    color: Colors.red,
                    fontSize: FontSize.sp_8
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: Dimensions.h_1),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                        color: Colors.grey.shade500,
                        width: 0.5
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                        color: Colors.grey.shade500,
                        width: 0.5
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
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
              )),
            ),
            SizedBox(height: Dimensions.h_2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: Dimensions.h_10,
                        width: Dimensions.h_10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                                color: Color(0xff00127f),
                                width: 1
                            )
                        ),
                      ),
                      SizedBox(width: Dimensions.w_6),
                      Text(
                        "Keep me signed in",
                        style: TextStyle(
                          color: Color(0xff00127f),
                          fontSize: FontSize.sp_10,
                          fontWeight: FontWeight.w500
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
              onTap: () {
                if (controller.isLoading.value) return;
                if (controller.formKey.currentState!.validate()) {
                  controller.login();
                }
              },
              child: Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_1,
                  vertical: Dimensions.h_6,
                ),
                decoration: BoxDecoration(
                  color: Color(0xff001dca),
                  borderRadius: BorderRadius.circular(Dimensions.h_4),
                ),
                child: Obx(()=> controller.isLoading.value ? Padding(
                  padding:  EdgeInsets.symmetric(vertical: Dimensions.h_3),
                  child: CupertinoActivityIndicator(
                    color: Colors.white,
                    radius: Dimensions.h_7,
                  ),
                ): Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
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
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward,
                      size: Dimensions.h_18,
                      color: Colors.white,
                    ),
                    SizedBox(width: Dimensions.w_2),
                  ],
                ),
              )),
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
                  "or continue with",
                  style: TextStyle(
                    color: Color(0xff00127f),
                    fontSize: FontSize.sp_9_5,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Create a free account',
                      style: TextStyle(
                        color: Color(0xff0607fa),
                        fontSize: FontSize.sp_10,
                        fontWeight: FontWeight.w600),
                    ),
                     SizedBox(width: Dimensions.w_1),
                    Padding(
                      padding:  EdgeInsets.only(bottom: Dimensions.h_1),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        size: Dimensions.h_10,
                        color: Color(0xff0607fa)),
                    ),
                  ],
                )
        
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfo() {
    final items = [
      (
      icon: CupertinoIcons.news,
      value: '36',
      title: 'New Stories',
      backGround: const Color(0xffcbd9fd),
      iconColor : const Color(0xff021ef2),
      backColor: const Color(0xffeff5fd)
      ),
      (
      icon: CupertinoIcons.chat_bubble_fill,
      value: '18',
      title: 'Discussions',
      backGround: const Color(0xffe9e2fb),
      iconColor: const Color(0xff380262),
      backColor: const Color(0xfff4f2fc)
      ),
      (
      icon: CupertinoIcons.cloud_bolt_rain,
      value: '4',
      title: 'Weather Alerts',
      backGround: const Color(0xffdff4f3),
      iconColor : const Color(0xff001072),
      backColor: const Color(0xfff4f5f9)

      ),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(items.length, (index) {
        final item = items[index];
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: index != items.length - 1 ? Dimensions.w_2 : 0,left: Dimensions.w_2),
            padding: EdgeInsets.only(right: Dimensions.w_1,left: Dimensions.w_6,
                top: Dimensions.h_3,bottom: Dimensions.h_3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: item.backColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color:  item.backGround,
                  ),
                  child: Icon(
                    item.icon,
                    color: item.iconColor,
                    size: Dimensions.h_18,
                  ),
                ),
                SizedBox(width: Dimensions.w_6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.value,
                        style: TextStyle(
                          color: const Color(0xff001072),
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Poppins',
                          fontSize: FontSize.sp_16
                        ),
                      ),
                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xff001072),
                          fontSize: FontSize.sp_8_5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class JourneyItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String? value;
  final String title;

  const JourneyItem({
    super.key,
    required this.icon,
    required this.iconColor,
    this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: Dimensions.h_7,
          backgroundColor: iconColor,
          child: Icon(icon, color: Colors.white, size: Dimensions.h_10),
        ),
        SizedBox(width:Dimensions.w_5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value!,
                style:  TextStyle(
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff001072),
                ),
              ),
              Text(
                title,
                style:  TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: FontSize.sp_8,
                  color: Color(0xff001072)
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ContinueWhereLeftOffWidget extends StatelessWidget {
  const ContinueWhereLeftOffWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "image":
        "https://images.unsplash.com/photo-1519501025264-65ba15a82390?w=500",
        "title": "City Council Meeting",
        "subtitle": "Town Hall Discussion",
        "bottom": "7 new replies",
        "color": Colors.deepPurple,
      },
      {
        "image":
        "https://images.unsplash.com/photo-1504608524841-42fe6f032b4b?w=500",
        "title": "Weather Alert",
        "subtitle": "In Effect",
        "bottom": "Until 8:00 PM",
        "color": Colors.orange,
      },
      {
        "image":
        "https://images.unsplash.com/photo-1504608524841-42fe6f032b4b?w=500",
        "title": "Texas Rangers",
        "subtitle": "Season Updates",
        "bottom": "4 new updates",
        "color": Colors.blue,
      },
      {
        "image": "",
        "title": "Downtown Development",
        "subtitle": "",
        "bottom": "Draft Article",
        "color": Colors.grey,
      },
    ];

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.w_6,
        vertical: Dimensions.h_6,
      ),
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.h_10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.h_10),
        border: Border.all(color: const Color(0xffE8E8E8)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
            child: Row(
              children: [
                Icon(
                  Icons.history,
                  color: const Color(0xff001072),
                  size: Dimensions.h_15,
                ),
                SizedBox(width: Dimensions.w_5),
                Text(
                  "CONTINUE WHERE YOU LEFT OFF",
                  style: TextStyle(
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff001072),
                  ),
                ),
                const Spacer(),
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
                ),
              ],
            ),
          ),

          SizedBox(height: Dimensions.h_10),

          SizedBox(
            height: Dimensions.h_115,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) =>
                  SizedBox(width: Dimensions.w_8),
              itemBuilder: (context, index) {
                final item = items[index];

                return Container(
                  width: Dimensions.w_90,
                  decoration: BoxDecoration(
                    color: Color(0xfff3f5f6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item["image"] != "")
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(4),
                          ),
                          child: AppCacheImage(
                            imageUrl: item["image"] as String,
                            size: Dimensions.h_45,
                            widthSize: Dimensions.w_90,
                            radius: 0,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        Container(
                          height: Dimensions.h_45,
                          decoration: const BoxDecoration(
                            color: Color(0xffF4F5F7),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.description_outlined,
                              color: Colors.grey,
                              size: Dimensions.h_22,
                            ),
                          ),
                        ),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.w_6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["title"] as String,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.sp_9,
                                  color: const Color(0xff001072),
                                ),
                              ),

                              SizedBox(height: Dimensions.h_2),

                              Text(
                                item["subtitle"] as String,
                                style: TextStyle(
                                  fontSize: FontSize.sp_8,
                                  color: Colors.black87,
                                ),
                              ),
                              const Spacer(),
                              if ((item["bottom"] as String).isNotEmpty)
                                Row(
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: item["color"] as Color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.w_4),
                                    Expanded(
                                      child: Text(
                                        item["bottom"] as String,
                                        style: TextStyle(
                                          color: const Color(0xff3158FF),
                                          fontWeight: FontWeight.w600,
                                          fontSize: FontSize.sp_8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CommunityJourneyWidget extends StatelessWidget {
  const CommunityJourneyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {
        "icon": Icons.forum_rounded,
        "color": const Color(0xff4F46E5),
        "title": "Join a Town Hall\ndiscussion",
        "points": "+10 pts",
      },
      {
        "icon": Icons.photo_camera_rounded,
        "color": const Color(0xff16A34A),
        "title": "Upload a local\nphoto",
        "points": "+5 pts",
      },
      {
        "icon": Icons.emoji_people_rounded,
        "color": const Color(0xffF59E0B),
        "title": "Welcome a new\nresident",
        "points": "+3 pts",
      },
    ];

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.w_8,
        vertical: Dimensions.h_6,
      ),
      padding: EdgeInsets.all(Dimensions.w_10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.h_10),
        border: Border.all(color: const Color(0xffE8E8E8)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          /// Header
          Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: const Color(0xff6D28D9),
                size: Dimensions.h_16,
              ),
              SizedBox(width: Dimensions.w_5),
              Text(
                "YOUR COMMUNITY JOURNEY",
                style: TextStyle(
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff001072),
                ),
              ),
              const Spacer(),
              Text(
                "View all",
                style: TextStyle(
                  color: const Color(0xff3158FF),
                  fontWeight: FontWeight.w600,
                  fontSize: FontSize.sp_10,
                ),
              ),
              SizedBox(width: Dimensions.w_2),
              Icon(
                Icons.arrow_forward_ios,
                size: Dimensions.h_8,
                color: const Color(0xff3158FF),
              )
            ],
          ),

          SizedBox(height: Dimensions.h_8),

          /// Top Stats
          Row(
            children: [
              /// Level
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Container(
                      width: Dimensions.h_42,
                      height: Dimensions.h_42,
                      decoration: BoxDecoration(
                        color: const Color(0xff6D28D9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.workspace_premium,
                        color: Colors.white,
                        size: Dimensions.h_22,
                      ),
                    ),
                    SizedBox(width: Dimensions.w_8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Level 3",
                            style: TextStyle(
                              fontSize: FontSize.sp_15,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xff001072),
                            ),
                          ),
                          Text(
                            "Community\nChampion",
                            style: TextStyle(
                              fontSize: FontSize.sp_8,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 1,
                height: 40,
                color: Colors.grey.shade200,
              ),

              Expanded(
                child: _stat(
                  Icons.stars,
                  const Color(0xff7C3AED),
                  "1,250",
                  "Community\nPoints",
                ),
              ),

              Container(
                width: 1,
                height: 40,
                color: Colors.grey.shade200,
              ),

              Expanded(
                child: _stat(
                  Icons.local_fire_department,
                  Colors.orange,
                  "7",
                  "Day Streak",
                ),
              ),

              Container(
                width: 1,
                height: 40,
                color: Colors.grey.shade200,
              ),

              Expanded(
                child: _stat(
                  Icons.bar_chart,
                  Colors.teal,
                  "68%",
                  "to Level 4",
                ),
              ),
            ],
          ),

          SizedBox(height: Dimensions.h_8),

          /// Progress
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: .68,
                    minHeight: 6,
                    backgroundColor: Colors.grey.shade300,
                    color: const Color(0xff7C3AED),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_8),
              Text(
                "68% to Level 4",
                style: TextStyle(
                  fontSize: FontSize.sp_8,
                  color: const Color(0xff16A34A),
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),

          SizedBox(height: Dimensions.h_16),

          /// Fastest Way
          Container(
            padding: EdgeInsets.all(Dimensions.w_8),
            decoration: BoxDecoration(
              color: const Color(0xffFFF7F2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: Dimensions.w_4),
                    Text(
                      "TODAY'S FASTEST WAY TO PROGRESS",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.sp_9,
                        color: const Color(0xff001072),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_4),
                    Icon(
                      Icons.info_outline,
                      size: Dimensions.h_12,
                      color: Colors.grey,
                    )
                  ],
                ),

                SizedBox(height: Dimensions.h_10),

                Row(
                  children: List.generate(tasks.length, (index) {
                    final task = tasks[index];

                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          right: index != tasks.length - 1
                              ? Dimensions.w_6
                              : 0,
                        ),
                        padding: EdgeInsets.all(Dimensions.w_8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              task["icon"] as IconData,
                              color: task["color"] as Color,
                              size: Dimensions.h_18,
                            ),
                            SizedBox(height: Dimensions.h_8),
                            Text(
                              task["title"] as String,
                              style: TextStyle(
                                fontSize: FontSize.sp_8,
                                color: const Color(0xff001072),
                              ),
                            ),
                            SizedBox(height: Dimensions.h_6),
                            Text(
                              task["points"] as String,
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: FontSize.sp_9,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(
      IconData icon,
      Color color,
      String value,
      String title,
      ) {
    return Column(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: color.withOpacity(.12),
          child: Icon(
            icon,
            color: color,
            size: 14,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff001072),
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}