import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/garage/controller.dart';
import 'package:wikixm/Presentation/widgets/cache_image.dart';
import 'package:wikixm/Presentation/widgets/common_blur_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import 'package:wikixm/constants/fontsize.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final GarageController garageController = Get.put(GarageController());

  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return AppScaffold(
      top: false,
      bottom: true,
      bodyPadding: EdgeInsets.zero,
      bottomNavigationBar: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          garageController.analyseImage();
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.w_20),
          height: Dimensions.h_35,
          decoration: BoxDecoration(color: const Color(0xFF2455D6), borderRadius: BorderRadius.circular(Dimensions.h_7)),
          child: GetBuilder(
            init: garageController,
            id: ControllerBuilders.addGarageItemController,
            builder: (controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.isLoading ? "Analysing Images" : 'Save Photos & Continue',
                    style: TextStyle(color: Colors.white, fontSize: FontSize.sp_12, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: Dimensions.w_5),
                  Icon(CupertinoIcons.arrow_right, color: Colors.white, size: Dimensions.h_13),
                ],
              );
            },
          ),
        ),
      ),
      body: GetBuilder(
        init: garageController,
        id: ControllerBuilders.addGarageItemController,
        builder: (controller) {
          return CommonBlurScaffold(
            showBack: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.h_80),
                  Text(
                    'List an item',
                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_22, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: Dimensions.h_5),
                  Text(
                    'Take a few photos and we’ll do the rest. It’s fast, easy, and free.',
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: Dimensions.h_10),
                  commonStepHeader(
                    context: context,
                    step: '1',
                    title: 'Add Photos',
                    subtitle: 'Take clear photos. More photos get more views and sell faster.',
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.h_6),
                        border: Border.all(color: Theme.of(context).primaryColorDark, width: 0.5),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.camera, size: Dimensions.h_10, color: Theme.of(context).primaryColorDark),
                          SizedBox(width: Dimensions.w_2),
                          Text(
                            'Photo Tips',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.h_10),
                  GetBuilder(
                    id: ControllerBuilders.addGarageItemController,
                    init: garageController,
                    builder: (controller) {
                      return CommonCard(
                        margin: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (controller.hasImages)
                              SizedBox(
                                height: Dimensions.h_140,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.h_7),
                                      child: Builder(
                                        builder: (context) {
                                          final item = controller.images.first;

                                          final uploadedUrl = item.url;
                                          final isUploading = item.isUploading;

                                          return Stack(
                                            children: [
                                              uploadedUrl != null && uploadedUrl.isNotEmpty
                                                  ? AppCacheImage(imageUrl: uploadedUrl, widthSize: Get.width, size: Dimensions.h_140, fit: BoxFit.cover, isShimmer: true)
                                                  : Image.file(File(item.file.path), width: Get.width, height: Dimensions.h_140, fit: BoxFit.cover),
                                              if (isUploading)
                                                Positioned.fill(
                                                  child: Container(
                                                    decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.35), borderRadius: BorderRadius.circular(Dimensions.h_7)),
                                                    child: const Center(child: CircularProgressIndicator()),
                                                  ),
                                                ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: Dimensions.h_5,
                                      right: Dimensions.w_5,
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.removeImage(0);
                                        },
                                        child: Container(
                                          width: Dimensions.h_22,
                                          height: Dimensions.h_22,
                                          decoration: const BoxDecoration(color: Color(0xFF17233A), shape: BoxShape.circle),
                                          child: Icon(CupertinoIcons.xmark, color: Colors.white, size: Dimensions.h_11),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: Dimensions.w_5,
                                      top: Dimensions.h_5,
                                      child: Container(
                                        height: Dimensions.h_20,
                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                                        decoration: BoxDecoration(color: const Color(0xFF1769D8), borderRadius: BorderRadius.circular(Dimensions.h_5)),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'MAIN PHOTO',
                                          style: TextStyle(color: Colors.white, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else
                              GestureDetector(
                                onTap: controller.pickImage,
                                child: Container(
                                  height: Dimensions.h_140,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.h_7),
                                    border: Border.all(color: const Color(0xFF2878FF).withValues(alpha: 0.45), width: 0.7),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(CupertinoIcons.camera, color: const Color(0xFF2878FF), size: Dimensions.h_25),
                                      SizedBox(height: Dimensions.h_7),
                                      Text(
                                        'Click to Upload Photos',
                                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: Dimensions.h_3),
                                      Text(
                                        '(JPG, PNG, HEIC Up to 10 photos)',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            if (controller.hasImages) ...[
                              if (controller.images.length == 1 && controller.canAddMore) ...[
                                SizedBox(height: Dimensions.h_10),
                                GestureDetector(
                                  onTap: controller.pickImage,
                                  child: Container(
                                    height: Dimensions.h_140,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.h_7),
                                      border: Border.all(color: const Color(0xFF2878FF).withValues(alpha: 0.45), width: 0.7),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(CupertinoIcons.camera, color: const Color(0xFF2878FF), size: Dimensions.h_25),
                                        SizedBox(height: Dimensions.h_7),
                                        Text(
                                          'Click to Upload Photos',
                                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(height: Dimensions.h_3),
                                        Text(
                                          '(JPG, PNG, HEIC Up to 10 photos)',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],

                              if (controller.images.length > 1) ...[
                                SizedBox(height: Dimensions.h_10),
                                SizedBox(
                                  height: Dimensions.h_80,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: (controller.images.length - 1) + (controller.canAddMore ? 1 : 0),
                                    padding: EdgeInsets.zero,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      if (index == controller.images.length - 1) {
                                        return GestureDetector(
                                          onTap: controller.pickImage,
                                          child: Container(
                                            width: Dimensions.w_80,
                                            margin: EdgeInsets.only(right: Dimensions.w_5),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.5),
                                              borderRadius: BorderRadius.circular(Dimensions.h_6),
                                              border: Border.all(color: const Color(0xFF2878FF).withValues(alpha: 0.45), width: 0.7),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(CupertinoIcons.plus, color: const Color(0xFF1769D8), size: Dimensions.h_18),
                                                SizedBox(height: Dimensions.h_3),
                                                Text(
                                                  'Add More',
                                                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_7, fontWeight: FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }

                                      final item = controller.images[index + 1];

                                      final uploadedUrl = item.url;
                                      final isUploading = item.isUploading;

                                      return Container(
                                        width: Dimensions.h_80,
                                        margin: EdgeInsets.only(right: Dimensions.w_5),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(Dimensions.h_6),
                                              child: Stack(
                                                children: [
                                                  uploadedUrl != null && uploadedUrl.isNotEmpty
                                                      ? AppCacheImage(imageUrl: uploadedUrl, widthSize: Dimensions.h_80, size: Dimensions.h_80, fit: BoxFit.cover, isShimmer: true)
                                                      : Image.file(File(item.file.path), width: Dimensions.h_80, height: Dimensions.h_80, fit: BoxFit.cover),
                                                  if (isUploading)
                                                    Positioned.fill(
                                                      child: Container(
                                                        decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.35), borderRadius: BorderRadius.circular(Dimensions.h_6)),
                                                        child: const Center(child: CircularProgressIndicator()),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: Dimensions.h_3,
                                              right: Dimensions.w_3,
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.removeImage(index + 1);
                                                },
                                                child: Container(
                                                  width: Dimensions.h_15,
                                                  height: Dimensions.h_15,
                                                  decoration: const BoxDecoration(color: Color(0xFF17233A), shape: BoxShape.circle),
                                                  child: Icon(CupertinoIcons.xmark, color: Colors.white, size: Dimensions.h_8),
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
                            ],

                            if (controller.hasImages) ...[
                              SizedBox(height: Dimensions.h_10),

                              Row(
                                children: [
                                  Text(
                                    '${controller.imageCount} of ${GarageController.maxImages} photos',
                                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_8_5, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(width: Dimensions.w_7),
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: LinearProgressIndicator(value: controller.imageProgress, minHeight: Dimensions.h_4, backgroundColor: const Color(0xFFDCE7F2), valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2878FF))),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.w_7),
                                  Text(
                                    controller.remainingImages == 0 ? 'Maximum reached' : 'Add ${controller.remainingImages} more',
                                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8_5, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: Dimensions.h_20),
                  if (controller.secondStep) secondStep(context, isLight),
                  if (controller.thirdStep) thirdStep(context, isLight),
                  if (controller.fourthStep) fourthStep(context),
                  if (controller.fourthStep) fifthStep(context, isLight, controller),
                  SizedBox(height: Dimensions.h_20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget fifthStep(BuildContext context, bool isLight, GarageController controller) {
    return Column(
      children: [
        commonStepHeader(crossAxisAlignment: CrossAxisAlignment.start, context: context, step: '5', isOptional: true, title: 'Featured Listing ', subtitle: "Get more views and sell faster. Your listing will appear in the Featured column on the homepage."),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            value: controller.isFeatured,
                            onChanged: (value) {
                              controller.onFeatured(value);
                            },
                            activeTrackColor: const Color(0xFF087C4B),
                            inactiveTrackColor: const Color(0xFF8AA0BA),
                            inactiveThumbColor: Colors.white,
                            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Add Featured Listing',
                              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '\$3.99 per item',
                              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: Dimensions.w_4),
                  Expanded(
                    child: CommonCard(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      radius: Dimensions.h_6,
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(CupertinoIcons.chart_bar_alt_fill, color: const Color(0xFF075DC9), size: Dimensions.h_18),
                          SizedBox(width: Dimensions.w_5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Featured listings get more attention.',
                                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, height: 1),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: Dimensions.w_3),
                          Icon(CupertinoIcons.info_circle, color: Theme.of(context).highlightColor, size: Dimensions.h_12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LISTING SUMMARY',
              style: TextStyle(color: const Color(0xFF087C4B), fontSize: FontSize.sp_12, fontWeight: FontWeight.w900, letterSpacing: 0.3),
            ),
            SizedBox(height: Dimensions.h_12),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: Dimensions.h_25,
                        height: Dimensions.h_25,
                        decoration: BoxDecoration(color: const Color(0xFFE8F2FF), borderRadius: BorderRadius.circular(Dimensions.h_6)),
                        child: Icon(CupertinoIcons.photo, color: const Color(0xFF2878FF), size: Dimensions.h_13),
                      ),
                      SizedBox(width: Dimensions.w_5),
                      Text(
                        '5 photos',
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
                  width: 0.4,
                  height: Dimensions.h_22,
                  color: isLight ? Colors.grey : Colors.white24,
                ),
                SizedBox(width: Dimensions.w_6),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: Dimensions.h_25,
                        height: Dimensions.h_25,
                        decoration: BoxDecoration(color: const Color(0xFFE8F7EF), borderRadius: BorderRadius.circular(Dimensions.h_6)),
                        child: Icon(CupertinoIcons.tag, color: const Color(0xFF087C4B), size: Dimensions.h_13),
                      ),
                      SizedBox(width: Dimensions.w_5),
                      Text(
                        '\$450',
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
                  width: 0.4,
                  height: Dimensions.h_22,
                  color: isLight ? Colors.grey : Colors.white24,
                ),
                SizedBox(width: Dimensions.w_6),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: Dimensions.h_25,
                        height: Dimensions.h_25,
                        decoration: BoxDecoration(color: const Color(0xFFE8F2FF), borderRadius: BorderRadius.circular(Dimensions.h_6)),
                        child: Icon(CupertinoIcons.location_solid, color: const Color(0xFF2878FF), size: Dimensions.h_13),
                      ),
                      SizedBox(width: Dimensions.w_5),
                      Expanded(
                        child: Text(
                          'Issaquah',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.h_15),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: Dimensions.h_30,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(Dimensions.h_7),
                      border: Border.all(color: const Color(0xFF8DBBFF), width: 0.8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.doc_text, color: const Color(0xFF2878FF), size: Dimensions.h_15),
                        SizedBox(width: Dimensions.w_4),
                        Text(
                          'Save as Draft',
                          style: TextStyle(color: const Color(0xFF2878FF), fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.w_7),
                Expanded(
                  child: Container(
                    height: Dimensions.h_30,
                    decoration: BoxDecoration(color: const Color(0xFF2455D6), borderRadius: BorderRadius.circular(Dimensions.h_7)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'List for ',
                          style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '\$450',
                          style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(width: Dimensions.w_5),
                        Icon(CupertinoIcons.arrow_right, color: Colors.white, size: Dimensions.h_13),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.h_15),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, height: 1.3),
                  children: [
                    const TextSpan(text: 'By listing, you agree to our '),
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(color: const Color(0xFF075DC9), decoration: TextDecoration.underline, fontWeight: FontWeight.w800, decorationColor: const Color(0xFF075DC9)),
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Community Guidelines',
                      style: TextStyle(color: const Color(0xFF075DC9), fontWeight: FontWeight.w800, decoration: TextDecoration.underline, decorationColor: const Color(0xFF075DC9)),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget fourthStep(BuildContext context) {
    return Column(
      children: [
        commonStepHeader(crossAxisAlignment: CrossAxisAlignment.start, context: context, step: '4', title: 'Location', subtitle: "We'll show your general location (Issaquah, WA) to local buyers."),
        SizedBox(height: Dimensions.h_5),
        CommonCard(
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CommonCard(
                      radius: Dimensions.h_6,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_5),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.location_solid, color: const Color(0xFF075DC9), size: Dimensions.h_12),
                          SizedBox(width: Dimensions.w_5),
                          Text(
                            'Issaquah, WA',
                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.w_15),
                  GestureDetector(
                    onTap: () {
                      showChangeLocationBottomSheet(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.h_6),
                        border: Border.all(color: Theme.of(context).primaryColorDark, width: 0.5),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.pen, size: Dimensions.h_10, color: Theme.of(context).primaryColorDark),
                          SizedBox(width: Dimensions.w_2),
                          Text(
                            'Change Location',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: FontSize.sp_8_5, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_10),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_10),
                child: Text(
                  'Your exact address stays private. You’ll share pickup details with buyers later.',
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8_5, height: 1.1, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_20),
      ],
    );
  }

  Widget thirdStep(BuildContext context, bool isLight) {
    return Column(
      children: [
        commonStepHeader(crossAxisAlignment: CrossAxisAlignment.start, context: context, step: '3', title: 'Choose how you want to sell', subtitle: 'Get the right price for your goals. Based on similar items in Issaquah.'),
        SizedBox(height: Dimensions.h_5),
        CommonCard(margin: EdgeInsets.zero, child: sellingOptions(isLight)),
        SizedBox(height: Dimensions.h_20),
      ],
    );
  }

  Widget secondStep(BuildContext context, bool isLight) {
    return Column(
      children: [
        commonStepHeader(
          crossAxisAlignment: CrossAxisAlignment.center,
          context: context,
          step: '2',
          title: 'We identified your item',
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.h_6),
                  border: Border.all(color: AppColor.darkGreenSportsSecondaryText, width: 0.5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.check_mark, size: Dimensions.h_10, color: AppColor.darkGreenSportsSecondaryText),
                    SizedBox(width: Dimensions.w_2),
                    Text(
                      'Looks Correct',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColor.darkGreenSportsSecondaryText, fontSize: FontSize.sp_8_5, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              SizedBox(width: Dimensions.w_8),
              GestureDetector(
                onTap: () {
                  showItemDetailsBottomSheet(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.h_6),
                    border: Border.all(color: Theme.of(context).primaryColorDark, width: 0.5),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.pencil_circle_fill, size: Dimensions.h_10, color: Theme.of(context).primaryColorDark),
                      SizedBox(width: Dimensions.w_2),
                      Text(
                        'Edit Details',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: FontSize.sp_8_5, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_5),
        CommonCard(
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              garageController.images.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.h_7),
                      child: garageController.images.first.url != null && garageController.images.first.url!.isNotEmpty
                          ? AppCacheImage(imageUrl: garageController.images.first.url!, widthSize: Get.width, size: Dimensions.h_140, fit: BoxFit.cover)
                          : Image.file(File(garageController.images.first.file.path), width: Get.width, height: Dimensions.h_140, fit: BoxFit.cover),
                    )
                  : AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/garage/garage-item/mountain-bike.webp', widthSize: Get.width, size: Dimensions.h_140, radius: Dimensions.h_7, fit: BoxFit.cover, isShimmer: true, alignment: const Alignment(1, -0.5), isShadow: false),
              SizedBox(height: Dimensions.h_10),
              itemDetails(isLight),
              SizedBox(height: Dimensions.h_10),
              CommonCard(
                color: isLight ? const Color(0x84fcf2dc) : const Color(0x34FFC36C),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(CupertinoIcons.sparkles, color: isLight ? const Color(0xFFA14F00) : const Color(0xFFFFC36C), size: Dimensions.h_15),
                        SizedBox(width: Dimensions.w_5),
                        Text(
                          'AI-Generated Description',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF), fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            showDescriptionBottomSheet(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.h_6),
                              border: Border.all(color: Theme.of(context).primaryColorDark, width: 0.5),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.pen, size: Dimensions.h_10, color: Theme.of(context).primaryColorDark),
                                SizedBox(width: Dimensions.w_2),
                                Text(
                                  'Edit Description',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: FontSize.sp_8_5, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.h_5),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.w_20),
                      child: Text(
                        'Excellent condition Trek Fuel EX 8 mountain bike. Well maintained and barely used. Full suspension, 29” wheels, size Large. Upgraded pedals and bottle cage included. No major scratches. Ready to ride!',
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_20),
      ],
    );
  }

  Widget sellingOptions(bool isLight) {
    final surface = isLight ? const Color(0xFFFFFFFF) : const Color(0xFF0B2035);

    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);

    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);

    final blueSoft = isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);

    final options = [
      {'title': 'Sell Fast', 'price': '\$400', 'time': 'Estimated 2–4 days', 'description': 'Great if you want to sell quickly.', 'icon': CupertinoIcons.bolt_fill, 'color': blue, 'softColor': blueSoft, 'recommended': false},
      {'title': 'Balanced', 'price': '\$450', 'time': 'Estimated 5–9 days', 'description': 'Best balance of price and speed.', 'icon': CupertinoIcons.checkmark_circle_fill, 'color': blue, 'softColor': blueSoft, 'recommended': true},
      {'title': 'Maximize Price', 'price': '\$525', 'time': 'Estimated 12–20 days', 'description': 'Get the highest price.', 'icon': CupertinoIcons.money_dollar_circle_fill, 'color': blue, 'softColor': blueSoft, 'recommended': false},
    ];

    return GetBuilder(
      id: ControllerBuilders.addGarageItemController,
      init: garageController,
      builder: (controller) {
        return Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: options.length,
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: Dimensions.w_5, mainAxisExtent: Dimensions.h_90),
              itemBuilder: (context, index) {
                final option = options[index];
                final isSelected = controller.selectedSellingOption == index;
                final softColor = option['softColor'] as Color;
                return GestureDetector(
                  onTap: () {
                    controller.selectSellingOption(index);
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(Dimensions.w_6),
                        decoration: BoxDecoration(
                          color: isSelected ? Color.lerp(softColor, surface, 0.25) : Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(Dimensions.h_6),
                          border: Border.all(
                            color: isSelected
                                ? blue
                                : isLight
                                ? Colors.grey
                                : Colors.white24,
                            width: isSelected ? 0.9 : 0.4,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              option['title'] as String,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: ink, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w700),
                            ),

                            SizedBox(height: Dimensions.h_1),

                            Text(
                              option['price'] as String,
                              style: TextStyle(color: ink, fontSize: FontSize.sp_16, fontWeight: FontWeight.w900),
                            ),

                            SizedBox(height: Dimensions.h_5),

                            Text(
                              option['time'] as String,
                              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8_5),
                            ),

                            const Spacer(),

                            Text(
                              option['description'] as String,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8),
                            ),
                          ],
                        ),
                      ),

                      if (option['recommended'] == true)
                        Positioned(
                          top: -Dimensions.h_10,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_7, vertical: Dimensions.h_2),
                              decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(Dimensions.h_4)),
                              child: Text(
                                'Recommended',
                                style: TextStyle(color: Colors.white, fontSize: FontSize.sp_8, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: Dimensions.h_20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.w_20, right: Dimensions.w_10),
                    height: 0.4,
                    color: isLight ? Colors.grey : Colors.white24,
                  ),
                ),
                Text(
                  'OR',
                  style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: FontSize.sp_12, fontWeight: FontWeight.w600),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.w_10, right: Dimensions.w_20),
                    height: 0.4,
                    color: isLight ? Colors.grey : Colors.white24,
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.h_20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: Dimensions.w_10),
                Text(
                  'Enter my own price',
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: Dimensions.w_15),
                Expanded(
                  child: SizedBox(
                    height: Dimensions.h_35,
                    child: TextField(
                      controller: TextEditingController(),
                      autofocus: true,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                      cursorColor: Theme.of(context).primaryColorDark,
                      cursorHeight: Dimensions.h_12,
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: Dimensions.w_12, right: Dimensions.w_5),
                          child: Text(
                            '\$',
                            style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w400),
                          ),
                        ),
                        prefixIconConstraints: BoxConstraints(minWidth: Dimensions.w_20),
                        hintText: '',
                        hintStyle: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                        contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.h_7),
                          borderSide: const BorderSide(color: Color(0xFF2878FF), width: 0.8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.h_7),
                          borderSide: const BorderSide(color: Color(0xFF2878FF), width: 1.2),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.h_10),
            CommonCard(
              radius: Dimensions.h_6,
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_5),
              child: Row(
                children: [
                  Icon(CupertinoIcons.chart_bar, color: const Color(0xFF075DC9), size: Dimensions.h_10),
                  SizedBox(width: Dimensions.w_5),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w400),
                        children: [
                          const TextSpan(text: 'Similar items in Issaquah typically sell for '),
                          TextSpan(
                            text: '\$400 – \$550',
                            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w800),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.w_4),
                  Icon(CupertinoIcons.info_circle, color: Theme.of(context).highlightColor, size: Dimensions.h_11),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget itemDetails(bool isLight) {
    final surface = isLight ? const Color(0xFFFFFFFF) : const Color(0xFF0B2035);

    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);

    final copy = isLight ? const Color(0xFF344779) : const Color(0xFFC9D5E8);

    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);

    final blueSoft = isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);

    final details = [
      {'icon': CupertinoIcons.tag, 'title': 'Category', 'value': 'Bikes'},
      {'icon': CupertinoIcons.cube_box, 'title': 'Condition', 'value': 'Like New'},
      {'icon': CupertinoIcons.calendar, 'title': 'Year', 'value': '2022'},
      {'icon': CupertinoIcons.gift_fill, 'title': 'Brand', 'value': 'Trek'},
      {'icon': CupertinoIcons.gear, 'title': 'Model', 'value': 'Fuel EX 8'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trek Fuel EX 8 Mountain Bike',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: ink, fontSize: FontSize.sp_16, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: Dimensions.h_2),
        Row(
          children: [
            SizedBox(width: Dimensions.w_10),
            Text(
              'Bikes',
              style: TextStyle(color: copy, fontSize: FontSize.sp_10),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4),
              child: Text(
                '•',
                style: TextStyle(color: blue, fontSize: FontSize.sp_10),
              ),
            ),
            Text(
              'Trek',
              style: TextStyle(color: copy, fontSize: FontSize.sp_10),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4),
              child: Text(
                '•',
                style: TextStyle(color: blue, fontSize: FontSize.sp_10),
              ),
            ),
            Text(
              'Fuel EX 8',
              style: TextStyle(color: copy, fontSize: FontSize.sp_10),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4),
              child: Text(
                '•',
                style: TextStyle(color: blue, fontSize: FontSize.sp_10),
              ),
            ),
            Text(
              '2022 (estimated)',
              style: TextStyle(color: copy, fontSize: FontSize.sp_10),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: details.length,
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: Dimensions.w_5, mainAxisSpacing: Dimensions.h_5, mainAxisExtent: Dimensions.h_40),
          itemBuilder: (context, index) {
            final item = details[index];
            return Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_7, vertical: Dimensions.h_6),
              decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(Dimensions.h_7)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(item['icon'] as IconData, color: blue, size: Dimensions.h_18),
                  SizedBox(width: Dimensions.w_8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          item['title'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: copy, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          item['value'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: ink, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget commonStepHeader({required BuildContext context, required String step, required String title, String? subtitle, Widget? child, CrossAxisAlignment? crossAxisAlignment, bool isOptional = false}) {
    return Row(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(Dimensions.h_12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(begin: Alignment(-0.7, -0.7), end: Alignment(0.7, 0.7), colors: [Color(0xFF1682FF), Color(0xFF0056EB)], stops: [0.0, 0.72]),
            shape: BoxShape.circle,
          ),
          child: Text(
            step,
            style: TextStyle(color: Colors.white, fontSize: FontSize.sp_20, fontWeight: FontWeight.w900),
          ),
        ),
        SizedBox(width: Dimensions.w_4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isOptional)
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_13_5, height: 1.2, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      '(Optional)',
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              else
                Text(
                  title,
                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_13_5, height: 1.2, fontWeight: FontWeight.w800),
                ),
              if (subtitle != null && subtitle.isNotEmpty) ...[
                SizedBox(height: Dimensions.h_2),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.w_5),
                  child: Text(
                    subtitle,
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500, height: 1.1),
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(width: Dimensions.w_8),
        ?child,
      ],
    );
  }

  void showItemDetailsBottomSheet(BuildContext context) {
    final titleController = TextEditingController(text: 'Trek Fuel EX 8 Mountain Bike');

    final yearController = TextEditingController(text: '2022');

    final brandController = TextEditingController(text: 'Trek');

    final modelController = TextEditingController(text: 'Fuel EX 8');

    String selectedCategory = 'Bikes';
    String selectedCondition = 'Like New';

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: EdgeInsets.only(left: Dimensions.w_15, right: Dimensions.w_15, top: Dimensions.h_12, bottom: MediaQuery.of(context).viewInsets.bottom + Dimensions.h_15),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.h_18), topRight: Radius.circular(Dimensions.h_18)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Edit Details',
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_16, fontWeight: FontWeight.w900),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          width: Dimensions.h_25,
                          height: Dimensions.h_25,
                          decoration: BoxDecoration(color: Theme.of(context).highlightColor.withValues(alpha: 0.1), shape: BoxShape.circle),
                          child: Icon(CupertinoIcons.xmark, size: Dimensions.h_13, color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_12),
                  Text(
                    'Title',
                    style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: Dimensions.h_5),
                  TextField(
                    controller: titleController,
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Enter item title',
                      hintStyle: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10),
                      contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_11),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.h_7),
                        borderSide: const BorderSide(color: Color(0xFF2878FF), width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.h_7),
                        borderSide: const BorderSide(color: Color(0xFF2878FF), width: 0.5),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.h_12),
                  Row(
                    children: [
                      Expanded(
                        child: _bottomSheetField(
                          context: context,
                          label: 'Category',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              dropdownColor: Theme.of(context).cardColor,
                              value: selectedCategory,
                              isExpanded: true,
                              icon: Icon(CupertinoIcons.chevron_down, size: Dimensions.h_12, color: Theme.of(context).highlightColor),
                              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
                              items: const [
                                DropdownMenuItem(value: 'Bikes', child: Text('Bikes')),
                                DropdownMenuItem(value: 'Cars', child: Text('Cars')),
                                DropdownMenuItem(value: 'Electronics', child: Text('Electronics')),
                                DropdownMenuItem(value: 'Furniture', child: Text('Furniture')),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    selectedCategory = value;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Dimensions.w_10),
                      Expanded(
                        child: _bottomSheetField(
                          context: context,
                          label: 'Condition',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              dropdownColor: Theme.of(context).cardColor,
                              value: selectedCondition,
                              isExpanded: true,
                              icon: Icon(CupertinoIcons.chevron_down, size: Dimensions.h_12, color: Theme.of(context).highlightColor),
                              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
                              items: const [
                                DropdownMenuItem(value: 'Like New', child: Text('Like New')),
                                DropdownMenuItem(value: 'Good', child: Text('Good')),
                                DropdownMenuItem(value: 'Fair', child: Text('Fair')),
                                DropdownMenuItem(value: 'Used', child: Text('Used')),
                              ],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    selectedCondition = value;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_12),
                  Row(
                    children: [
                      Expanded(
                        child: _bottomSheetTextField(context: context, label: 'Year', controller: yearController, hint: 'Enter year', keyboardType: TextInputType.number),
                      ),
                      SizedBox(width: Dimensions.w_10),
                      Expanded(
                        child: _bottomSheetTextField(context: context, label: 'Brand', controller: brandController, hint: 'Enter brand'),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_12),
                  _bottomSheetTextField(context: context, label: 'Model', controller: modelController, hint: 'Enter model'),
                  SizedBox(height: Dimensions.h_20),
                  SizedBox(
                    width: double.infinity,
                    height: Dimensions.h_35,
                    child: ElevatedButton(
                      onPressed: () {
                        final data = {'title': titleController.text.trim(), 'category': selectedCategory, 'condition': selectedCondition, 'year': yearController.text.trim(), 'brand': brandController.text.trim(), 'model': modelController.text.trim()};

                        Get.back(result: data);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1769D8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_7)),
                      ),
                      child: Text(
                        'Save Item Details',
                        style: TextStyle(color: Colors.white, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.h_20),
                ],
              ),
            ),
          );
        },
      ),
      isScrollControlled: false,
    );
  }

  Widget _bottomSheetField({required BuildContext context, required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: Dimensions.h_5),
        Container(
          height: Dimensions.h_35,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.h_7),
            border: Border.all(color: const Color(0xFF2878FF), width: 0.5),
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _bottomSheetTextField({required BuildContext context, required String label, required TextEditingController controller, required String hint, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: Dimensions.h_5),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10),
            contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_10),
            isDense: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.h_7),
              borderSide: const BorderSide(color: Color(0xFF2878FF), width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.h_7),
              borderSide: const BorderSide(color: Color(0xFF2878FF), width: 0.5),
            ),
          ),
        ),
      ],
    );
  }

  void showDescriptionBottomSheet(BuildContext context) {
    final descriptionController = TextEditingController(
      text: garageController.description.isNotEmpty ? garageController.description : 'Excellent condition Trek Fuel EX 8 mountain bike. Well maintained and barely used. Full suspension, 29” wheels, size Large.\nUpgraded pedals and bottle cage included. No major scratches. Ready to ride!',
    );

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(left: Dimensions.w_15, right: Dimensions.w_15, top: Dimensions.h_12, bottom: MediaQuery.of(context).viewInsets.bottom + Dimensions.h_15),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.h_18), topRight: Radius.circular(Dimensions.h_18)),
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Edit Description',
                          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_16, fontWeight: FontWeight.w900),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: Dimensions.h_25,
                          height: Dimensions.h_25,
                          decoration: BoxDecoration(color: Theme.of(context).highlightColor.withValues(alpha: 0.1), shape: BoxShape.circle),
                          child: Icon(CupertinoIcons.xmark, color: Theme.of(context).primaryColor, size: Dimensions.h_13),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_18),
                  TextField(
                    controller: descriptionController,
                    maxLines: 8,
                    minLines: 6,
                    maxLength: 1000,
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (value) {
                      setState(() {});
                    },
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, height: 1.4),
                    decoration: InputDecoration(
                      hintText: 'Describe your item, condition, features and anything buyers should know...',
                      hintStyle: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, height: 1.4),
                      counterText: '${descriptionController.text.length}/1000',
                      counterStyle: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_8),
                      contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.h_8),
                        borderSide: const BorderSide(color: Color(0xFF2878FF), width: 0.8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.h_8),
                        borderSide: const BorderSide(color: Color(0xFF2878FF), width: 1.2),
                      ),
                    ),
                  ),

                  SizedBox(height: Dimensions.h_18),

                  SizedBox(
                    width: double.infinity,
                    height: Dimensions.h_35,
                    child: ElevatedButton(
                      onPressed: () {
                        garageController.description = descriptionController.text.trim();
                        garageController.update([ControllerBuilders.addGarageItemController]);

                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1769D8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_7)),
                      ),
                      child: Text(
                        'Save Description',
                        style: TextStyle(color: Colors.white, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.h_20),
                ],
              ),
            );
          },
        ),
      ),
      isScrollControlled: false,
    );
  }

  void showPriceBottomSheet(BuildContext context) {
    final priceController = TextEditingController(text: garageController.price);
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(left: Dimensions.w_15, right: Dimensions.w_15, top: Dimensions.h_12, bottom: MediaQuery.of(context).viewInsets.bottom + Dimensions.h_15),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.h_18), topRight: Radius.circular(Dimensions.h_18)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Your Price',
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_16, fontWeight: FontWeight.w900),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: Dimensions.h_25,
                      height: Dimensions.h_25,
                      decoration: BoxDecoration(color: Theme.of(context).highlightColor.withValues(alpha: 0.1), shape: BoxShape.circle),
                      child: Icon(CupertinoIcons.xmark, color: Theme.of(context).primaryColor, size: Dimensions.h_13),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_18),
              TextField(
                controller: priceController,
                autofocus: true,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: Dimensions.w_12, right: Dimensions.w_5),
                    child: Text(
                      '\$',
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: Dimensions.w_25),
                  hintText: 'Enter your price',
                  hintStyle: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10),
                  contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.h_7),
                    borderSide: const BorderSide(color: Color(0xFF2878FF), width: 0.8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.h_7),
                    borderSide: const BorderSide(color: Color(0xFF2878FF), width: 1.2),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h_8),
              Text(
                'Set a competitive price based on similar items in your area.',
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: Dimensions.h_20),
              SizedBox(
                width: double.infinity,
                height: Dimensions.h_35,
                child: ElevatedButton(
                  onPressed: () {
                    final value = priceController.text.trim();

                    if (value.isEmpty || double.tryParse(value) == null) {
                      return;
                    }

                    garageController.updatePrice(value);

                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1769D8),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_7)),
                  ),
                  child: Text(
                    'Save Price',
                    style: TextStyle(color: Colors.white, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h_20),
            ],
          ),
        ),
      ),
      isScrollControlled: false,
    );
  }

  void showChangeLocationBottomSheet(BuildContext context) {
    final towns = ['Issaquah, WA', 'Seattle, WA', 'Bellevue, WA', 'Redmond, WA', 'Kirkland, WA', 'Sammamish, WA', 'Mercer Island, WA', 'Renton, WA', 'Newcastle, WA', 'Bothell, WA', 'Woodinville, WA', 'North Bend, WA'];

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(left: Dimensions.w_15, right: Dimensions.w_15, top: Dimensions.h_12, bottom: Dimensions.h_15),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.h_18), topRight: Radius.circular(Dimensions.h_18)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Change Location',
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_16, fontWeight: FontWeight.w900),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: Dimensions.h_25,
                      height: Dimensions.h_25,
                      decoration: BoxDecoration(color: Theme.of(context).highlightColor.withValues(alpha: 0.1), shape: BoxShape.circle),
                      child: Icon(CupertinoIcons.xmark, color: Theme.of(context).primaryColor, size: Dimensions.h_13),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_15),
              GetBuilder(
                init: garageController,
                id: ControllerBuilders.addGarageItemController,
                builder: (controller) {
                  return Wrap(
                    spacing: Dimensions.w_7,
                    runSpacing: Dimensions.h_8,
                    children: towns.map((town) {
                      final isSelected = garageController.selectedLocation == town;
                      return GestureDetector(
                        onTap: () {
                          garageController.updateLocation(town);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_8),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFE8F2FF) : Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(Dimensions.h_6),
                            border: Border.all(color: isSelected ? const Color(0xFF075DC9) : Theme.of(context).dividerColor, width: isSelected ? 0.9 : 0.5),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isSelected) ...[Icon(CupertinoIcons.checkmark, color: const Color(0xFF075DC9), size: Dimensions.h_11), SizedBox(width: Dimensions.w_4)],
                              Text(
                                town,
                                style: TextStyle(color: isSelected ? const Color(0xFF075DC9) : Theme.of(context).primaryColor, fontSize: FontSize.sp_11, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              SizedBox(height: Dimensions.h_10),
            ],
          ),
        ),
      ),
      isScrollControlled: false,
    );
  }
}
