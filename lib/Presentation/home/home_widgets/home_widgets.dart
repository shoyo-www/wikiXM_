part of '../home.dart';


class _HomeTownNeedsYou extends StatelessWidget {
  const _HomeTownNeedsYou({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildTownNeedsYou();
}


class _HomeMattersMost extends StatelessWidget {
  const _HomeMattersMost({required this.state});

  final _HomeState state;

  @override
  Widget build(BuildContext context) => state.buildMattersMost();
}


extension _HomeWidgetBuilders on _HomeState {

  Widget buildTownNeedsYou() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        Dimensions.w_8,
        Dimensions.h_8,
        Dimensions.w_8,
        Dimensions.h_8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QUICK ACTIONS',
            style: TextStyle(
              color: Theme.of(context).hoverColor,
              fontSize: FontSize.sp_13,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          Row(
            children: [
              _buildTownNeedAction(
                icon: CupertinoIcons.plus_circle_fill,
                  color: Theme.of(context).hoverColor,
                label: 'Start a\npost',
                isBrief: false
              ),
              SizedBox(width: Dimensions.w_6),
              _buildTownNeedAction(
                icon: Icons.bar_chart_rounded,
                color: Colors.green,
                label: 'Join a\nPoll',
                  isBrief: false

              ),
              SizedBox(width: Dimensions.w_6),
              _buildTownNeedAction(
                icon: CupertinoIcons.info_circle,
                color: Colors.deepOrange,
                label: 'Report \nIssue',
                  isBrief: false

              ),
              SizedBox(width: Dimensions.w_6),
              _buildTownNeedAction(
                icon: CupertinoIcons.person,
                color: Colors.blue,
                label: 'Invite a\n Neighbour',
                  isBrief: false

              ),
            ],
          ),
        ],
      ),
    );
  }



  Widget _buildTownNeedAction({
    required IconData icon,
    required Color color,
    required String label,
    required bool isBrief,
    String? subtitle,
    String? action,
    void Function()? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          height: isBrief ? Dimensions.h_90 : Dimensions.h_70,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(
              color: Theme.of(context).focusColor,width: 0.6
            ),
            borderRadius: BorderRadius.circular(Dimensions.h_4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(isBrief)
              SizedBox(height: Dimensions.h_4),
              Icon(icon, color: color, size: Dimensions.h_30),
              SizedBox(height: Dimensions.h_6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).hoverColor,
                  fontSize: FontSize.sp_10,
                  fontWeight: FontWeight.w700,
                  height: 1.05,
                ),
              ),
              if(isBrief)...[
                SizedBox(height: Dimensions.h_5),
                Text(
                  subtitle ?? '',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: FontSize.sp_9_5,
                    fontWeight: FontWeight.w500,
                    height: 1.05,
                  ),
                ),
                Spacer(),
                Text(
                  action ?? '',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: FontSize.sp_10,
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                  ),
                ),
                SizedBox(height: Dimensions.h_4),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMattersMost() {
    return _buildRankedCardSection(bottomMargin: Dimensions.h_10);
  }

  Widget _buildRankedCardSection({required double bottomMargin}) {
    final DashboardController dashboardController = Get.find<DashboardController>();
    return GetBuilder(
      id: ControllerBuilders.homeSectionsController,
      init: dashboardController,
      builder: (_) {
        return Container(
          margin: EdgeInsets.fromLTRB(
            Dimensions.w_10,
            Dimensions.h_10,
            Dimensions.w_10,
            bottomMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${LocalStorage.getString(GetXStorageConstants.townName).toUpperCase()} NEWS HIGHLIGHTS',
                    style: TextStyle(
                      color: Theme.of(context).hoverColor,
                      fontSize: FontSize.sp_13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'View all',
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: FontSize.sp_10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.chevron_right,
                        color: Theme.of(context).primaryColorDark,
                        size: Dimensions.h_11,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_5),
              Row(
                children: List.generate(
                  dashboardController.homeInsights?.newsHighlights?.length ?? 0, (index) {
                    var data = dashboardController.homeInsights?.newsHighlights?[index];
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: index == 0 ? Dimensions.w_8 : 0,
                          left: index == 1 ? Dimensions.w_8 : 0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(Dimensions.h_8),
                            border: Border.all(
                              color: Theme.of(context).focusColor
                            )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(Dimensions.h_8),
                                  topRight: Radius.circular(Dimensions.h_8),
                                ),
                                child: AppCacheImage(
                                  imageUrl: data?.image ?? '',
                                  widthSize: Get.width,
                                  size: Dimensions.h_70,
                                  fit: BoxFit.cover,
                                  isShadow: false,
                                  radius: Dimensions.h_8,
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(Dimensions.w_8),
                                child: Text(
                                  data?.title ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context).hoverColor,
                                    fontSize: FontSize.sp_12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                  left: Dimensions.w_8,
                                  right: Dimensions.w_8,
                                  bottom: Dimensions.h_8,
                                ),
                                child: Text(
                                  '${data?.totalViews ?? ''} discussions',
                                  style: TextStyle(
                                    color: Theme.of(context).hoverColor,
                                    fontSize: FontSize.sp_10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }





  Widget _buildBriefPoint(String text,DashboardController controller) {
    return GetBuilder(
      init: controller,
      id: ControllerBuilders.homeSectionsController,
      builder: (context) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              CupertinoIcons.checkmark_circle_fill,
              color: const Color(0xFF2F24D9),
              size: Dimensions.h_10,
            ),
            SizedBox(width: Dimensions.w_4),
            Expanded(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: FontSize.sp_9,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
              ),
            ),
          ],
        );
      }
    );
  }

  Widget _buildBriefButton({
    required IconData icon,
    required String label,
    bool filled = false,
    VoidCallback? onTap,
    bool isback = false
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Dimensions.h_28,
        decoration: BoxDecoration(
          color: filled ? const Color(0xFF0044f7) : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.h_4),
          border: filled
              ? null
              : Border.all(color: Theme.of(context).primaryColorDark, width: 0.5)),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(!isback)
            Icon(
              icon,
              color: filled ? Colors.white : Theme.of(context).primaryColorDark,
              size: Dimensions.h_12,
            ),
            if(!isback)
              SizedBox(width: Dimensions.w_2),
            Text(
              label,
              style: TextStyle(
                color: filled ? Colors.white : Theme.of(context).primaryColorDark,
                fontSize: FontSize.sp_9,
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
            if(isback)...[
              SizedBox(width: Dimensions.w_2),
              Icon(
                icon,
                color: filled ? Colors.white : Theme.of(context).primaryColorDark,
                size: Dimensions.h_12,
              ),
    ]

          ],
        ),
      ),
    );
  }
}
