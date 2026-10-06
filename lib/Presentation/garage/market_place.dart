import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wikixm/Presentation/garage/controller.dart';
import 'package:wikixm/Presentation/widgets/common_blur_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/drawer/src/slider_direction.dart';
import 'package:wikixm/approutes.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/cache_image.dart';
import '../widgets/drawer/src/slider_drawer.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({super.key});

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  final GlobalKey<SliderDrawerState> sliderDrawerKey = GlobalKey<SliderDrawerState>();
  final GarageController garageController = Get.put(GarageController());
  final ScrollController marketPlaceScrollController = ScrollController();

  void marketPlaceScrollListener() {
    if (!marketPlaceScrollController.hasClients) {
      return;
    }
    final position = marketPlaceScrollController.position;
    if (position.pixels >= position.maxScrollExtent - 300) {
      if (!garageController.isLoading && !garageController.isLoadingMoreMarketPlace && garageController.hasMoreMarketPlace) {
        garageController.getMarketPlace(page: garageController.currentMarketPlacePage + 1);
      }
    }
  }

  @override
  void initState() {
    garageController.getMarketPlaceData();
    marketPlaceScrollController.addListener(marketPlaceScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    marketPlaceScrollController.dispose();
    garageController.searchDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final muted = isLight ? const Color(0xFF63728F) : const Color(0xFFAAB8CF);
    final line = isLight ? Colors.grey : Colors.white24;
    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);
    final green = isLight ? const Color(0xFF087C4B) : const Color(0xFF64D9A2);
    final blueSoft = isLight ? const Color(0xFFE8F2FF) : const Color(0xFF173D68);
    return GetBuilder(
      init: garageController,
      id: ControllerBuilders.filterController,
      builder: (controller) {
        return SliderDrawer(
          key: sliderDrawerKey,
          sliderOpenSize: Dimensions.w_260,
          isDraggable: false,
          slideDirection: SlideDirection.rightToLeft,
          slider: Container(height: double.infinity, color: Theme.of(context).cardColor, child: filtersWidget(isLight, controller)),
          child: GetBuilder(
            id: ControllerBuilders.marketPlaceController,
            init: garageController,
            builder: (controller) {
              return controller.marketLoading
                  ? SingleChildScrollView(child: loadingShimmer(isLight: isLight))
                  : CommonBlurScaffold(
                      showBack: true,
                      scrollController: marketPlaceScrollController,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Dimensions.h_70),
                            Text(
                              'Issaqauh Garage ',
                              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_22, fontWeight: FontWeight.w900),
                            ),
                            SizedBox(height: Dimensions.h_3),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w_2),
                              child: Text(
                                'Buy. Sell. Local. Real people. Real deals. A stronger community.',
                                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: Dimensions.h_15),
                            SizedBox(
                              height: Dimensions.h_30,
                              child: TextField(
                                controller: controller.searchController,
                                onChanged: controller.onMarketPlaceSearchChanged,
                                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  filled: true,
                                  prefixIcon: SizedBox(
                                    width: Dimensions.w_20,
                                    height: Dimensions.h_20,
                                    child: Icon(CupertinoIcons.search, size: Dimensions.h_15, color: blue),
                                  ),
                                  suffixIcon: controller.isClose ? SizedBox.shrink():SizedBox(
                                    width: Dimensions.w_20,
                                    height: Dimensions.h_20,
                                    child:  GestureDetector(
                                      onTap: () {
                                        controller.searchController.clear();
                                        controller.getMarketPlace(page: 1);
                                        controller.isClose = true;
                                        controller.update([ControllerBuilders.marketPlaceController]);
                                      },
                                      child: Center(
                                        child: Icon(CupertinoIcons.clear_circled_solid, size: Dimensions.h_18, color: Theme.of(context).hintColor),
                                      ),
                                    ),
                                  ),
                                  fillColor: Theme.of(context).cardColor,
                                  hintText: controller.contentData?.search?.placeholder ?? '',
                                  hintStyle: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_11),
                                  contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.h_50),
                                    borderSide: BorderSide(color: isLight ? Colors.grey : Colors.white24, width: 0.4),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(Dimensions.h_50),
                                    borderSide: BorderSide(color: blue, width: 0.5),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Dimensions.h_10),
                            categoryChips(isLight, controller),
                            SizedBox(height: Dimensions.h_10),
                            CommonCard(
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: Dimensions.h_20,
                                        height: Dimensions.h_20,
                                        decoration: BoxDecoration(color: blueSoft, borderRadius: BorderRadius.circular(Dimensions.h_6)),
                                        child: Icon(CupertinoIcons.chart_bar_alt_fill, color: blue, size: Dimensions.h_13),
                                      ),
                                      SizedBox(width: Dimensions.w_7),
                                      Text(
                                        controller.contentData?.pulse?.title ?? '',
                                        style: TextStyle(color: ink, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          Get.toNamed(AppRoutes.marketBrief);
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'View Market Brief',
                                              style: TextStyle(color: blue, fontSize: FontSize.sp_9, fontWeight: FontWeight.w900),
                                            ),
                                            SizedBox(width: Dimensions.w_2),
                                            Icon(CupertinoIcons.arrow_right, color: blue, size: Dimensions.h_8),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.h_10),
                                  Row(
                                    children: [
                                      SizedBox(width: Dimensions.w_5),
                                      ...List.generate(controller.contentData?.pulse?.metrics?.length ?? 0, (index) {
                                        final metric = controller.contentData?.pulse?.metrics![index];
                                        Color metricColor;
                                        switch (metric?.className) {
                                          case 'green':
                                            metricColor = green;
                                            break;
                                          case 'red':
                                            metricColor = const Color(0xFFD52C48);
                                            break;
                                          default:
                                            metricColor = blue;
                                        }
                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '${metric?.value ?? 0}',
                                              style: TextStyle(color: metricColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w900),
                                            ),
                                            SizedBox(width: Dimensions.w_3),
                                            Text(
                                              metric?.label ?? '-',
                                              style: TextStyle(color: muted, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(width: Dimensions.w_7),
                                            Container(width: 1, height: Dimensions.h_15, color: line),
                                            SizedBox(width: Dimensions.w_7),
                                          ],
                                        );
                                      }),
                                      SizedBox(width: Dimensions.w_1),
                                      Icon(Icons.trending_up_rounded, color: green, size: Dimensions.h_15),
                                      SizedBox(width: Dimensions.w_3),
                                      Expanded(
                                        child: Text(
                                          controller.contentData?.pulse?.trending?.label ?? '',
                                          style: TextStyle(color: green, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w800, height: 0.9),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Dimensions.h_15),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fresh near you'.toUpperCase(),
                                      style: TextStyle(color: blue, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w900),
                                    ),
                                    SizedBox(height: Dimensions.h_1),
                                    Text(
                                      '${controller.marketPlaceData?.pagination?.total} Local Listings',
                                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    sliderDrawerKey.currentState?.openSlider();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.filter_list_alt, size: Dimensions.h_13, color: blue),
                                      SizedBox(width: Dimensions.w_2),
                                      Text(
                                        'FILTERS',
                                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.h_10),
                            itemsGrid(isLight, controller),
                            SizedBox(height: Dimensions.h_20),
                          ],
                        ),
                      ),
                    );
            },
          ),
        );
      },
    );
  }

  Widget categoryChips(bool isLight, GarageController controller) {
    final categories = (controller.marketFilters?.categories ?? []).where((category) => category.value?.isNotEmpty == true).toList();
    final deals = controller.contentData?.deals;
    final allDeals = deals?.options?.where((deal) => deal.value == '0').firstOrNull;
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);
    final surface = isLight ? Colors.white : const Color(0xFF102A47);
    final border = isLight ? const Color(0xFFD6E3EE) : const Color(0xFF294762);

    return SizedBox(
      height: Dimensions.h_25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: categories.length + (allDeals != null ? 1 : 0),
        itemBuilder: (context, index) {
          if (allDeals != null && index == 0) {
            final isSelected = controller.selectedDiscount == '0';
            return Padding(
              padding: EdgeInsets.only(right: Dimensions.w_6),
              child: GestureDetector(
                onTap: () async {
                  final isAlreadySelected = controller.selectedDiscount == '0';
                  if (isAlreadySelected) {
                    controller.selectedDiscount = null;
                  } else {
                    controller.selectedDiscount = '0';
                  }
                  controller.currentMarketPlacePage = 1;
                  controller.lastMarketPlacePage = 1;
                  controller.hasMoreMarketPlace = true;
                  controller.category = null;
                  controller.update([ControllerBuilders.marketPlaceController]);
                  await controller.getMarketPlace(page: 1);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                  decoration: BoxDecoration(
                    color: isSelected ? blue : surface,
                    borderRadius: BorderRadius.circular(Dimensions.h_50),
                    border: Border.all(color: isSelected ? blue : border, width: 0.7),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(FontAwesomeIcons.tag, size: Dimensions.h_11, color: isSelected ? Colors.white : blue),
                      SizedBox(width: Dimensions.w_5),
                      Text(
                        allDeals.label ?? 'All Deals',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: isSelected ? Colors.white : ink, fontSize: FontSize.sp_9_5, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          final categoryIndex = index - (allDeals != null ? 1 : 0);
          final category = categories[categoryIndex];
          final isSelected = controller.category?.value == category.value;
          return Padding(
            padding: EdgeInsets.only(right: Dimensions.w_6),
            child: GestureDetector(
              onTap: () async {
                final isAlreadySelected = controller.category?.value == category.value;
                if (isAlreadySelected) {
                  controller.category = null;
                } else {
                  controller.category = category;
                }
                controller.selectedDiscount = null;
                controller.currentMarketPlacePage = 1;
                controller.lastMarketPlacePage = 1;
                controller.hasMoreMarketPlace = true;
                controller.update([ControllerBuilders.marketPlaceController]);
                await controller.getMarketPlace(page: 1);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                decoration: BoxDecoration(
                  color: isSelected ? blue : surface,
                  borderRadius: BorderRadius.circular(Dimensions.h_50),
                  border: Border.all(color: isSelected ? blue : border, width: 0.7),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(_categoryIcon(category.icon), size: Dimensions.h_12, color: isSelected ? Colors.white : blue),
                    SizedBox(width: Dimensions.w_6),
                    Text(
                      category.label ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: isSelected ? Colors.white : ink, fontSize: FontSize.sp_10, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  FaIconData _categoryIcon(String? icon) {
    switch (icon) {
      case 'toy-blocks':
        return FontAwesomeIcons.cubes;

      case 'crossed-tools':
        return FontAwesomeIcons.screwdriverWrench;

      case 't-shirt':
        return FontAwesomeIcons.shirt;

      case 'collectible-box':
        return FontAwesomeIcons.boxOpen;

      case 'mobile-device':
        return FontAwesomeIcons.mobileScreenButton;

      case 'leaf':
        return FontAwesomeIcons.leaf;

      case 'bike':
        return FontAwesomeIcons.bicycle;

      case 'more-vertical':
        return FontAwesomeIcons.tag;

      default:
        return FontAwesomeIcons.tag;
    }
  }

  Widget filtersWidget(bool isLight, GarageController controller) {
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final muted = isLight ? const Color(0xFF63728F) : const Color(0xFFAAB8CF);
    final surface = isLight ? Colors.white : const Color(0xFF102A47);
    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);
    final border = isLight ? Colors.grey : Colors.white24;
    final filterData = controller.marketFilters;
    final red = isLight ? const Color(0xFFB4232D) : const Color(0xFFFF8E96);
    Widget sectionTitle(String title) {
      return Padding(
        padding: EdgeInsets.only(bottom: Dimensions.h_7),
        child: Text(
          title.toUpperCase(),
          style: TextStyle(color: ink, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
        ),
      );
    }

    Widget radioItem({required String title, required bool selected, required bool disabled, required VoidCallback? onTap}) {
      final Color textColor = disabled ? muted.withValues(alpha: 0.5) : Theme.of(context).highlightColor;
      final Color borderColor = disabled
          ? muted.withValues(alpha: 0.35)
          : selected
          ? blue
          : muted;
      return Padding(
        padding: EdgeInsets.only(bottom: Dimensions.h_8),
        child: GestureDetector(
          onTap: disabled ? null : onTap,
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Container(
                width: Dimensions.h_13,
                height: Dimensions.h_13,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: borderColor, width: 1),
                ),
                child: selected && !disabled
                    ? Center(
                        child: Container(
                          width: Dimensions.h_7,
                          height: Dimensions.h_7,
                          decoration: BoxDecoration(color: blue, shape: BoxShape.circle),
                        ),
                      )
                    : null,
              ),
              SizedBox(width: Dimensions.w_7),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: textColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget checkItem({required String title, required bool selected, required bool disabled, required VoidCallback? onTap}) {
      final Color textColor = disabled ? muted.withValues(alpha: 0.5) : Theme.of(context).highlightColor;
      return Padding(
        padding: EdgeInsets.only(bottom: Dimensions.h_8),
        child: GestureDetector(
          onTap: disabled ? null : onTap,
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Container(
                width: Dimensions.h_13,
                height: Dimensions.h_13,
                decoration: BoxDecoration(
                  color: selected ? blue : Colors.transparent,
                  border: Border.all(
                    color: disabled
                        ? muted.withValues(alpha: 0.35)
                        : selected
                        ? blue
                        : muted,
                    width: 0.8,
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.h_1),
                ),
                child: selected ? Icon(CupertinoIcons.checkmark, size: Dimensions.h_12, color: Colors.white) : null,
              ),
              SizedBox(width: Dimensions.w_7),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(color: textColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget priceField({required String hint, required TextEditingController textController}) {
      return Expanded(
        child: Container(
          height: Dimensions.h_30,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_7),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(Dimensions.h_5),
            border: Border.all(color: border, width: 0.4),
          ),
          child: Row(
            children: [
              Text(
                '\$',
                style: TextStyle(color: blue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
              ),
              SizedBox(width: Dimensions.w_4),
              Expanded(
                child: TextField(
                  controller: textController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(color: ink, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(color: muted, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget divider() {
      return Container(
        height: 0.4,
        width: double.infinity,
        color: border,
        margin: EdgeInsets.only(top: Dimensions.h_10, bottom: Dimensions.h_10),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.h_40),
          Row(
            children: [
              Text(
                'Filters'.toUpperCase(),
                style: TextStyle(color: ink, fontSize: FontSize.sp_14, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  sliderDrawerKey.currentState?.closeSlider();
                },
                child: Icon(CupertinoIcons.clear_circled_solid, size: Dimensions.h_20, color: ink),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_13),
          sectionTitle('Price Range'),
          Row(
            children: [
              priceField(hint: 'Min', textController: controller.minPriceController),
              SizedBox(width: Dimensions.w_6),
              priceField(hint: 'Max', textController: controller.maxPriceController),
            ],
          ),
          SizedBox(height: Dimensions.h_13),
          sectionTitle('Distance'),
          Container(
            height: Dimensions.h_30,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(Dimensions.h_5),
              border: Border.all(color: border, width: 0.4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: filterData?.distances?.any((item) => item.value == controller.selectedDistance) == true ? controller.selectedDistance : null,
                isExpanded: true,
                icon: Icon(CupertinoIcons.chevron_down, color: ink, size: Dimensions.h_10),
                dropdownColor: surface,
                style: TextStyle(color: muted, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                items: (filterData?.distances ?? []).map<DropdownMenuItem<String>>((distance) {
                  return DropdownMenuItem<String>(
                    value: distance.value,
                    child: Text(
                      distance.label ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: muted, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                    ),
                  );
                }).toList(),

                onChanged: (value) {
                  if (value == null) return;

                  controller.selectedDistance = value;

                  controller.update([ControllerBuilders.filterController]);
                },
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_13),
          sectionTitle('Condition'),
          SizedBox(height: Dimensions.h_5),
          ...List.generate(filterData?.conditions?.length ?? 0, (index) {
            final condition = filterData!.conditions![index];
            final value = condition.value ?? '';
            return checkItem(
              title: condition.label ?? '',
              selected: controller.selectedConditions.contains(value),
              disabled: false,
              onTap: () {
                controller.toggleCondition(value);
              },
            );
          }),
          divider(),
          sectionTitle('Seller Type'),
          SizedBox(height: Dimensions.h_5),
          ...List.generate(filterData?.sellers?.length ?? 0, (index) {
            final seller = filterData!.sellers![index];
            final value = seller.value ?? '';
            return radioItem(
              title: seller.label ?? '',
              selected: controller.selectedSeller == value,
              disabled: seller.disabled == true,
              onTap: seller.disabled == true
                  ? null
                  : () {
                      controller.selectedSeller = value;
                      controller.update([ControllerBuilders.filterController]);
                    },
            );
          }),
          divider(),
          sectionTitle('Listing Date'),
          SizedBox(height: Dimensions.h_5),
          ...List.generate(filterData?.dates?.length ?? 0, (index) {
            final date = filterData!.dates![index];
            final value = date.value ?? '';
            return radioItem(
              title: date.label ?? '',
              selected: controller.selectedDate == value,
              disabled: false,
              onTap: () {
                controller.selectedDate = value;
                controller.update([ControllerBuilders.filterController]);
              },
            );
          }),
          divider(),
          sectionTitle('More Filters'),
          SizedBox(height: Dimensions.h_5),
          ...List.generate(filterData?.more?.length ?? 0, (index) {
            final more = filterData!.more![index];
            final value = more.value ?? '';
            return checkItem(
              title: more.label ?? '',
              selected: controller.selectedMore.contains(value),
              disabled: more.disabled == true,
              onTap: () {
                controller.toggleMoreFilter(value);
              },
            );
          }),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: Dimensions.h_28,
                  child: OutlinedButton(
                    onPressed: () {
                      controller.clearFiltersAndReload();
                      sliderDrawerKey.currentState?.closeSlider();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: red,
                      side: BorderSide(color: red, width: 0.8),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_6)),
                    ),
                    child: Text(
                      'Clear All',
                      style: TextStyle(color: red, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_10),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: Dimensions.h_28,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.getMarketPlace();
                      sliderDrawerKey.currentState?.closeSlider();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_6)),
                    ),
                    child: Text(
                      'Apply Filters',
                      style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_13),
        ],
      ),
    );
  }

  Widget itemsGrid(bool isLight, GarageController controller) {
    final ink = isLight ? const Color(0xFF08154F) : const Color(0xFFF4F7FF);
    final blue = isLight ? const Color(0xFF075DC9) : const Color(0xFF78ADFF);
    if (controller.isLoading) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_6, mainAxisSpacing: Dimensions.h_6, childAspectRatio: 0.67),
        itemBuilder: (context, index) {
          return itemShimmer(isLight: isLight);
        },
      );
    }

    if (controller.marketPlaceData?.items != null && controller.marketPlaceData?.items?.isEmpty == true) {
      return CommonCard(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_20, vertical: Dimensions.h_20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.search, size: Dimensions.h_40, color: blue),
              SizedBox(height: Dimensions.h_10),
              Text(
                'No close matches yet',
                textAlign: TextAlign.center,
                style: TextStyle(color: ink, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: Dimensions.h_4),
              Text(
                'Try another keyword or clear a filter to see more local listings.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, height: 1.3),
              ),
              SizedBox(height: Dimensions.h_12),
              SizedBox(
                height: Dimensions.h_25,
                child: OutlinedButton(
                  onPressed: () async {
                    await controller.clearFiltersAndReload();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: blue,
                    side: BorderSide(color: blue.withValues(alpha: 0.35), width: 0.8),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_6)),
                  ),
                  child: Text(
                    'Clear filters',
                    style: TextStyle(color: blue, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: controller.marketPlaceData?.items?.length ?? 0,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_6, mainAxisSpacing: Dimensions.h_6, childAspectRatio: 0.65),
          itemBuilder: (context, index) {
            final item = controller.marketPlaceData?.items?[index];
            return CommonCard(
              padding: EdgeInsets.zero,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.h_10), topRight: Radius.circular(Dimensions.h_10)),
                          child: AppCacheImage(imageUrl: item?.imageUrl ?? '', radius: 0, widthSize: Get.width, size: Dimensions.h_120, fit: BoxFit.cover, errorImage: item?.fallbackImageUrl ?? ''),
                        ),
                        if (item?.discountPercent != null && item?.discountPercent != 0)
                          Positioned(
                            left: Dimensions.w_6,
                            top: Dimensions.h_6,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_2),
                              decoration: BoxDecoration(color: const Color(0xFFB4232D), borderRadius: BorderRadius.circular(Dimensions.h_5)),
                              child: Text(
                                "${item?.discountPercent ?? 0}% OFF",
                                style: TextStyle(color: Colors.white, fontSize: FontSize.sp_8_5, fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        Positioned(
                          right: Dimensions.w_6,
                          top: Dimensions.h_6,
                          child: Container(
                            padding: EdgeInsets.only(top: Dimensions.h_2),
                            width: Dimensions.h_20,
                            height: Dimensions.h_20,
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 0.4),
                            ),
                            child: Center(
                              child: Icon(item?.saved == true ? CupertinoIcons.heart_fill : CupertinoIcons.heart, color: item?.saved == true ? Colors.redAccent : Colors.white, size: Dimensions.h_13),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(Dimensions.w_5, Dimensions.h_6, Dimensions.w_7, Dimensions.h_6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (item?.previousPrice != null)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  formatPrice(item?.price ?? 0),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: ink, fontSize: FontSize.sp_15, fontWeight: FontWeight.w900),
                                ),
                                SizedBox(width: Dimensions.w_5),
                                Text(
                                  formatPrice(item?.previousPrice ?? 0),
                                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, decoration: TextDecoration.lineThrough, decorationColor: Theme.of(context).highlightColor, fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          else
                            Text(
                              formatPrice(item?.price ?? 0),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: ink, fontSize: FontSize.sp_15, fontWeight: FontWeight.w900),
                            ),
                          SizedBox(height: Dimensions.h_5),
                          Text(
                            item?.title ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800, height: 1.15),
                          ),
                          SizedBox(height: Dimensions.h_8),
                          Padding(
                            padding: EdgeInsets.only(left: Dimensions.w_1),
                            child: Row(
                              children: [
                                Icon(Icons.location_on_sharp, size: Dimensions.h_10, color: blue),
                                Expanded(
                                  child: Text(
                                    locationText(item?.location ?? '', item?.timeLabel ?? ''),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Dimensions.h_8),
                          Padding(
                            padding: EdgeInsets.only(left: Dimensions.w_2),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(CupertinoIcons.eye, size: Dimensions.h_10, color: Theme.of(context).highlightColor),
                                      SizedBox(width: Dimensions.w_3),
                                      Text(
                                        '${item?.views ?? ''} views',
                                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(CupertinoIcons.heart, size: Dimensions.h_10, color: blue),
                                    SizedBox(width: Dimensions.w_3),
                                    Text(
                                      '${item?.saves ?? ''} saves',
                                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (controller.isLoadingMoreMarketPlace)
          Padding(
            padding: EdgeInsets.symmetric(vertical: Dimensions.h_18),
            child: SizedBox(
              width: Dimensions.h_20,
              height: Dimensions.h_20,
              child: CupertinoActivityIndicator(color: blue, radius: Dimensions.h_10),
            ),
          ),
        if (!controller.hasMoreMarketPlace && (controller.marketPlaceData?.items?.isNotEmpty ?? false)) SizedBox(height: Dimensions.h_20),
      ],
    );
  }

  Widget itemShimmer({required bool isLight}) {
    final shimmerBase = isLight ? const Color(0xFFE8EDF4) : const Color(0xFF1D3045);
    return CommonCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Dimensions.h_120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: shimmerBase,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.h_10), topRight: Radius.circular(Dimensions.h_10)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Dimensions.w_7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimensions.h_15,
                  width: Dimensions.w_55,
                  decoration: BoxDecoration(color: shimmerBase, borderRadius: BorderRadius.circular(Dimensions.h_4)),
                ),
                SizedBox(height: Dimensions.h_8),
                Container(
                  height: Dimensions.h_12,
                  width: double.infinity,
                  decoration: BoxDecoration(color: shimmerBase, borderRadius: BorderRadius.circular(Dimensions.h_4)),
                ),
                SizedBox(height: Dimensions.h_5),
                Container(
                  height: Dimensions.h_12,
                  width: Dimensions.w_80,
                  decoration: BoxDecoration(color: shimmerBase, borderRadius: BorderRadius.circular(Dimensions.h_4)),
                ),
                SizedBox(height: Dimensions.h_10),
                Container(
                  height: Dimensions.h_10,
                  width: Dimensions.w_100,
                  decoration: BoxDecoration(color: shimmerBase, borderRadius: BorderRadius.circular(Dimensions.h_4)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatPrice(num price) {
    if (price == 0) {
      return '\$0';
    }
    final value = price.toDouble();
    if (value == value.roundToDouble()) {
      return '\$${value.toInt()}';
    }
    return '\$${value.toStringAsFixed(2)}';
  }

  String locationText(String location, String timeLabel) {
    if (location.isEmpty && timeLabel.isEmpty) {
      return '';
    }

    if (location.isEmpty) {
      return timeLabel;
    }

    if (timeLabel.isEmpty) {
      return location;
    }

    return '$location • $timeLabel';
  }

  Widget loadingShimmer({required bool isLight}) {
    final shimmerBase = isLight ? const Color(0xFFE9EEF5) : const Color(0xFF18334F);
    final shimmerHighlight = isLight ? const Color(0xFFF7F9FC) : const Color(0xFF294863);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: shimmerBase,
            highlightColor: shimmerHighlight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: Dimensions.h_120,
                  decoration: BoxDecoration(
                    color: shimmerBase,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.h_8), topRight: Radius.circular(Dimensions.h_8)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(Dimensions.w_6, Dimensions.h_7, Dimensions.w_7, Dimensions.h_7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Dimensions.w_55,
                        height: Dimensions.h_15,
                        decoration: BoxDecoration(color: shimmerBase, borderRadius: BorderRadius.circular(Dimensions.h_3)),
                      ),
                      SizedBox(height: Dimensions.h_7),
                      Container(
                        width: double.infinity,
                        height: Dimensions.h_11,
                        decoration: BoxDecoration(color: shimmerBase, borderRadius: BorderRadius.circular(Dimensions.h_3)),
                      ),
                      SizedBox(height: Dimensions.h_5),
                      Container(
                        width: Dimensions.w_65,
                        height: Dimensions.h_11,
                        decoration: BoxDecoration(color: shimmerBase, borderRadius: BorderRadius.circular(Dimensions.h_3)),
                      ),
                      SizedBox(height: Dimensions.h_10),
                      Row(
                        children: [
                          Container(
                            width: Dimensions.h_10,
                            height: Dimensions.h_10,
                            decoration: BoxDecoration(color: shimmerBase, shape: BoxShape.circle),
                          ),
                          SizedBox(width: Dimensions.w_4),
                          Expanded(
                            child: Container(
                              height: Dimensions.h_10,
                              decoration: BoxDecoration(color: shimmerBase, borderRadius: BorderRadius.circular(Dimensions.h_3)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_10),
                      Row(
                        children: [
                          Container(
                            width: Dimensions.w_35,
                            height: Dimensions.h_10,
                            decoration: BoxDecoration(color: shimmerBase, borderRadius: BorderRadius.circular(Dimensions.h_3)),
                          ),
                          const Spacer(),
                          Container(
                            width: Dimensions.w_35,
                            height: Dimensions.h_10,
                            decoration: BoxDecoration(color: shimmerBase, borderRadius: BorderRadius.circular(Dimensions.h_3)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_6, mainAxisSpacing: Dimensions.h_6, childAspectRatio: 0.67),
            itemBuilder: (context, index) {
              return itemShimmer(isLight: isLight);
            },
          ),
        ],
      ),
    );
  }
}
