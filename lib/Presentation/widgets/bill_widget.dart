import 'package:carousel_slider_plus/carousel_controller.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/appcolor.dart';
import '../../constants/fontsize.dart';

class LegislativeBillsSection extends StatefulWidget {
  const LegislativeBillsSection({
    super.key,
    required this.isLight,
  });

  final bool isLight;

  @override
  State<LegislativeBillsSection> createState() =>
      _LegislativeBillsSectionState();
}

class _LegislativeBillsSectionState extends State<LegislativeBillsSection> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;
  bool get isLight => widget.isLight;
  final List<Map<String, dynamic>> _bills = [
    {
      'type': 'priority',
    },
    {
      'type': 'bill',
      'title': 'Transportation Benefit District Act',
      'billNumber': 'S.B. 5442',
      'tags': ['HIGH ACTIVITY', 'CITY'],
      'status': 'In Committee',
      'date': 'Yesterday',
      'description':
      'Creates a Transportation Benefit District for local transportation improvements.',
      'impact': 'High',
      'responses': '6 of 8',
      'followers': '1.2K following',
      'approachingVote': false,
    },
    {
      'type': 'bill',
      'title': 'Middle Housing Expansion',
      'billNumber': 'ORD. 2024-27',
      'tags': [
        'VOTE APPROACHING',
        'NEW THIS WEEK',
        'COUNTY',
      ],
      'status': 'Approaching Vote',
      'date': '2 days ago',
      'description':
      'Expands middle housing options in unincorporated areas.',
      'impact': 'High',
      'responses': '5 of 5',
      'followers': '1.1K following',
      'approachingVote': true,
    },
    {
      'type': 'bill',
      'title': 'Clean Water Infrastructure Act',
      'billNumber': 'H.R. 3922',
      'tags': [
        'HIGH ACTIVITY',
        'FEDERAL',
      ],
      'status': 'In Committee',
      'date': '3 days ago',
      'description':
      'Invests in clean water infrastructure and protection programs.',
      'impact': 'Medium',
      'responses': '2 of 5',
      'followers': '1.1K following',
      'approachingVote': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'LEGISLATIVE BILLS IMPACTING ISSAQUAH',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isLight
                      ? AppColor.townHallGreen
                      : AppColor.townHallGreenDark,
                  fontSize: FontSize.sp_11,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
            ),
            SizedBox(width: Dimensions.w_5),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w_8,
                vertical: Dimensions.h_4,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.h_4)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'All Levels',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: FontSize.sp_9,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),
                  SizedBox(width: Dimensions.w_2),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: Dimensions.h_13,
                    color:
                    Theme.of(context).primaryColorDark,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_6),
        SizedBox(
          height: Dimensions.h_220,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CarouselSlider.builder(
                controller: _carouselController,
                itemCount: _bills.length,
                options: CarouselOptions(
                  height: Dimensions.h_220,
                  viewportFraction: 0.7,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.1,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                itemBuilder: (
                    BuildContext context,
                    int index,
                    int realIndex,
                    ) {
                  final bill = _bills[index];
                  if (bill['type'] == 'priority') {
                    return _buildPriorityCard();
                  }

                  return CommonBillCard(
                    title: bill['title'],
                    billNumber: bill['billNumber'],
                    tags: List<String>.from(
                      bill['tags'],
                    ),
                    status: bill['status'],
                    date: bill['date'],
                    description: bill['description'],
                    impact: bill['impact'],
                    responses: bill['responses'],
                    followers: bill['followers'],
                    isApproachingVote:
                    bill['approachingVote'] ?? false,
                    onFollow: () {
                      _onFollow(index);
                    },
                    onDetails: () {
                      _onDetails(index);
                    },
                  );
                },
              ),
                Positioned(
                  left: -Dimensions.w_6,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _navigationButton(
                      icon: Icons.chevron_left_rounded,
                      onTap: () {
                        _carouselController.previousPage();
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: -Dimensions.w_6,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _navigationButton(
                      icon: Icons.chevron_right_rounded,
                      onTap: () {
                        _carouselController.nextPage();
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _bills.length,
                (index) {
              final selected = index == _currentIndex;
              return AnimatedContainer(
                duration: const Duration(
                  milliseconds: 180,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_2,
                ),
                width: selected
                    ? Dimensions.w_7
                    : Dimensions.w_4,
                height: Dimensions.h_4,
                decoration: BoxDecoration(
                  color: selected
                      ? Theme.of(context).primaryColorDark
                      : Theme.of(context)
                      .highlightColor
                      .withValues(alpha: 0.20),
                  borderRadius:
                  BorderRadius.circular(20),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPriorityCard() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.w_2,
      ),
      padding: EdgeInsets.all(
        Dimensions.w_8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.h_6),
        border: Border.all(color: Theme.of(context).focusColor)),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            'PRIORITY (Urgency)',
            style: TextStyle(
              color:
              Theme.of(context).primaryColorDark,
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: Dimensions.h_8),
          _priorityRow(
            color: Colors.red,
            title: 'Vote Approaching',
            trailing: '< 30 days',
          ),

          SizedBox(height: Dimensions.h_6),
          _priorityRow(
            color: Colors.green,
            title: 'Public Hearing',
            trailing: '30–60 days',
          ),
          SizedBox(height: Dimensions.h_6),
          _priorityRow(
            color: Theme.of(context)
                .primaryColorDark,
            title: 'Early Stage',
            trailing: '60+ days',
          ),
          SizedBox(height: Dimensions.h_8),
          Padding(
            padding:  EdgeInsets.only(left: Dimensions.w_8),
            child: Text(
              'Proposes increased funding for parks maintenance and improvements.',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color:
                Theme.of(context).highlightColor,
                fontSize: FontSize.sp_9_5,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: _infoItem(
                  title: 'Impact',
                  value: 'High',
                ),
              ),
              Expanded(
                child: _infoItem(
                  title: 'Rep. Responses',
                  value: '5 of 7',
                ),
              ),
            ],
          ),

          SizedBox(height: Dimensions.h_6),

          Row(
            children: [
              Icon(
                CupertinoIcons.person_2_fill,
                color: AppColor.townHallGreen,
                size: Dimensions.h_12,
              ),
              SizedBox(width: Dimensions.w_3),
              Text(
                '865 following',
                style: TextStyle(
                  color:
                  Theme.of(context).primaryColor,
                  fontSize: FontSize.sp_9_5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          SizedBox(height: Dimensions.h_7),

          _actionButtons(
            onFollow: () {},
            onDetails: () {},
          ),
        ],
      ),
    );
  }

  Widget _priorityRow({
    required Color color,
    required String title,
    required String trailing,
  }) {
    return Row(
      children: [
        Container(
          width: Dimensions.h_6,
          height: Dimensions.h_6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: Dimensions.w_5),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color:
              Theme.of(context).primaryColor,
              fontSize: FontSize.sp_9_5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          trailing,
          style: TextStyle(
            color: Theme.of(context)
                .primaryColorDark,
            fontSize: FontSize.sp_9_5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _infoItem({
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color:
            Theme.of(context).highlightColor,
            fontSize: FontSize.sp_9_5,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: Dimensions.h_2),
        Text(
          value,
          style: TextStyle(
            color:
            Theme.of(context).primaryColor,
            fontSize: FontSize.sp_9_5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _navigationButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: Dimensions.w_23,
        height: Dimensions.w_23,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context)
                .highlightColor
                .withValues(alpha: 0.15),
          ),
          boxShadow: [
            BoxShadow(
              color:
              Colors.black.withValues(alpha: 0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: Dimensions.h_15,
          color:
          Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }

  void _onFollow(int index) {
    debugPrint(
      'Follow: ${_bills[index]['title']}',
    );
  }

  void _onDetails(int index) {
    debugPrint(
      'Details: ${_bills[index]['title']}',
    );
  }
}

class CommonBillCard extends StatelessWidget {
  final String title;
  final String billNumber;
  final List<String> tags;
  final String status;
  final String date;
  final String description;
  final String impact;
  final String responses;
  final String followers;
  final bool isApproachingVote;

  final VoidCallback? onFollow;
  final VoidCallback? onDetails;

  const CommonBillCard({
    super.key,
    required this.title,
    required this.billNumber,
    required this.tags,
    required this.status,
    required this.date,
    required this.description,
    required this.impact,
    required this.responses,
    required this.followers,
    this.isApproachingVote = false,
    this.onFollow,
    this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.w_2,
      ),
      padding: EdgeInsets.all(
        Dimensions.w_8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.h_6),
        border: Border.all(color: Theme.of(context).focusColor),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: Dimensions.w_3,
                  runSpacing: Dimensions.h_2,
                  children: tags.map((tag) {
                    return _buildTag(
                      context,
                      tag,
                    );
                  }).toList(),
                ),
              ),
              SizedBox(width: Dimensions.w_3),
              Row(
                mainAxisSize:
                MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.clock,
                    size: Dimensions.h_10,
                    color: Theme.of(context).highlightColor),
                  SizedBox(width: Dimensions.w_2),
                  Text(
                    billNumber,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: FontSize.sp_9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_10),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color:
              Theme.of(context).primaryColor,
              fontSize: FontSize.sp_14,
              fontWeight: FontWeight.w800,
              height: 1.05,
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w_5,
                  vertical: Dimensions.h_3,
                ),
                decoration: BoxDecoration(
                  color: isApproachingVote
                      ? const Color(0xFFFFE8DA)
                      : Theme.of(context)
                      .primaryColorDark
                      .withValues(alpha: 0.08),
                  borderRadius:
                  BorderRadius.circular(3),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isApproachingVote
                        ? const Color(0xFFC65A19)
                        : Theme.of(context)
                        .primaryColorDark,
                    fontSize: FontSize.sp_9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_5),
              Text(
                date,
                style: TextStyle(
                  color: Theme.of(context)
                      .highlightColor,
                  fontSize: FontSize.sp_9,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_10),
          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context)
                  .highlightColor,
              fontSize: FontSize.sp_10,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
          const Spacer(),
          SizedBox(height: Dimensions.h_8),
          Row(
            children: [
              Expanded(
                child: _billInfo(
                  context,
                  title: 'Impact',
                  value: impact,
                ),
              ),
              Expanded(
                child: _billInfo(
                  context,
                  title: 'Rep. Responses',
                  value: responses,
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_6),
          Row(
            children: [
              Icon(
                CupertinoIcons.person_2_fill,
                color: AppColor.townHallGreen,
                size: Dimensions.h_12,
              ),
              SizedBox(width: Dimensions.w_3),
              Text(
                followers,
                style: TextStyle(
                  color: Theme.of(context)
                      .primaryColor,
                  fontSize: FontSize.sp_9_5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_7),
          _actionButtons(
            context: context,
            onFollow: onFollow,
            onDetails: onDetails,
          ),
        ],
      ),
    );
  }

  Widget _billInfo(
      BuildContext context, {
        required String title,
        required String value,
      }) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color:
            Theme.of(context).highlightColor,
            fontSize: FontSize.sp_9_5,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color:
            Theme.of(context).primaryColor,
            fontSize: FontSize.sp_10,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildTag(
      BuildContext context,
      String tag,
      ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w_4,
        vertical: Dimensions.h_2,
      ),
      decoration: BoxDecoration(
        color: _tagColor(tag),
        borderRadius:
        BorderRadius.circular(3),
      ),
      child: Text(
        tag,
        style:  TextStyle(
          color: Colors.white,
          fontSize: FontSize.sp_7,
          fontWeight: FontWeight.w900,
          height: 1,
        ),
      ),
    );
  }

  Color _tagColor(String tag) {
    switch (tag.toUpperCase()) {
      case 'HIGH ACTIVITY':
        return const Color(0xFFC94D12);

      case 'CITY':
        return const Color(0xFF23784D);

      case 'VOTE APPROACHING':
        return const Color(0xFFD52D2D);

      case 'NEW THIS WEEK':
        return const Color(0xFF2861D5);

      case 'COUNTY':
        return const Color(0xFFC65B0C);

      case 'FEDERAL':
        return const Color(0xFF2D60C9);

      default:
        return Theme.of(Get.context!).primaryColorDark;
    }
  }
}

Widget _actionButtons({
  required VoidCallback? onFollow,
  required VoidCallback? onDetails,
  BuildContext? context,
}) {
  final ctx = context ?? Get.context!;

  return Row(
    children: [
      Expanded(
        child: GestureDetector(
          onTap: onFollow,
          child: Container(
            height: Dimensions.h_25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Theme.of(ctx)
                    .primaryColorDark
                    .withValues(alpha: 0.20),
              ),
            ),
            child: Text(
              'Follow',
              style: TextStyle(
                color: Theme.of(ctx).primaryColorDark,
                fontSize: FontSize.sp_9_5,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: Dimensions.w_5),
      Expanded(
        child: GestureDetector(
          onTap: onDetails,
          child: Container(
            height: Dimensions.h_25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.darkBlue,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: FontSize.sp_9_5,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}