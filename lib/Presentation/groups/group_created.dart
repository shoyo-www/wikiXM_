import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wikixm/Presentation/groups/create_group_controller.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../../data/datasource/remote/models/response/create_group.dart';
import '../widgets/common_shimmer.dart';

class GroupCreatedScreen extends StatelessWidget {
  const GroupCreatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<GroupCreatedController>()) Get.put(GroupCreatedController());
    final blue = AppColor.blue(context);
    final blueSoft = AppColor.createGroupBlueSoft(context);
    return AppScaffold(
      bodyPadding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).cardColor,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: Dimensions.w_15, right: Dimensions.w_15, bottom: Dimensions.h_20, top: Dimensions.h_5),
        child: GetBuilder<GroupCreatedController>(
          id: ControllerBuilders.createGroupController,
          // min-height column: the buttons' centered Containers would otherwise stretch to the bar's full-screen max height
          builder: (controller) => controller.isLoading
              ? const SizedBox.shrink()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        if (controller.group?.url?.isNotEmpty ?? false) ...[
                          Expanded(
                            child: _button(context, label: 'Share group', color: blueSoft, textColor: blue, onTap: controller.shareGroup),
                          ),
                          SizedBox(width: Dimensions.w_10),
                        ],
                        Expanded(
                          child: _button(context, label: 'View group', color: blue, textColor: AppColor.white, onTap: controller.viewGroup),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
      body: GetBuilder<GroupCreatedController>(
        id: ControllerBuilders.createGroupController,
        builder: (controller) {
          if (controller.isLoading) return buildShimmer();
          final group = controller.group;
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_10),
            children: [
              if (group != null) buildSuccess(context, group),
              if (group?.url?.isNotEmpty ?? false) buildShareCard(context, controller, group!.url!),
            ],
          );
        },
      ),
    );
  }

  /// Same shape as the loaded page (success header, QR card) so content swaps in without a jump.
  Widget buildShimmer() => ListView(
    physics: const NeverScrollableScrollPhysics(),
    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_25),
    children: [
      Center(child: ShimmerBox(Dimensions.h_70, Dimensions.h_70, isCircle: true)),
      SizedBox(height: Dimensions.h_10),
      Center(child: ShimmerBox(Dimensions.w_100, Dimensions.h_20, radius: Dimensions.h_20)),
      SizedBox(height: Dimensions.h_10),
      Center(child: ShimmerBox(Dimensions.w_200, Dimensions.h_22)),
      SizedBox(height: Dimensions.h_8),
      ShimmerBox(double.infinity, Dimensions.h_12),
      SizedBox(height: Dimensions.h_4),
      Center(child: ShimmerBox(Dimensions.w_200, Dimensions.h_12)),
      SizedBox(height: Dimensions.h_25),
      Padding(
        padding: EdgeInsets.all(Dimensions.h_8),
        child: Column(
          children: [
            ShimmerBox(Dimensions.w_150, Dimensions.h_15),
            SizedBox(height: Dimensions.h_10),
            ShimmerBox(Dimensions.h_150, Dimensions.h_150, radius: Dimensions.h_8),
            SizedBox(height: Dimensions.h_8),
            ShimmerBox(Dimensions.w_200, Dimensions.h_10),
          ],
        ),
      ),
    ],
  );

  Widget buildSuccess(BuildContext context, GroupCreatedData group) {
    final green = AppColor.green(context);
    final greenSoft = AppColor.greenSoft(context);
    final firstName = group.organizerFirstName;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_15),
      child: Column(
        children: [
          Container(
            width: Dimensions.h_70,
            height: Dimensions.h_70,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: greenSoft, shape: BoxShape.circle),
            child: Container(
              width: Dimensions.h_50,
              height: Dimensions.h_50,
              decoration: BoxDecoration(
                color: green,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: green.withValues(alpha: 0.35), blurRadius: 12, offset: const Offset(0, 4))],
              ),
              child: Icon(Icons.check_rounded, color: AppColor.white, size: Dimensions.h_28),
            ),
          ),
          if (group.interests.isNotEmpty) ...[
            SizedBox(height: Dimensions.h_10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_4),
              decoration: BoxDecoration(
                color: greenSoft,
                borderRadius: BorderRadius.circular(Dimensions.h_20),
                border: Border.all(color: green.withValues(alpha: 0.35), width: 0.6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.interests_outlined, size: Dimensions.h_12, color: green),
                  SizedBox(width: Dimensions.w_5),
                  Text(
                    group.interests.first,
                    style: TextStyle(color: AppColor.ink(context), fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: Dimensions.h_10),
          Text(
            firstName == null || firstName.isEmpty ? 'Your group is live!' : 'Your group is live, $firstName!',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.ink(context), fontSize: FontSize.sp_22, fontWeight: FontWeight.w900),
          ),
          SizedBox(height: Dimensions.h_6),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: group.name ?? 'Your group',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                const TextSpan(text: ' is ready for its first members. Start with a warm welcome and invite people to join.'),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_11, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget buildShareCard(BuildContext context, GroupCreatedController controller, String url) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.all(Dimensions.h_8),
      child: Column(
        children: [
          Text(
            'Scan to visit your group',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: Dimensions.h_10),
          // dark mode draws white modules on the dark card; the shared PNG stays black on white
          Container(
            padding: EdgeInsets.all(Dimensions.h_8),
            decoration: BoxDecoration(
              color: isDark ? Theme.of(context).cardColor : AppColor.white,
              borderRadius: BorderRadius.circular(Dimensions.h_10),
              border: Border.all(color: AppColor.border(context)),
            ),
            child: QrImageView(
              data: url,
              size: Dimensions.h_150,
              padding: EdgeInsets.zero,
              eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.square, color: isDark ? AppColor.white : AppColor.black),
              dataModuleStyle: QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: isDark ? AppColor.white : AppColor.black),
            ),
          ),
          _textLink(context, 'Share QR code', controller.shareQr),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Dimensions.h_10),
            child: Row(
              children: [
                Expanded(child: Divider(color: AppColor.border(context))),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
                  child: Text(
                    'or copy link',
                    style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_11),
                  ),
                ),
                Expanded(child: Divider(color: AppColor.border(context))),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  url,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: controller.copyGroupLink,
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.h_8),
                  child: Icon(Icons.content_copy_rounded, size: Dimensions.h_15, color: AppColor.blue(context)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textLink(BuildContext context, String label, VoidCallback onTap) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h_10, horizontal: Dimensions.w_5),
      child: Text(
        label,
        style: TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
      ),
    ),
  );

  Widget _button(BuildContext context, {required String label, required Color color, required Color textColor, VoidCallback? onTap, bool busy = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: Dimensions.h_10),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(Dimensions.h_4)),
        child: busy
            ? SizedBox(
                width: Dimensions.h_13,
                height: Dimensions.h_13,
                child: CircularProgressIndicator(strokeWidth: 1.5, color: textColor),
              )
            : Text(
                label,
                style: TextStyle(color: textColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
              ),
      ),
    );
  }
}
