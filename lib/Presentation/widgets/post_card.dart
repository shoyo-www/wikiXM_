import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wikixm/Presentation/widgets/cache_image.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/constants/appcolor.dart';
import '../../constants/fontsize.dart';
import '../../data/datasource/remote/models/response/group_detail.dart' as model;

/// Discussion post, shared by the group detail and alert detail pages.
class PostCard extends StatelessWidget {
  final model.Post item;
  // the alert discussion has no saving and shows replies as plain text
  final bool showSave;
  final bool showCommentIcon;
  final String commentsLabel;
  // replies and solutions on the alert detail have no likes or comment counts
  final bool showFooter;
  final VoidCallback? onComments;
  // open replies shown inside the card under the footer; the count then reads "Hide replies"
  final Widget? thread;
  const PostCard({super.key, required this.item, this.showSave = true, this.showCommentIcon = true, this.commentsLabel = 'Comments', this.showFooter = true, this.onComments, this.thread});

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      margin: EdgeInsets.only(bottom: Dimensions.h_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.isPinned == 1) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_4),
              decoration: BoxDecoration(color: AppColor.greenSoft(context), borderRadius: BorderRadius.circular(Dimensions.h_4)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(CupertinoIcons.pin, size: Dimensions.h_10, color: AppColor.green(context)),
                  SizedBox(width: Dimensions.w_5),
                  Text(
                    'Pinned by your organizer',
                    style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, color: AppColor.green(context)),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.h_10),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppCacheImage(imageUrl: item.avatar ?? '', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true, color: Theme.of(context).highlightColor),
              SizedBox(width: Dimensions.w_8),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      '${item.firstName ?? ''} ${item.lastName ?? ''}',
                      style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                    ),
                    if (item.authorRoleLabel?.isNotEmpty ?? false) ...[
                      SizedBox(width: Dimensions.w_8),
                      Text(
                        item.authorRoleLabel!,
                        style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w700, color: AppColor.blue(context)),
                      ),
                    ],
                    SizedBox(width: Dimensions.w_8),
                    Text(
                      item.createdAtLabel ?? '',
                      style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                    ),
                    const Spacer(),
                    if (showSave) Icon(item.isSaved == 1 ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark, size: Dimensions.h_16, color: Theme.of(context).highlightColor),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.title?.isNotEmpty ?? false) ...[
                      Text(
                        item.title!,
                        style: TextStyle(fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor, height: 1.1),
                      ),
                      SizedBox(height: Dimensions.h_5),
                    ],
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.w_6),
                      child: Text(
                        item.body ?? '',
                        style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor, height: 1.3),
                      ),
                    ),
                  ],
                ),
              ),
              if (item.image?.isNotEmpty ?? false) ...[SizedBox(width: Dimensions.w_10), AppCacheImage(imageUrl: item.image!, size: Dimensions.h_75, widthSize: Dimensions.w_120)],
            ],
          ),
          if (showFooter) ...[
            SizedBox(height: Dimensions.h_10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: Dimensions.w_6),
                Icon(item.isLiked == 1 ? CupertinoIcons.hand_thumbsup_fill : CupertinoIcons.hand_thumbsup, size: Dimensions.h_11, color: Theme.of(context).highlightColor),
                SizedBox(width: Dimensions.w_5),
                Text(
                  '${item.likesCount ?? 0} Likes',
                  style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                ),
                SizedBox(width: Dimensions.w_15),
                if (showCommentIcon) ...[Icon(CupertinoIcons.chat_bubble_text, size: Dimensions.h_11, color: Theme.of(context).highlightColor), SizedBox(width: Dimensions.w_5)],
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onComments,
                  child: Text(
                    thread != null ? 'Hide ${commentsLabel.toLowerCase()}' : '${item.commentsCount ?? 0} $commentsLabel',
                    style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                  ),
                ),
              ],
            ),
          ],
          if (thread != null) ...[SizedBox(height: Dimensions.h_10), thread!],
        ],
      ),
    );
  }
}
