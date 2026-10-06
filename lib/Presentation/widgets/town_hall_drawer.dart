import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/constants/appcolor.dart';

import '../../constants/fontsize.dart';

class CommonSliderDrawer extends StatelessWidget {
  final bool isLight;

  final VoidCallback? onDashboard;
  final VoidCallback? onProjects;
  final VoidCallback? onDiscussions;
  final VoidCallback? onRepresentatives;
  final VoidCallback? onMeetings;
  final VoidCallback? onTransparency;
  final VoidCallback? onLearn;

  final VoidCallback? onAllLevels;
  final VoidCallback? onCity;
  final VoidCallback? onCounty;
  final VoidCallback? onState;
  final VoidCallback? onFederal;
  final VoidCallback? onClose;

  const CommonSliderDrawer({super.key, required this.isLight, this.onDashboard, this.onProjects, this.onDiscussions, this.onRepresentatives, this.onMeetings, this.onTransparency, this.onLearn, this.onAllLevels, this.onCity, this.onCounty, this.onState, this.onFederal, this.onClose});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: double.infinity,
      color: theme.scaffoldBackgroundColor,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.h_45),
            Padding(
              padding: EdgeInsets.only(left: Dimensions.w_4),
              child: Row(
                children: [
                  Text(
                    'MENU',
                    style: TextStyle(color: theme.hintColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900, letterSpacing: 1, height: 1),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onClose,
                    child: Container(
                      width: Dimensions.h_20,
                      height: Dimensions.h_20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: isLight ? Theme.of(context).highlightColor.withValues(alpha: 0.08) : Theme.of(context).highlightColor.withValues(alpha: 0.10), shape: BoxShape.circle),
                      child: Icon(Icons.close_rounded, color: Theme.of(context).primaryColor, size: Dimensions.h_10),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.h_10),
            _menuItem(context, title: 'Dashboard', isSelected: true, onTap: onDashboard),
            _menuItem(context, title: 'Projects', onTap: onProjects),
            _menuItem(context, title: 'Discussions', onTap: onDiscussions),
            _menuItem(context, title: 'Representatives', onTap: onRepresentatives),
            _menuItem(context, title: 'Meetings', onTap: onMeetings),
            _menuItem(context, title: 'Transparency', onTap: onTransparency),
            _menuItem(context, title: 'Learn', onTap: onLearn),

            SizedBox(height: Dimensions.h_12),
            Padding(
              padding: EdgeInsets.only(left: Dimensions.w_4),
              child: Text(
                'GOVERNMENT LEVEL',
                style: TextStyle(color: theme.hintColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w900, letterSpacing: 1, height: 1),
              ),
            ),
            SizedBox(height: Dimensions.h_8),
            _governmentSection(context),
            SizedBox(height: Dimensions.h_8),
            _buildQuickActions(context),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(BuildContext context, {required String title, bool isSelected = false, VoidCallback? onTap}) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: Dimensions.h_2),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_8),
        decoration: BoxDecoration(
          color: isSelected ? (isLight ? const Color(0xFFEDF3FB) : const Color(0xFF14223A)) : Colors.transparent,
          borderRadius: BorderRadius.circular(Dimensions.h_6),
          border: isSelected ? Border.all(color: theme.primaryColorDark.withValues(alpha: 0.50), width: 0.5) : null,
        ),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(
            color: isSelected
                ? isLight
                      ? AppColor.darkBlue
                      : const Color(0xFF4b8bff)
                : theme.primaryColor,
            fontSize: FontSize.sp_9_5,
            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
            height: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: Dimensions.w_4),
          child: Text(
            'QUICK ACTIONS',
            style: TextStyle(color: theme.hintColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w900, letterSpacing: 1, height: 1),
          ),
        ),
        SizedBox(height: Dimensions.h_8),
        _quickActionItem(context, icon: CupertinoIcons.pencil, title: 'Raise an Issue or Idea', subtitle: 'Start a new project', iconColor: isLight ? const Color(0xFF0640E3) : const Color(0xFF6AA4FF), backgroundColor: isLight ? const Color(0xFFE5ECFE) : const Color(0xFF111D3A), onTap: () {}),

        _quickActionItem(
          context,
          icon: CupertinoIcons.chat_bubble_fill,
          title: 'Join a Discussion',
          subtitle: 'Contribute to solutions',
          iconColor: isLight ? const Color(0xFF5B24D6) : const Color(0xFFA98CFF),
          backgroundColor: isLight ? const Color(0xFFECE6FD) : const Color(0xFF241D47),
          onTap: () {},
        ),

        _quickActionItem(
          context,
          icon: CupertinoIcons.calendar_badge_plus,
          title: 'Create Meeting Request',
          subtitle: 'Propose a Town Hall topic',
          iconColor: isLight ? const Color(0xFFD81324) : const Color(0xFFFF7B84),
          backgroundColor: isLight ? const Color(0xFFFDE7E9) : const Color(0xFF3A1720),
          onTap: () {},
        ),

        _quickActionItem(context, icon: CupertinoIcons.paperplane_fill, title: 'Track My Activity', subtitle: 'See my impact', iconColor: isLight ? const Color(0xFF0D6B3F) : const Color(0xFF4FC98A), backgroundColor: isLight ? const Color(0xFFE8F3EC) : const Color(0xFF102B1F), onTap: () {}),

        _quickActionItem(context, icon: CupertinoIcons.person_add_solid, title: 'Invite a Neighbor', subtitle: 'Grow our community', iconColor: isLight ? const Color(0xFFB94705) : const Color(0xFFFF9D4D), backgroundColor: isLight ? const Color(0xFFFDEADA) : const Color(0xFF3D2411), onTap: () {}),
      ],
    );
  }

  Widget _quickActionItem(BuildContext context, {required IconData icon, required String title, required String subtitle, required Color iconColor, required Color backgroundColor, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.w_10),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.only(bottom: Dimensions.h_8),
          child: Row(
            children: [
              Container(
                width: Dimensions.h_20,
                height: Dimensions.h_20,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
                child: Icon(icon, color: iconColor, size: Dimensions.h_11),
              ),
              SizedBox(width: Dimensions.w_8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: theme.primaryColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700, height: 1.1),
                    ),
                    SizedBox(height: Dimensions.h_1),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: theme.highlightColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, height: 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _governmentSection(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_4),
      child: Column(
        children: [
          _governmentItem(context, icon: Icons.account_balance_outlined, title: 'All Levels', location: 'Issaquah, WA', projects: '24', iconColor: Colors.white, isSelected: true, onTap: onAllLevels),
          _governmentItem(context, icon: Icons.account_balance_outlined, title: 'City Government', location: 'Issaquah, WA', projects: '8', iconColor: isLight ? const Color(0xFF0F7A3D) : const Color(0xFF4CC98B), onTap: onCity),
          Container(height: 0.3, color: Theme.of(context).highlightColor),
          _governmentItem(context, icon: Icons.account_balance_outlined, title: 'County Government', location: 'King County', projects: '16', iconColor: isLight ? const Color(0xFF3341D8) : const Color(0xFF7F95FF), onTap: onCounty),

          Container(height: 0.3, color: Theme.of(context).highlightColor),

          _governmentItem(context, icon: Icons.account_balance_outlined, title: 'State', location: 'Washington ', projects: '31', iconColor: isLight ? const Color(0xFF6D28E0) : const Color(0xFFB092FF), onTap: onState),
          Container(height: 0.3, color: Theme.of(context).highlightColor),

          _governmentItem(context, icon: Icons.account_balance_outlined, title: 'Federal Government', location: 'United States', projects: '27', iconColor: isLight ? const Color(0xFF12246E) : const Color(0xFF9FBDFF), onTap: onFederal),
        ],
      ),
    );
  }

  Widget _governmentItem(BuildContext context, {required IconData icon, required String title, required String location, required String projects, required Color iconColor, bool isSelected = false, VoidCallback? onTap}) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_8),
        decoration: BoxDecoration(
          gradient: isSelected ? const LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xFF3F6FD5), Color(0xFF254BA8)]) : null,
          borderRadius: isSelected ? BorderRadius.circular(Dimensions.h_8) : BorderRadius.zero,
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: Dimensions.h_18),
            SizedBox(width: Dimensions.w_8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: isSelected ? Colors.white : theme.primaryColor, fontSize: FontSize.sp_10, fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700, height: 1),
                  ),
                  SizedBox(height: Dimensions.h_4),
                  Row(
                    children: [
                      Text(
                        location,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white.withValues(alpha: 0.75)
                              : isLight
                              ? Colors.grey.shade700
                              : Colors.grey.shade400,
                          fontSize: FontSize.sp_9_5,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                      if (projects.isNotEmpty) ...[
                        SizedBox(width: Dimensions.w_5),
                        Row(
                          children: [
                            SizedBox(width: Dimensions.w_1),
                            Text(
                              projects,
                              style: TextStyle(color: iconColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w900, height: 1),
                            ),
                            SizedBox(width: Dimensions.w_4),
                            Text(
                              'Active Projects',
                              style: TextStyle(
                                color: isSelected
                                    ? AppColor.white
                                    : isLight
                                    ? Colors.grey.shade700
                                    : Colors.grey.shade400,
                                fontSize: FontSize.sp_9,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: isSelected ? Colors.white : theme.hintColor, size: Dimensions.h_16),
          ],
        ),
      ),
    );
  }
}
