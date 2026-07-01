import 'package:get/get.dart';
import 'package:wikixm/data/datasource/remote/models/response/notification_response.dart'
    as model;
import 'package:wikixm/data/datasource/remote/services/apis.dart';
import 'package:wikixm/data/datasource/remote/services/dio/rest_client.dart';

class NotificationController extends GetxController {
  final RestClient _restClient = Get.find<RestClient>();

  final List<model.NotificationList> _items = [];
  final Set<int> _localReadIds = {};
  int selectedIndex = 0;
  bool isLoading = false;

  List<model.NotificationList> get items {
    if (selectedIndex == 1) {
      return _items.where((item) => !isRead(item)).toList();
    }
    return _items;
  }

  @override
  void onInit() {
    super.onInit();
    getNotification('all');
  }

  Future<void> getNotification(String type) async {
    selectedIndex = type == 'unread' ? 1 : 0;
    isLoading = true;
    update();

    try {
      final response = await _restClient.get(url: '${Apis.notification}1');
      final parsed = response is Map<String, dynamic>
          ? model.NotificationResponse.fromJson(response)
          : model.notificationResponseFromJson(response.toString());
      _items
        ..clear()
        ..addAll(parsed.data?.notifications?.data ?? []);
    } catch (_) {
      _items.clear();
    } finally {
      isLoading = false;
      update();
    }
  }

  void markAll() {
    _localReadIds.addAll(_items.map((item) => item.id).whereType<int>());
    update();
  }

  void clearAll() {
    _items.clear();
    update();
  }

  void markSingle(int id) {
    _localReadIds.add(id);
    update();
  }

  bool isRead(model.NotificationList item) {
    final status = item.readStatus?.toLowerCase();
    return status == 'read' || status == '1' || _localReadIds.contains(item.id);
  }

  String timeLabel(model.NotificationList item) {
    final createdAt = item.createdAt;
    if (createdAt == null) return '';

    final diff = DateTime.now().difference(createdAt);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }
}
