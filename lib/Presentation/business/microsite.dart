import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/constants/appcolor.dart';
import '../../constants/extensions.dart';
import '../../constants/fontsize.dart';
import '../widgets/cache_image.dart';
import '../widgets/common_scaffold.dart';
import '../widgets/common_sliver_scaffold.dart';

class BusinessMicrosite extends StatefulWidget {
  const BusinessMicrosite({super.key});

  @override
  State<BusinessMicrosite> createState() => _BusinessMicrositeState();
}

class _BusinessMicrositeState extends State<BusinessMicrosite> {
  final List<String> tabs = [
    'HOME', 'ABOUT', 'SERVICES', 'PHOTOS', 'REVIEWS',
    // 'UPDATES', 'PROJECTS', 'OFFERS', 'Q&A'
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return AppScaffold(
      top: false,
      bottom: false,
      bodyPadding: EdgeInsets.zero,
      backgroundColor: context.sports.background,
      body: CommonScrollBlurScaffold(
        expandedHeight: Dimensions.h_185,
        showBack: true,
        expandedColor: Colors.white,
        collapsedColor: Theme.of(context).highlightColor,
        hero: buildHeroHeader(isLight),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: Dimensions.h_25,
              width: double.infinity,
              color: const Color(0xFF04352B),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4),
              child: Marquee(
                text: '• OPEN NOW UNTIL 6:00 PM     |    • (555) 123-4567      |    • 45 OAK STREET, MAPLEWOOD        |    • SERVING MAPLEWOOD + 7 NEARBY TOWNS',
                style: TextStyle(color: Colors.white, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, letterSpacing: 0.8, height: 1),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                blankSpace: Dimensions.w_20,
                velocity: 25,
                pauseAfterRound: Duration.zero,
                startPadding: 0,
                accelerationDuration: Duration.zero,
                decelerationDuration: Duration.zero,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.h_10),
                  Container(
                    height: Dimensions.h_25,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: isLight ? Colors.grey : Colors.white54, width: isLight ? 0.6 : 0.6),
                      ),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: tabs.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (c, index) {
                        final isSelected = selectedIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: Dimensions.w_8),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                            decoration: BoxDecoration(
                              border: isSelected ? Border(bottom: BorderSide(color: context.sports.green, width: 3)) : Border(bottom: BorderSide(color: Colors.transparent, width: 3)),
                            ),
                            child: Text(
                              tabs[index],
                              style: TextStyle(color: isSelected ? context.sports.green : Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700, height: 1),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: selectedIndex == 1 ? Dimensions.h_8 : Dimensions.h_15),
                  body(isLight),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: Dimensions.h_20)),
        ],
      ),
    );
  }

  Widget body(bool isLight) {
    switch (selectedIndex) {
      case 0:
        return home(isLight);
      case 1:
        return aboutUs(isLight);
      case 2:
        return services();
      case 3:
        return photos();
      case 4:
        return review();
      default:
        return SizedBox();
    }
  }

  Widget home(bool isLight) {
    final List<Services> list = [
      Services(title: 'Lawn Care', image: 'https://preetis-html.vercel.app/assets/images/microsite/business-pro/lawn-care.webp'),
      Services(title: 'Landscape Design', image: 'https://preetis-html.vercel.app/assets/images/microsite/business-pro/landscape-design.webp'),
      Services(title: 'Hard Scrapping', image: 'https://preetis-html.vercel.app/assets/images/microsite/business-pro/stone-patio.webp'),
      Services(title: 'Seasonal', image: 'https://preetis-html.vercel.app/assets/images/microsite/business-pro/garden-path.webp'),
    ];

    final List<String> imageList = [
      'https://preetis-html.vercel.app/assets/images/microsite/business-pro/lawn-care.webp',
      'https://preetis-html.vercel.app/assets/images/microsite/business-pro/landscape-design.webp',
      'https://preetis-html.vercel.app/assets/images/microsite/business-pro/stone-patio.webp',
      'https://preetis-html.vercel.app/assets/images/microsite/business-pro/garden-path.webp',
    ];

    final List<String> localList = ['Locally Owned & Operated', 'Licensed & Insured', '5+ Years in Business', 'Highly Rated by Locals'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Latest Update".toUpperCase(),
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1),
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/microsite/business-pro/landscape-design.webp', widthSize: Dimensions.h_120, size: Dimensions.h_90, isShadow: false),
              SizedBox(width: Dimensions.w_10),
              Expanded(
                child: SizedBox(
                  height: Dimensions.h_90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Spring is here!",
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: Dimensions.h_5),
                      Text(
                        'Now booking lawn cleanups and landscape refreshes. Contact us today!',
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            '2 days ago',
                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8_5, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                          ),
                          SizedBox(width: Dimensions.w_5),
                          Container(
                            height: Dimensions.h_2,
                            width: Dimensions.h_2,
                            decoration: BoxDecoration(color: Theme.of(context).highlightColor, shape: BoxShape.circle),
                          ),
                          SizedBox(width: Dimensions.w_5),
                          Text(
                            '24 Likes',
                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8_5, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                          ),
                          SizedBox(width: Dimensions.w_5),
                          Container(
                            height: Dimensions.h_2,
                            width: Dimensions.h_2,
                            decoration: BoxDecoration(color: Theme.of(context).highlightColor, shape: BoxShape.circle),
                          ),
                          SizedBox(width: Dimensions.w_5),
                          Text(
                            '24 Comments',
                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8_5, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
          decoration: BoxDecoration(color: const Color(0xff18795c), borderRadius: BorderRadius.circular(Dimensions.h_10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Is this your business?",
                      style: TextStyle(color: Colors.white, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w900, height: 1),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.w_5, top: Dimensions.h_5),
                      child: Text(
                        "Claim this free microsite to connect with local customers.",
                        style: TextStyle(color: Colors.white, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, height: 1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: Dimensions.w_10),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.h_5),
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_8),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(999)),
                  child: Center(
                    child: Text(
                      "CLAIM THIS BUSINESS",
                      style: TextStyle(color: const Color(0xff18795c), fontSize: FontSize.sp_9, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Our Services".toUpperCase(),
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                selectedIndex = 2;
                setState(() {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "View all",
                    style: TextStyle(color: context.sports.green, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700, height: 1),
                  ),
                  SizedBox(width: Dimensions.w_2),
                  Icon(Icons.arrow_forward, color: context.sports.green, size: Dimensions.h_12),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (c, i) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                AppCacheImage(imageUrl: list[i].image, widthSize: Get.width, size: Dimensions.h_120, isShadow: false, radius: Dimensions.h_10),
                Positioned(
                  top: Dimensions.h_5,
                  left: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h_1, horizontal: Dimensions.w_6),
                    decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.h_4)),
                    child: Text(
                      list[i].title.toUpperCase(),
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8, mainAxisExtent: Dimensions.h_120),
        ),
        SizedBox(height: Dimensions.h_20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Photos of our work".toUpperCase(),
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                selectedIndex = 3;
                setState(() {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "View all",
                    style: TextStyle(color: context.sports.green, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700, height: 1),
                  ),
                  SizedBox(width: Dimensions.w_2),
                  Icon(Icons.arrow_forward, color: context.sports.green, size: Dimensions.h_12),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: imageList.length,
          itemBuilder: (c, i) {
            return AppCacheImage(imageUrl: imageList[i], widthSize: Get.width, size: Dimensions.h_117, isShadow: false,radius: Dimensions.h_10);
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8, mainAxisExtent: Dimensions.h_135),
        ),
        SizedBox(height: Dimensions.h_20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "About Us".toUpperCase(),
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                selectedIndex = 1;
                setState(() {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Learn more about us",
                    style: TextStyle(color: context.sports.green, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700, height: 1),
                  ),
                  SizedBox(width: Dimensions.w_2),
                  Icon(Icons.arrow_forward, color: context.sports.green, size: Dimensions.h_12),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: Dimensions.w_10, top: Dimensions.h_2),
                    height: Dimensions.h_6,
                    width: Dimensions.h_6,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: context.sports.green),
                  ),
                  Text(
                    "Lawn Care & Maintenance",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: Dimensions.w_10, top: Dimensions.h_2),
                    height: Dimensions.h_6,
                    width: Dimensions.h_6,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: context.sports.green),
                  ),
                  Text(
                    "Landscape Design",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: Dimensions.w_10, top: Dimensions.h_2),
                    height: Dimensions.h_6,
                    width: Dimensions.h_6,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: context.sports.green),
                  ),
                  Text(
                    "Tree & Shrub Care",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: Dimensions.w_10, top: Dimensions.h_2),
                    height: Dimensions.h_6,
                    width: Dimensions.h_6,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: context.sports.green),
                  ),
                  Text(
                    "Hardscaping & Patios",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: Dimensions.w_10, top: Dimensions.h_2),
                    height: Dimensions.h_6,
                    width: Dimensions.h_6,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: context.sports.green),
                  ),
                  Text(
                    "Seasonal Cleanups",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_20),
        Text(
          "Contact Information".toUpperCase(),
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1),
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.phone, size: Dimensions.h_12, color: context.sports.green),
                  SizedBox(width: Dimensions.w_8),
                  Text(
                    "(555) 123-4567",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.mail_solid, size: Dimensions.h_12, color: context.sports.green),
                  SizedBox(width: Dimensions.w_8),
                  Text(
                    "info@greenleaf.com",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.globe, size: Dimensions.h_12, color: context.sports.green),
                  SizedBox(width: Dimensions.w_8),
                  Text(
                    "greenleaflandscaping.com",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.mapLocation, size: Dimensions.h_12, color: context.sports.green),
                  SizedBox(width: Dimensions.w_8),
                  Text(
                    "45 Oak Street, Maplewood",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_20),
        Text(
          "Business hours".toUpperCase(),
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1),
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(CupertinoIcons.time, size: Dimensions.h_12, color: context.sports.green),
                      SizedBox(width: Dimensions.w_8),
                      Text(
                        "Mon-Fri",
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                      ),
                    ],
                  ),
                  Text(
                    "7:00–6:00",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(CupertinoIcons.time, size: Dimensions.h_12, color: context.sports.green),
                      SizedBox(width: Dimensions.w_8),
                      Text(
                        "Saturday",
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                      ),
                    ],
                  ),
                  Text(
                    "8:00–2:00",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(CupertinoIcons.time, size: Dimensions.h_12, color: context.sports.green),
                      SizedBox(width: Dimensions.w_8),
                      Text(
                        "Sunday",
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                      ),
                    ],
                  ),
                  Text(
                    "Closed",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Community Reviews".toUpperCase(),
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                selectedIndex = 4;
                setState(() {});
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "See all",
                    style: TextStyle(color: context.sports.green, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700, height: 1),
                  ),
                  SizedBox(width: Dimensions.w_2),
                  Icon(Icons.arrow_forward, color: context.sports.green, size: Dimensions.h_12),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Dimensions.h_30,
                width: Dimensions.h_30,
                decoration: BoxDecoration(color: Color(0xFFdceddf), shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    'J',
                    style: TextStyle(color: const Color(0xff18795c), fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w900, height: 1),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.w_10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jessica M.',
                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800, height: 1),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              5,
                              (index) => Padding(
                                padding: EdgeInsets.only(right: Dimensions.w_2),
                                child: Icon(CupertinoIcons.star_fill, size: Dimensions.h_10, color: context.sports.yellow),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.h_6),
                    Text(
                      'Amazing work on our patio and garden. Professional, reliable, and beautiful results.',
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Dimensions.h_30,
                width: Dimensions.h_30,
                decoration: BoxDecoration(color: Color(0xFFdceddf), shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    'M',
                    style: TextStyle(color: const Color(0xff18795c), fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w900, height: 1),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.w_10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Michael R.',
                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800, height: 1),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              5,
                              (index) => Padding(
                                padding: EdgeInsets.only(right: Dimensions.w_2),
                                child: Icon(CupertinoIcons.star_fill, size: Dimensions.h_10, color: context.sports.yellow),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.h_6),
                    Text(
                      'Great attention to detail and excellent communication. Highly recommend!',
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Why Locals Choose Us".toUpperCase(),
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1),
              ),
              SizedBox(height: Dimensions.h_10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: localList.length,
                padding: EdgeInsets.only(left: Dimensions.w_8),
                itemBuilder: (c, i) {
                  return Padding(
                    padding: EdgeInsets.only(top: Dimensions.h_5, bottom: Dimensions.h_5),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.check_mark, size: Dimensions.h_12, color: context.sports.green),
                        SizedBox(width: Dimensions.w_8),
                        Text(
                          localList[i],
                          style: TextStyle(color: context.sports.green, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, height: 1),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
          width: Get.width,
          decoration: BoxDecoration(
            color: isLight ? Color(0xFFedf7f1) : Color(0xFF19332a),
            border: Border.all(color: context.sports.green, width: 0.3),
            borderRadius: BorderRadius.circular(Dimensions.h_8),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(Dimensions.w_8, Dimensions.h_10, Dimensions.w_8, Dimensions.h_5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stay Connected. Get Local Updates.',
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800, height: 1.12),
                ),
                SizedBox(height: Dimensions.h_10),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.w_8),
                  child: Text(
                    'Follow for seasonal tips, announcements, and new offers',
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400, height: 1.12),
                  ),
                ),
                Container(
                  width: Dimensions.w_185,
                  padding: EdgeInsets.symmetric(vertical: Dimensions.h_10, horizontal: Dimensions.w_15),
                  margin: EdgeInsets.only(top: Dimensions.h_20, bottom: Dimensions.h_10, left: Dimensions.w_8),
                  decoration: BoxDecoration(color: const Color(0xff18795c), borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Follow Updates'.toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget aboutUs(bool isLight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "About Us".toUpperCase(),
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_6),
                decoration: BoxDecoration(color: context.sports.green, borderRadius: BorderRadius.circular(50)),
                child: Center(
                  child: Text(
                    "Ask a Question".toUpperCase(),
                    style: TextStyle(color: isLight ? Colors.white : Colors.black87, fontSize: FontSize.sp_9, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        Padding(
          padding: EdgeInsets.only(left: Dimensions.w_5),
          child: Text(
            'Locally owned and operated landscaping company proudly serving Maplewood and surrounding communities.',
            style: TextStyle(color: Theme.of(context).highlightColor.withValues(alpha: 0.80), fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1.2),
          ),
        ),
        SizedBox(height: Dimensions.h_15),
        Row(
          children: [
            Text(
              "312 Projects Completed".toUpperCase(),
              style: TextStyle(color: context.sports.green, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w800, height: 1),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
              height: Dimensions.h_15,
              width: 0.5,
              color: Theme.of(context).highlightColor,
            ),
            Text(
              "8 Towns served".toUpperCase(),
              style: TextStyle(color: context.sports.green, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w800, height: 1),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.w_6),
              height: Dimensions.h_15,
              width: 0.5,
              color: Theme.of(context).highlightColor,
            ),
            Text(
              "98% Recommend".toUpperCase(),
              style: TextStyle(color: context.sports.green, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w800, height: 1),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: Dimensions.w_10, top: Dimensions.h_2),
                    height: Dimensions.h_6,
                    width: Dimensions.h_6,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: context.sports.green),
                  ),
                  Text(
                    "Lawn Care & Maintenance",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w600, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: Dimensions.w_10, top: Dimensions.h_2),
                    height: Dimensions.h_6,
                    width: Dimensions.h_6,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: context.sports.green),
                  ),
                  Text(
                    "Landscape Design",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w600, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: Dimensions.w_10, top: Dimensions.h_2),
                    height: Dimensions.h_6,
                    width: Dimensions.h_6,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: context.sports.green),
                  ),
                  Text(
                    "Tree & Shrub Care",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w600, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: Dimensions.w_10, top: Dimensions.h_2),
                    height: Dimensions.h_6,
                    width: Dimensions.h_6,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: context.sports.green),
                  ),
                  Text(
                    "Hardscaping & Patios",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w600, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: Dimensions.w_10, top: Dimensions.h_2),
                    height: Dimensions.h_6,
                    width: Dimensions.h_6,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: context.sports.green),
                  ),
                  Text(
                    "Seasonal Cleanups",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w600, height: 1),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_25),
        Text(
          "Contact Information".toUpperCase(),
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1),
        ),
        CommonCard(
          isBorder: false,
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.phone, size: Dimensions.h_12, color: context.sports.green),
                  SizedBox(width: Dimensions.w_8),
                  Text(
                    "(555) 123-4567",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.mail_solid, size: Dimensions.h_12, color: context.sports.green),
                  SizedBox(width: Dimensions.w_8),
                  Text(
                    "info@greenleaf.com",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.globe, size: Dimensions.h_12, color: context.sports.green),
                  SizedBox(width: Dimensions.w_8),
                  Text(
                    "greenleaflandscaping.com",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.mapLocation, size: Dimensions.h_12, color: context.sports.green),
                  SizedBox(width: Dimensions.w_8),
                  Text(
                    "45 Oak Street, Maplewood",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_20),
        Text(
          "Business hours".toUpperCase(),
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1),
        ),
        CommonCard(
          isBorder: false,
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(CupertinoIcons.time, size: Dimensions.h_12, color: context.sports.green),
                      SizedBox(width: Dimensions.w_8),
                      Text(
                        "Mon-Fri",
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                      ),
                    ],
                  ),
                  Text(
                    "7:00–6:00",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(CupertinoIcons.time, size: Dimensions.h_12, color: context.sports.green),
                      SizedBox(width: Dimensions.w_8),
                      Text(
                        "Saturday",
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                      ),
                    ],
                  ),
                  Text(
                    "8:00–2:00",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(CupertinoIcons.time, size: Dimensions.h_12, color: context.sports.green),
                      SizedBox(width: Dimensions.w_8),
                      Text(
                        "Sunday",
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                      ),
                    ],
                  ),
                  Text(
                    "Closed",
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget services() {
    final List<Services> list = [
      Services(title: 'Lawn Care', image: 'https://preetis-html.vercel.app/assets/images/microsite/business-pro/lawn-care.webp'),
      Services(title: 'Landscape Design', image: 'https://preetis-html.vercel.app/assets/images/microsite/business-pro/landscape-design.webp'),
      Services(title: 'Hard Scrapping', image: 'https://preetis-html.vercel.app/assets/images/microsite/business-pro/stone-patio.webp'),
      Services(title: 'Seasonal', image: 'https://preetis-html.vercel.app/assets/images/microsite/business-pro/garden-path.webp'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Our Services".toUpperCase(),
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1),
        ),
        SizedBox(height: Dimensions.h_10),
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (c, i) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                AppCacheImage(imageUrl: list[i].image, widthSize: Get.width, size: Dimensions.h_120, isShadow: false, radius: Dimensions.h_10),
                Positioned(
                  top: Dimensions.h_5,
                  left: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h_1, horizontal: Dimensions.w_6),
                    decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.h_4)),
                    child: Text(
                      list[i].title.toUpperCase(),
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8, mainAxisExtent: Dimensions.h_120),
        ),
      ],
    );
  }

  Widget photos() {
    final List<String> imageList = [
      'https://preetis-html.vercel.app/assets/images/microsite/business-pro/lawn-care.webp',
      'https://preetis-html.vercel.app/assets/images/microsite/business-pro/landscape-design.webp',
      'https://preetis-html.vercel.app/assets/images/microsite/business-pro/stone-patio.webp',
      'https://preetis-html.vercel.app/assets/images/microsite/business-pro/garden-path.webp',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Photos of our work".toUpperCase(),
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1),
        ),
        SizedBox(height: Dimensions.h_10),
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: imageList.length,
          itemBuilder: (c, i) {
            return AppCacheImage(imageUrl: imageList[i], widthSize: Get.width, size: Dimensions.h_117, isShadow: false, radius: Dimensions.h_10);
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8, mainAxisExtent: Dimensions.h_120),
        ),
      ],
    );
  }

  Widget review() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Community Reviews (4)".toUpperCase(),
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w800, height: 1),
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Dimensions.h_30,
                width: Dimensions.h_30,
                decoration: BoxDecoration(color: Color(0xFFdceddf), shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    'J',
                    style: TextStyle(color: const Color(0xff18795c), fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w900, height: 1),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.w_10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jessica M.',
                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800, height: 1),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              5,
                              (index) => Padding(
                                padding: EdgeInsets.only(right: Dimensions.w_2),
                                child: Icon(CupertinoIcons.star_fill, size: Dimensions.h_10, color: context.sports.yellow),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.h_3),
                    Text(
                      'Amazing work on our patio and garden. Professional, reliable, and beautiful results.',
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Dimensions.h_30,
                width: Dimensions.h_30,
                decoration: BoxDecoration(color: Color(0xFFdceddf), shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    'M',
                    style: TextStyle(color: const Color(0xff18795c), fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w900, height: 1),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.w_10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Michael R.',
                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800, height: 1),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              5,
                              (index) => Padding(
                                padding: EdgeInsets.only(right: Dimensions.w_2),
                                child: Icon(CupertinoIcons.star_fill, size: Dimensions.h_10, color: context.sports.yellow),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.h_3),
                    Text(
                      'Great attention to detail and excellent communication. Highly recommend!',
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Dimensions.h_30,
                width: Dimensions.h_30,
                decoration: BoxDecoration(color: Color(0xFFdceddf), shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    'R',
                    style: TextStyle(color: const Color(0xff18795c), fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w900, height: 1),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.w_10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ron K.',
                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800, height: 1),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              5,
                              (index) => Padding(
                                padding: EdgeInsets.only(right: Dimensions.w_2),
                                child: Icon(CupertinoIcons.star_fill, size: Dimensions.h_10, color: context.sports.yellow),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.h_3),
                    Text(
                      'Amazing work on our patio and garden. Professional, reliable, and beautiful results.',
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Dimensions.h_30,
                width: Dimensions.h_30,
                decoration: BoxDecoration(color: Color(0xFFdceddf), shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    'M',
                    style: TextStyle(color: const Color(0xff18795c), fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w900, height: 1),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.w_10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mike T.',
                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800, height: 1),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              5,
                              (index) => Padding(
                                padding: EdgeInsets.only(right: Dimensions.w_2),
                                child: Icon(CupertinoIcons.star_fill, size: Dimensions.h_10, color: context.sports.yellow),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.h_3),
                    Text(
                      'Great attention to detail and excellent communication. Highly recommend!',
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildHeroHeader(bool isLight) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/microsite/business-pro/garden-path-sm.webp', widthSize: Get.width, size: Dimensions.h_310, radius: 0),
        Positioned(
          child: Container(
            height: Dimensions.h_312,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xE6020B15).withValues(alpha: 0.90), Color(0x99020B15).withValues(alpha: 0.65), Color(0x99020B15).withValues(alpha: 0.55), Color(0x99020B15).withValues(alpha: 0.45), Color(0x00000000)], stops: const [0.08, 0.35, 0.55, 0.78, 1]),
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.h_312,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              SizedBox(height: Dimensions.h_60),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(width: Dimensions.w_8),
                  // Container(
                  //   height: Dimensions.h_60,
                  //   width: Dimensions.h_60,
                  //   decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  //   child: Center(
                  //     child: FaIcon(FontAwesomeIcons.leaf,size: Dimensions.h_25,color: context.sports.green),
                  //   ),
                  // ),
                  SizedBox(width: Dimensions.w_8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: Dimensions.w_8, right: Dimensions.w_40),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Text(
                                'Green Leaf Landscaping',
                                style: TextStyle(color: Colors.white, fontSize: FontSize.sp_24, fontWeight: FontWeight.w900, height: 1),
                              ),
                              Positioned(
                                right: -Dimensions.w_25,
                                child: Container(
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                  child: Icon(Icons.verified_sharp, size: Dimensions.h_18, color: AppColor.accentBlue),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.h_5),
                        Padding(
                          padding: EdgeInsets.only(left: Dimensions.w_8, right: Dimensions.w_40),
                          child: Text(
                            maxLines: 4,
                            'Beautiful outdoor spaces. Lasting relationships.',
                            style: TextStyle(color: Colors.white, fontSize: FontSize.sp_12, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: Dimensions.h_8),
                        Row(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: Dimensions.w_8),
                                FaIcon(FontAwesomeIcons.phone, size: Dimensions.h_10, color: Colors.white),
                                SizedBox(width: Dimensions.w_8),
                                Text(
                                  "(555) 123-4567",
                                  style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w900, height: 1),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: Dimensions.w_15),
                              height: Dimensions.h_15,
                              width: 1,
                              color: Colors.white,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: Dimensions.w_2),
                                Icon(CupertinoIcons.mail_solid, size: Dimensions.h_12, color: Colors.white),
                                SizedBox(width: Dimensions.w_8),
                                Text(
                                  "info@greenleaf.com",
                                  style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w900, height: 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_8),
                        Row(
                          children: [
                            SizedBox(width: Dimensions.w_8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                5,
                                (index) => Padding(
                                  padding: EdgeInsets.only(right: Dimensions.w_2),
                                  child: Icon(CupertinoIcons.star_fill, size: Dimensions.h_11, color: Color(0xFFffcf56)),
                                ),
                              ),
                            ),
                            SizedBox(width: Dimensions.w_8),
                            Text(
                              '4.9 (128 reviews)',
                              style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8),
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_8),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xff18795c), Color(0xff08733f)]),
                            border: Border.all(color: const Color(0xff18795c), width: 1),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [BoxShadow(color: const Color(0xff08733f).withValues(alpha: 0.18), offset: const Offset(0, 7), blurRadius: 16, spreadRadius: 0)],
                          ),
                          child: Center(
                            child: Text(
                              "FOLLOW BUSINESS",
                              style: TextStyle(color: Colors.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_8),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
                        decoration: BoxDecoration(
                          color: const Color(0xE0041D16),
                          border: Border.all(color: const Color(0xff18795c), width: 1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            "REQUEST FREE ESTIMATE",
                            style: TextStyle(color: Colors.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_8),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_10),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: Dimensions.h_15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [context.sports.background.withValues(alpha: 0.0), context.sports.background.withValues(alpha: 0.15), context.sports.background.withValues(alpha: 0.35), context.sports.background.withValues(alpha: 0.78), context.sports.background],
                stops: const [0.08, 0.25, 0.45, 0.75, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Services {
  final String image;
  final String title;

  const Services({required this.title, required this.image});
}
