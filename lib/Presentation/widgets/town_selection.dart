import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/widgets/cache_image.dart';
import 'package:wikixm/constants/fontsize.dart';
import 'package:wikixm/constants/appcolor.dart';

class TownSelection extends StatefulWidget {
  const TownSelection({super.key});

  @override
  State<TownSelection> createState() => _TownSelectionState();
}

class _TownSelectionState extends State<TownSelection> {
  final TextEditingController searchController = TextEditingController();

  final List<TownModel> recentTowns = [
    TownModel(name: 'Sammamish, WA', subtitle: 'Washington, United States', imageUrl: 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=300'),
    TownModel(name: 'Bellevue, WA', subtitle: 'Washington, United States', imageUrl: 'https://images.unsplash.com/photo-1519501025264-65ba15a82390?w=300'),
    TownModel(name: 'Redmond, WA', subtitle: 'Washington, United States', imageUrl: 'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=300'),
    TownModel(name: 'Seattle, WA', subtitle: 'Washington, United States', imageUrl: 'https://images.unsplash.com/photo-1502175353174-a7a70e73b362?w=300'),
    TownModel(name: 'Renton, WA', subtitle: 'Washington, United States', imageUrl: 'https://images.unsplash.com/photo-1500534623283-312aade485b7?w=300'),
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppColor.backgroundColor(context);
    final primaryText = AppColor.primaryText(context);
    final secondaryText = AppColor.secondaryText(context);
    final mutedText = AppColor.mutedText(context);
    final searchBackground = AppColor.searchBackground(context);
    final currentTownBackground = AppColor.currentTownBackground(context);
    final iconBackground = AppColor.iconBackground(context);
    final closeBackground = AppColor.closeBackground(context);
    final blue = AppColor.blueColor(context);

    return Container(
      height: Get.height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.h_20), topLeft: Radius.circular(Dimensions.h_20)),
      ),
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
      child: Column(
        children: [
          SizedBox(height: Dimensions.h_15),
          buildHeader(primaryText: primaryText, secondaryText: secondaryText, iconBackground: iconBackground, blue: blue, closeBackground: closeBackground),
          SizedBox(height: Dimensions.h_10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSearchField(searchBackground: searchBackground, mutedText: mutedText, blue: blue, primaryText: primaryText),
                  SizedBox(height: Dimensions.h_20),
                  buildSectionTitle('Current Town', secondaryText: Theme.of(context).primaryColor),
                  SizedBox(height: Dimensions.h_10),
                  buildCurrentTown(backgroundColor: currentTownBackground, primaryText: primaryText, secondaryText: secondaryText, blue: blue),
                  SizedBox(height: Dimensions.h_20),
                  buildSectionTitle('MY TOWNS', secondaryText: Theme.of(context).primaryColor),
                  SizedBox(height: Dimensions.h_5),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: recentTowns.length,
                    itemBuilder: (c,i) {
                    var town = recentTowns[i];
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_10),
                      decoration: BoxDecoration(
                        border: recentTowns.length - 1 == i ? null: Border(bottom: BorderSide(color: Theme.of(context).highlightColor, width: 0.10)),
                      ),
                      child: Row(
                        children: [
                          buildTownImage(town.imageUrl),
                          SizedBox(width: Dimensions.w_10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  town.name,
                                  style: TextStyle(fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700, color: primaryText),
                                ),
                                Text(
                                  town.subtitle,
                                  style: TextStyle(fontSize: FontSize.sp_10, color: secondaryText),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader({required Color primaryText, required Color secondaryText, required Color iconBackground, required Color blue, required Color closeBackground}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Dimensions.h_25,
          height: Dimensions.h_25,
          decoration: BoxDecoration(color: iconBackground, shape: BoxShape.circle),
          child: Icon(Icons.location_on_rounded, size: Dimensions.h_15, color: blue),
        ),
        SizedBox(width: Dimensions.w_15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select a Town',
                style: TextStyle(fontSize: FontSize.sp_18, fontWeight: FontWeight.w900, color: primaryText, height: 1.1),
              ),
              SizedBox(height: Dimensions.h_3),
              Text(
                'Choose your community to view local updates',
                style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, color: secondaryText, height: 1.2),
              ),
            ],
          ),
        ),
        SizedBox(width: Dimensions.w_8),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: Dimensions.h_25,
            height: Dimensions.h_25,
            decoration: BoxDecoration(color: closeBackground, shape: BoxShape.circle),
            child: Icon(Icons.close_rounded, size: Dimensions.h_15, color: secondaryText),
          ),
        ),
      ],
    );
  }

  Widget buildSearchField({required Color searchBackground, required Color mutedText, required Color blue, required Color primaryText}) {
    return SizedBox(
      height: Dimensions.h_32,
      child: TextField(
        controller: searchController,
        style: TextStyle(fontSize: FontSize.sp_11, color: primaryText),
        decoration: InputDecoration(
          hintText: 'Search for a town or city',
          hintStyle: TextStyle(fontSize: FontSize.sp_11, color: mutedText),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: Dimensions.w_10),
            child: Icon(Icons.search_rounded, size: Dimensions.h_20, color: mutedText),
          ),
          filled: true,
          fillColor: searchBackground,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(40), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: blue, width: 1.5),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_10),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title, {required Color secondaryText}) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w800, color: secondaryText),
    );
  }

  Widget buildCurrentTown({required Color backgroundColor, required Color primaryText, required Color secondaryText, required Color blue}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_6),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(Dimensions.h_10)),
      child: Row(
        children: [
          buildTownImage('https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=300'),
          SizedBox(width: Dimensions.w_10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Issaquah, WA',
                  style: TextStyle(fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700, color: primaryText),
                ),

                Text(
                  'Washington, United States',
                  style: TextStyle(fontSize: FontSize.sp_10, color: secondaryText),
                ),
              ],
            ),
          ),
          Container(
            width: Dimensions.h_15,
            height: Dimensions.h_15,
            decoration: BoxDecoration(color: blue, shape: BoxShape.circle),
            child: Icon(Icons.check_rounded, color: Colors.white, size: Dimensions.h_12),
          ),
        ],
      ),
    );
  }

  Widget buildTownRow(TownModel town, {required Widget trailing, required Color primaryText, required Color secondaryText, required Color dividerColor}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: dividerColor, width: 0.5)),
      ),
      child: Row(
        children: [
          buildTownImage(town.imageUrl),
          SizedBox(width: Dimensions.w_10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  town.name,
                  style: TextStyle(fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700, color: primaryText),
                ),
                Text(
                  town.subtitle,
                  style: TextStyle(fontSize: FontSize.sp_10, color: secondaryText),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget buildTownImage(String imageUrl) {
    return AppCacheImage(imageUrl: imageUrl, size: Dimensions.h_35, widthSize: Dimensions.h_35, isShadow: false, radius: Dimensions.h_4);
  }
}

class TownModel {
  final String name;
  final String subtitle;
  final String imageUrl;

  const TownModel({required this.name, required this.subtitle, required this.imageUrl});
}
