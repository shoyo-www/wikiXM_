import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/notifications/controller.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/constants/fontsize.dart';
import 'package:wikixm/data/datasource/remote/models/response/notification_response.dart' as model;

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
      builder: (controller) {
        return AppScaffold(
          top: false,
          bottom: false,
          body: Column(
            children: [
              SizedBox(height: Dimensions.h_12),
              _NotificationTabs(controller: controller),
              Expanded(child: _NotificationBody(controller: controller)),
            ],
          ),
        );
      },
    );
  }
}

class _NotificationTabs extends StatelessWidget {
  const _NotificationTabs({required this.controller});

  final NotificationController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade500, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: Dimensions.w_10),
              _TabButton(
                title: 'All',
                selected: controller.selectedIndex == 0,
                onTap: () => controller.getNotification('all'),
              ),
              SizedBox(width: Dimensions.w_15),
              _TabButton(
                title: 'Unread',
                selected: controller.selectedIndex == 1,
                onTap: () => controller.getNotification('unread'),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: controller.markAll,
                child: Text(
                  'Read All',
                  style: TextStyle(
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                height: Dimensions.h_16,
                width: Dimensions.w_1,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: controller.clearAll,
                child: Text(
                  'Clear All',
                  style: TextStyle(
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_2),
        decoration: BoxDecoration(
          border: selected
              ? const Border(bottom: BorderSide(color: Colors.blue, width: 3))
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: FontSize.sp_16,
            fontWeight: FontWeight.w700,
            color: selected ? const Color(0xff144E82) : Colors.black87,
          ),
        ),
      ),
    );
  }
}

class _NotificationBody extends StatelessWidget {
  const _NotificationBody({required this.controller});

  final NotificationController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return Center(
        child: Text(
          'Loading.....',
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: FontSize.sp_15,
          ),
        ),
      );
    }

    final items = controller.items;
    if (items.isEmpty) {
      return Center(
        child: Text(
          'No Notifications Found',
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: FontSize.sp_15,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(top: Dimensions.h_12),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _NotificationTile(
          item: item,
          isRead: controller.isRead(item),
          timeLabel: controller.timeLabel(item),
          onTap: () {
            final id = item.id;
            if (id != null) controller.markSingle(id);
          },
        );
      },
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.item,
    required this.isRead,
    required this.timeLabel,
    required this.onTap,
  });

  final model.NotificationList item;
  final bool isRead;
  final String timeLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isRead ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isRead ? Colors.white : const Color(0xffeaf3ff),
        ),
        margin: EdgeInsets.symmetric(vertical: Dimensions.h_2),
        padding: EdgeInsets.only(
          top: Dimensions.h_12,
          bottom: Dimensions.h_10,
          left: Dimensions.w_8,
          right: Dimensions.w_8,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Dimensions.h_45,
              width: Dimensions.h_45,
              decoration: BoxDecoration(
                color: const Color(0xff1877f2),
                borderRadius: BorderRadius.circular(Dimensions.h_6),
              ),
              child: Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: Dimensions.h_22,
              ),
            ),
            SizedBox(width: Dimensions.w_10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.content ?? '',
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.sp_12,
                          ),
                        ),
                      ),
                      if (!isRead)
                        Container(
                          margin: EdgeInsets.only(top: Dimensions.h_6),
                          height: Dimensions.h_8,
                          width: Dimensions.h_8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_4),
                  Row(
                    children: [
                      Text(
                        timeLabel,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade700,
                          fontSize: FontSize.sp_10,
                        ),
                      ),
                      if ((item.type ?? '').isNotEmpty) ...[
                        SizedBox(width: Dimensions.w_8),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w_5,
                            vertical: Dimensions.h_2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xff144E82),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            item.type ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: FontSize.sp_9_5,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
