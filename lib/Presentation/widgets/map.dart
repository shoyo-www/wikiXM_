import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../constants/fontsize.dart';
import '../../data/datasource/remote/models/response/group_sections.dart';
import 'cache_image.dart';
import 'common_card.dart';
import 'package:wikixm/constants/appcolor.dart';

class NearbyMap extends StatefulWidget {
  final Nearby? nearby;
  final bool isFullScreen;

  const NearbyMap({super.key, required this.nearby, this.isFullScreen = false});

  @override
  State<NearbyMap> createState() => _NearbyMapState();
}

class _NearbyMapState extends State<NearbyMap> {
  final mapController = MapController();
  String? selectedId;

  @override
  void initState() {
    super.initState();
    selectedId = widget.nearby?.map?.initialPreview?.id;
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  Color markerColor(String? name, bool isLight) {
    switch (name) {
      case 'green':
        return  const Color(0xFF087C4B);
      case 'orange':
        return AppColor.orange(context);
      case 'violet':
        return AppColor.violet(context);
      default:
        return AppColor.blue(context);
    }
  }

  IconData markerIcon(String? icon, String? interestId) {
    final key = '$icon $interestId';
    if (key.contains('hiking')) return Icons.hiking;
    if (key.contains('bike') || key.contains('biking')) return Icons.directions_bike;
    if (key.contains('golf')) return Icons.golf_course;
    if (key.contains('pickleball')) return CupertinoIcons.sportscourt;
    if (key.contains('ski')) return Icons.downhill_skiing;
    if (key.contains('run')) return Icons.directions_run;
    return CupertinoIcons.location_solid;
  }

  List<LatLng> markerPoints(List<InitialPreview> markers) {
    final counts = <String, int>{};
    final seen = <String, int>{};
    for (final m in markers) {
      final key = '${m.latitude},${m.longitude}';
      counts[key] = (counts[key] ?? 0) + 1;
    }
    return markers.map((m) {
      final lat = m.latitude ?? 0;
      final lng = m.longitude ?? 0;
      final key = '$lat,$lng';
      if (counts[key] == 1) return LatLng(lat, lng);
      final index = seen[key] ?? 0;
      seen[key] = index + 1;
      final angle = 2 * math.pi * index / counts[key]!;
      return LatLng(lat + 0.008 * math.sin(angle), lng + 0.008 * math.cos(angle) / math.cos(lat * math.pi / 180));
    }).toList();
  }

  void zoomBy(double delta) {
    final zoom = widget.nearby?.map?.zoom;
    final camera = mapController.camera;
    final next = (camera.zoom + delta).clamp((zoom?.min ?? 2).toDouble(), (zoom?.max ?? 19).toDouble());
    mapController.move(camera.center, next.toDouble());
  }

  void openFullScreen() {
    Get.to(
      () => SizedBox(
        height: Get.height,
        width: Get.width,
        child: NearbyMap(nearby: widget.nearby, isFullScreen: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final map = widget.nearby?.map;
    final markers = map?.markers ?? [];
    final points = markerPoints(markers);
    final zoomStep = (map?.zoom?.step ?? 1).toDouble();
    final selected = markers.where((m) => m.id == selectedId).firstOrNull ?? map?.initialPreview;

    final mapStack = Stack(
      children: [
        Positioned.fill(
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: LatLng(map?.center?.latitude ?? 0, map?.center?.longitude ?? 0),
              initialZoom: (map?.zoom?.initial ?? 12).toDouble(),
              minZoom: (map?.zoom?.min ?? 2).toDouble(),
              maxZoom: (map?.zoom?.max ?? 19).toDouble(),
              backgroundColor: AppColor.mapBlueSoft(context),
              interactionOptions: InteractionOptions(flags: widget.isFullScreen ? InteractiveFlag.all & ~InteractiveFlag.rotate : InteractiveFlag.pinchZoom | InteractiveFlag.pinchMove | InteractiveFlag.doubleTapZoom),
            ),
            children: [
              TileLayer( urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.wikixm.app',
                maxNativeZoom: 19),
              MarkerLayer(
                markers: List.generate(markers.length, (i) {
                  final m = markers[i];
                  final color = markerColor(m.color, isLight);
                  final isSelected = m.id == selected?.id;
                  final size = isSelected ? Dimensions.h_40 : Dimensions.h_32;
                  return Marker(
                    point: points[i],
                    width: Dimensions.h_40,
                    height: Dimensions.h_40,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedId = m.id);
                        mapController.move(points[i], mapController.camera.zoom);
                      },
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: size,
                          width: size,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: isSelected ? 3 : 2),
                            boxShadow: [BoxShadow(color: color.withValues(alpha: isSelected ? 0.55 : 0.35), blurRadius: 8, spreadRadius: 2)],
                          ),
                          child: Icon(markerIcon(m.icon, m.interestId), size: isSelected ? Dimensions.h_20 : Dimensions.h_16, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        if ((map?.label ?? '').isNotEmpty)
          Positioned(
            top: widget.isFullScreen ? Dimensions.h_50: Dimensions.h_12,
            left: Dimensions.w_12,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_5),
              decoration: BoxDecoration(
                color: AppColor.mapWhiteTranslucent(context),
                borderRadius: BorderRadius.circular(99),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.10), blurRadius: 8)],
              ),
              child: Text(
                map!.label!,
                style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
              ),
            ),
          ),
        Positioned(
          top: widget.isFullScreen ? Dimensions.h_50 : Dimensions.h_12,
          right: Dimensions.w_12,
          child: Column(
            children: [
              mapControl(context, CupertinoIcons.plus, () => zoomBy(zoomStep)),
              SizedBox(height: Dimensions.h_4),
              mapControl(context, CupertinoIcons.minus, () => zoomBy(-zoomStep)),
              SizedBox(height: Dimensions.h_4),
              widget.isFullScreen ? mapControl(context, CupertinoIcons.fullscreen_exit, () => Get.back()) : mapControl(context, CupertinoIcons.fullscreen, openFullScreen),
            ],
          ),
        ),
        if (selected != null)
          Positioned(
            left: Dimensions.w_12,
            right: Dimensions.w_12,
            bottom: widget.isFullScreen ? Dimensions.h_30 : Dimensions.h_15,
            child: CommonCard(
              padding: EdgeInsets.all(Dimensions.h_4),
              child: Row(
                children: [
                  AppCacheImage(imageUrl: selected.image?.url ?? '', size: Dimensions.h_50, widthSize: Dimensions.h_50, fit: BoxFit.cover, radius: Dimensions.h_8, isShadow: false),
                  SizedBox(width: Dimensions.w_8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selected.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                        ),
                        SizedBox(height: Dimensions.h_5),
                        Row(
                          children: [
                            Icon(CupertinoIcons.clock, size: Dimensions.h_10, color: Theme.of(context).highlightColor),
                            SizedBox(width: Dimensions.w_4),
                            Expanded(
                              child: Text(
                                selected.date ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: FontSize.sp_9, color: Theme.of(context).highlightColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.h_3),
                        Row(
                          children: [
                            Icon(CupertinoIcons.location_solid, size: Dimensions.h_11, color: Theme.of(context).highlightColor),
                            SizedBox(width: Dimensions.w_4),
                            Expanded(
                              child: Text(
                                selected.place ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: FontSize.sp_9, color: Theme.of(context).highlightColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        Positioned(
          bottom: widget.isFullScreen ? Dimensions.h_10 : Dimensions.h_2,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              map?.caption ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: FontSize.sp_9, color: Colors.black87, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );

    if (widget.isFullScreen) return mapStack;

    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.nearby?.title ?? 'Explore Near You',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800),
            ),
            const Spacer(),
            GestureDetector(
              onTap: openFullScreen,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'View Map',
                    style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
                  ),
                  Icon(CupertinoIcons.arrow_right, color: Theme.of(context).primaryColorDark, size: Dimensions.h_12),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        Container(
          width: Get.width,
          height: Dimensions.h_230,
          decoration: BoxDecoration(
            color: AppColor.mapGreySoft(context),
            borderRadius: BorderRadius.circular(Dimensions.h_16),
            border: Border.all(color: AppColor.border(context), width: 0.4),
          ),
          child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.h_16), child: mapStack),
        ),
      ],
    );
  }

  Widget mapControl(BuildContext context, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Dimensions.h_28,
        width: Dimensions.h_28,
        decoration: BoxDecoration(
          color: AppColor.activityDetailWhiteTranslucent(context),
          borderRadius: BorderRadius.circular(Dimensions.h_6),
          border: Border.all(color: AppColor.activityDetailBlueSoft(context)),
        ),
        child: Icon(icon, size: Dimensions.h_13, color: Theme.of(context).highlightColor),
      ),
    );
  }
}
