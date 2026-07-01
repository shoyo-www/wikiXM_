import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/dashboard/controller.dart';
import 'package:wikixm/approutes.dart';
import 'package:wikixm/constants/constants.dart';
import 'package:wikixm/constants/fontsize.dart';

class TownSearch extends StatefulWidget {
  const TownSearch({super.key});

  static Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 1,
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            clipBehavior: Clip.antiAlias,
            child: const TownSearch(),
          ),
        );
      },
    );
  }

  @override
  State<TownSearch> createState() => _TownSearchState();
}

class _TownSearchState extends State<TownSearch> {
  final DashboardController controller = Get.find<DashboardController>();
  Timer? _debounce;

  void onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      controller.searchTowns(value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.h_55),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: Dimensions.h_35,
                    child: TextFormField(
                      onChanged: onSearchChanged,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: FontSize.sp_11,
                      ),
                      cursorColor: Colors.black87,
                      decoration: InputDecoration(
                        hintText: "Search by town ",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: Dimensions.h_2),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.w_10),
                GestureDetector(
                  onTap: ()=> Navigator.pop(context),
                  child: Container(
                    height: Dimensions.h_25,
                    width: Dimensions.h_25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey,width: 0.5)
                    ),
                    child: Icon(Icons.close,size: Dimensions.h_12,color: Colors.black87),
                  ),
                ),
              ],
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: ()=> Get.toNamed(AppRoutes.dashboard),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: Dimensions.h_6),
                margin: EdgeInsets.only(top: Dimensions.h_15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.h_6),
                color: Colors.grey.shade50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: Dimensions.w_10),
                    Icon(CupertinoIcons.location_circle_fill,color: Color(0xFF1D4ED8)),
                    SizedBox(width: Dimensions.w_10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Use Current Location',style: TextStyle(
                            color: Color(0xFF1D4ED8),
                            fontSize: FontSize.sp_10,
                            fontWeight: FontWeight.w800,
                          )),
                          Text('San Francisco ,USA',style: TextStyle(
                            color: Colors.black87,
                            fontSize: FontSize.sp_9_5,
                            fontWeight: FontWeight.w500,
                          )),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,color: Color(0xFF1D4ED8),size: Dimensions.h_10),
                    SizedBox(width: Dimensions.w_10),
                  ],
                ),
              ),
            ),
        Expanded(
          child: GetBuilder<DashboardController>(
            init: controller,
            id: ControllerBuilders.searchTownController,
            builder: (_) {
              if (controller.isLoading) {
                return Center(
                  child: CupertinoActivityIndicator(
                    color: Color(0xFF1D4ED8)),
                );
              }
              if ((controller.towns ?? []).isEmpty) {
                return  Center(
                  child: Text("",style: TextStyle(
                    color: Colors.black87,
                    fontSize: FontSize.sp_13,
                    fontWeight: FontWeight.w500,
                  )),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.h_15),
                  Text(
                    'TOWN RESULTS',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: FontSize.sp_12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: Dimensions.h_15),
                  Expanded(
                    child: ListView.separated(
                      itemCount: controller.towns?.length ?? 0,
                      separatorBuilder: (_, __) => Container(
                        margin: EdgeInsets.symmetric(vertical: Dimensions.h_10),
                        height: 0.3,
                        width: Get.width,
                        color: Colors.grey.shade500,
                      ),
                      itemBuilder: (_, i) {
                        final data = controller.towns?[i];

                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: (){
                            Get.toNamed(AppRoutes.dashboard);
                            controller.towns?.clear();
                            controller.update([ControllerBuilders.searchTownController]);
                            },
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.location_solid,
                                color: Colors.grey,
                                size: Dimensions.h_15,
                              ),
                              SizedBox(width: Dimensions.w_5),
                              Expanded(
                                child: Text(
                                  data?.areaName ?? '',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: FontSize.sp_12,
                                    fontWeight: FontWeight.w500,
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
              );
            },
          ),
        ),
          ],
        ),
      ),
    );
  }
}
