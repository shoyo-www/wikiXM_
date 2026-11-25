import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:wikixm/Presentation/widgets/photo_viewer.dart';
import 'package:wikixm/approutes.dart';
import 'package:wikixm/constants/constants.dart';
import 'package:wikixm/core/error/failures.dart';
import 'package:wikixm/data/datasource/Repository_impl/alerts_repository_impl.dart';
import '../../data/datasource/remote/models/response/alert_categories.dart' as cat;
import '../../data/datasource/remote/models/response/alerts_home.dart' as home;
import '../../data/datasource/remote/models/response/group_detail.dart' as model;
import '../../data/datasource/remote/models/response/incident_detail.dart' as detail;

class AlertsController extends GetxController {
  final AlertsRepositoryImpl _repo = AlertsRepositoryImpl();
  // shortcut: fixed town like the sports section, read the user's town once it is stored
  int cityId = 46820;
  bool isLoading = true;
  String? error;
  home.Sections? sections;
  String? townName;

  static const _defaultHeader = 'https://preetis-html.vercel.app/assets/images/alerts/alerts-home2/valley-town.jpg';
  String get headerImage => sections?.hero?.imageUrl ?? _defaultHeader;

  @override
  void onInit() {
    getAlertsHome();
    super.onInit();
  }

  Future<void> getAlertsHome() async {
    isLoading = true;
    error = null;
    update([ControllerBuilders.alertsHome]);
    final result = await _repo.alertsHome(cityId);
    result.fold((l) => error = _message(l), (r) {
      sections = r.data?.sections;
      townName = r.data?.town?.name;
      incidentTab = 0;
      journalTab = 0;
      activeMapFilters = {for (final l in sections?.impactMap?.layers ?? <home.Layer>[]) l.id ?? ''};
    });
    isLoading = false;
    update([ControllerBuilders.alertsHome]);
  }

  /// API icon names (bootstrap-style) to app icons.
  static const _minorWords = {'a', 'an', 'the', 'and', 'or', 'but', 'nor', 'of', 'in', 'on', 'at', 'to', 'for', 'by', 'with', 'as'};

  // heading title case: every word capitalised except minor words after the first
  static String titleCase(String text) {
    final words = text.split(' ');
    return [
      for (var i = 0; i < words.length; i++)
        if (words[i].isEmpty || (i > 0 && _minorWords.contains(words[i].toLowerCase()))) words[i].toLowerCase() else words[i][0].toUpperCase() + words[i].substring(1),
    ].join(' ');
  }

  static IconData icon(String? name) => switch (name) {
    'lightning' => CupertinoIcons.bolt_fill,
    'alert-earthquake' => Icons.monitor_heart_outlined,
    'vehicle-front' || 'road-barrier' => CupertinoIcons.car_detailed,
    'sun' => CupertinoIcons.sun_max,
    'mountain-peaks-fill' => Icons.landscape_outlined,
    'wifi' => CupertinoIcons.wifi,
    'alert-waves' => Icons.waves,
    'shield' => CupertinoIcons.shield,
    'alert' => CupertinoIcons.exclamationmark_triangle_fill,
    'clipboard' => CupertinoIcons.doc_text,
    'comments' => CupertinoIcons.chat_bubble_text,
    'lightbulb' => CupertinoIcons.lightbulb_fill,
    'map-locate' => CupertinoIcons.location,
    'calendar' => CupertinoIcons.calendar,
    'camera' => CupertinoIcons.camera,
    'question' => CupertinoIcons.question_circle,
    'pen' => CupertinoIcons.pencil,
    'bell' => CupertinoIcons.bell,
    'plus' => CupertinoIcons.add,
    _ => CupertinoIcons.info,
  };

  static String ago(DateTime? t) {
    if (t == null) return '';
    final d = DateTime.now().difference(t);
    if (d.inMinutes < 1) return 'Just now';
    if (d.inHours < 1) return '${d.inMinutes} min ago';
    if (d.inDays < 1) return '${d.inHours} hr ago';
    return d.inDays == 1 ? 'Yesterday' : '${d.inDays} days ago';
  }

  static String clock(DateTime? t) => t == null ? '' : DateFormat(DateFormats.hhmma).format(t.toLocal());

  /// Breaking items shaped for [AlertsUi.tickerStrip].
  List<Map<String, dynamic>> get breaking => [
    for (final b in sections?.breaking?.items ?? <home.BreakingItem>[]) {'icon': icon(b.icon), 'tone': b.tone, 'title': b.title ?? '', 'body': b.subtitle ?? '', 'time': ago(b.updatedAt)},
  ];

  @override
  void onClose() {
    reportText.dispose();
    reportFocus.dispose();
    issueText.dispose();
    reportPlace.dispose();
    incidentSearch.dispose();
    super.onClose();
  }

  int incidentTab = 0;
  static final _staticSolutions = [
    {'icon': CupertinoIcons.bolt_fill, 'tone': 'orange', 'title': 'Charging and warming spots', 'body': 'Fall City Library, 8 AM to 8 PM'},
    {'icon': CupertinoIcons.bus, 'tone': 'blue', 'title': 'Commute alternatives', 'body': 'Routes and timing around I-90'},
    {'icon': CupertinoIcons.wifi, 'tone': 'blue', 'title': 'Internet and cellular help', 'body': 'Provider updates and local workarounds'},
  ];

  // falls back to the static list when the API sends no solutions
  List<Map<String, dynamic>> get solutions {
    final items = sections?.communitySolutions?.items ?? <home.BreakingItem>[];
    if (items.isEmpty) return _staticSolutions;
    return [
      for (final i in items) {'icon': icon(i.icon), 'tone': i.tone, 'title': i.title ?? '', 'body': i.subtitle ?? ''},
    ];
  }

  static const _snapshotIds = ['active', 'tracked', 'solutions'];

  // the API sends more metrics than the snapshot card shows
  List<home.Metric> get snapshotMetrics => [for (final id in _snapshotIds) ...(sections?.snapshot?.metrics ?? <home.Metric>[]).where((m) => m.id == id).take(1)];

  List<String> get incidentTabs => [for (final t in sections?.featuredIncident?.tabs ?? <home.Tab>[]) t.action?.label ?? t.id ?? ''];
  bool following = false;

  // Report an issue page

  bool reportAlert() {
    if (Get.currentRoute == AppRoutes.reportIssue) return false;
    reportMode = 0;
    reportCategory = null;
    reportWhen = 0;
    updateIncident = null;
    updateStatus = null;
    updateWhen = 0;
    reportPhotos.clear();
    issueText.clear();
    reportPlace.clear();
    incidentSearch.clear();
    Get.until((r) => r.settings.name == AppRoutes.alerts || r.isFirst);
    Get.toNamed(AppRoutes.reportIssue);
    return true;
  }

  static const reportCategories = [
    (title: 'Power', icon: CupertinoIcons.bolt, tone: 'orange'),
    (title: 'Roads', icon: CupertinoIcons.car_detailed, tone: 'blue'),
    (title: 'Passes', icon: Icons.landscape_outlined, tone: 'green'),
    (title: 'Internet', icon: CupertinoIcons.wifi, tone: 'red'),
    (title: 'Weather', icon: CupertinoIcons.sun_max, tone: 'violet'),
    (title: 'Flooding', icon: Icons.waves, tone: 'blue'),
    (title: 'Earthquake', icon: Icons.monitor_heart_outlined, tone: 'red'),
    (title: 'Safety', icon: CupertinoIcons.shield, tone: 'blue'),
  ];
  static const reportSuggestions = ['Something blocking the road', 'Power is out', 'Smoke or fire nearby'];
  static const reportWhens = ['Just now', 'Earlier today', 'Yesterday'];
  static const updateStatuses = [(title: 'Still happening', icon: CupertinoIcons.exclamationmark_triangle), (title: 'Getting better', icon: CupertinoIcons.graph_square), (title: 'Fixed here', icon: CupertinoIcons.checkmark)];
  static const updateSuggestions = ['Crews on site', 'Power is back', 'No change yet'];
  static const updateWhens = ['Just now', 'Within the hour', 'Earlier today'];
  static const maxReportPhotos = 10;
  static const maxReportLength = 1000;

  // shortcut: static list like the community photos, load active incidents from the API once it has an endpoint
  static const activeIncidents = [
    (title: 'Windstorm power outage', status: 'Developing. Updated 18 min ago', icon: CupertinoIcons.bolt, tone: 'orange'),
    (title: 'Power outage near downtown Issaquah', status: 'Active. Updated 1 hr ago', icon: CupertinoIcons.bolt, tone: 'orange'),
    (title: 'Xfinity internet disruption', status: 'Investigating. Updated 18 min ago', icon: CupertinoIcons.wifi, tone: 'red'),
    (title: 'I-90 Snoqualmie Pass advisory', status: 'Chains required. Updated 18 min ago', icon: Icons.landscape_outlined, tone: 'green'),
    (title: 'Tree blocking SE 45th Street', status: 'Active. Updated 2 hr ago', icon: CupertinoIcons.car_detailed, tone: 'blue'),
  ];

  int reportMode = 0;
  int? reportCategory;
  int reportWhen = 0;
  int? updateIncident;
  int? updateStatus;
  int updateWhen = 0;
  final List<String> reportPhotos = [];
  final issueText = TextEditingController();
  final reportPlace = TextEditingController();
  final incidentSearch = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void _refreshReport() => update([ControllerBuilders.reportIssue]);

  List<int> get visibleIncidents {
    final q = incidentSearch.text.trim().toLowerCase();
    return [for (var i = 0; i < activeIncidents.length; i++) if (activeIncidents[i].title.toLowerCase().contains(q)) i];
  }

  // the bottom bar shows what is still missing, null once the form can be sent
  String? get reportHint {
    if (reportMode == 1) {
      if (updateIncident == null) return 'Pick the incident you’re updating';
      if (updateStatus == null) return 'Say how it is where you are';
    } else if (reportCategory == null) {
      return 'Pick what it’s about';
    }
    return issueText.text.trim().isEmpty ? 'Say what you saw' : null;
  }

  void setReportMode(int i) {
    reportMode = i;
    _refreshReport();
  }

  void selectReportCategory(int i) {
    reportCategory = i;
    _refreshReport();
  }

  void selectReportWhen(int i) {
    if (reportMode == 1) {
      updateWhen = i;
    } else {
      reportWhen = i;
    }
    _refreshReport();
  }

  void selectUpdateIncident(int i) {
    updateIncident = updateIncident == i ? null : i;
    _refreshReport();
  }

  void selectUpdateStatus(int i) {
    updateStatus = i;
    _refreshReport();
  }

  void addReportSuggestion(String text) {
    final current = issueText.text.trim();
    final next = current.isEmpty ? '$text.' : '$current $text.';
    if (next.length > maxReportLength) return;
    issueText.text = next;
    _refreshReport();
  }

  // shortcut: fills the town name, use GPS once a location package is added
  void useMyLocation() {
    reportPlace.text = townName ?? '';
    _refreshReport();
  }

  Future<void> pickReportPhotos() async {
    final left = maxReportPhotos - reportPhotos.length;
    if (left <= 0) return;
    final picked = await _picker.pickMultiImage(imageQuality: 85, maxWidth: 2000, maxHeight: 2000);
    reportPhotos.addAll(picked.take(left).map((x) => x.path));
    _refreshReport();
  }

  void removeReportPhoto(int i) {
    reportPhotos.removeAt(i);
    _refreshReport();
  }

  // shortcut: no submit endpoint yet, post the report to the API once it exists
  void sendIssue() {
    if (reportHint != null) return;
    Get.back();
    Fluttertoast.showToast(msg: reportMode == 1 ? 'Thanks, your update was sent' : 'Thanks, your report was sent', gravity: ToastGravity.BOTTOM);
  }

  static const drawerCategories = [
    ('All alerts', CupertinoIcons.square_list),
    ('Roads & traffic', CupertinoIcons.car_detailed),
    ('Mountain passes', Icons.landscape_outlined),
    ('Power outages', CupertinoIcons.bolt),
    ('Internet & cellular', CupertinoIcons.wifi),
    ('Weather & air', CupertinoIcons.sun_max),
    ('Flooding', Icons.water_outlined),
    ('Earthquakes', Icons.show_chart_rounded),
    ('Public safety', CupertinoIcons.shield),
  ];

  bool openAlertsHome({String? from}) {
    if (from == AppRoutes.alerts) return false;
    Get.until((r) => r.settings.name == AppRoutes.alerts || r.isFirst);
    return true;
  }

  // API category slugs to the drawer category names
  static const _categoryBySlug = {'highway': 'Roads & traffic', 'mountain-passes': 'Mountain passes', 'power-outages': 'Power outages', 'internet-cellular': 'Internet & cellular', 'weather': 'Weather & air', 'flooding': 'Flooding', 'earthquake': 'Earthquakes', 'public-safety': 'Public safety'};

  bool openAlertsCategory(String title) => openCategory(_categoryBySlug.entries.where((e) => e.value == title).firstOrNull?.key);

  bool openCategory(String? slug) {
    selectAlertsCategory(slug ?? 'all');
    if (alertCategories.isEmpty) getAlertCategories();
    if (Get.currentRoute == AppRoutes.allAlerts) return false;
    Get.until((r) => r.settings.name == AppRoutes.alerts || r.isFirst);
    Get.toNamed(AppRoutes.allAlerts);
    return true;
  }

  List<cat.AlertCategory> alertCategories = [];
  bool alertCategoriesLoading = false;
  String? alertsTownName;
  // category slug sent to the API, 'all' for every category
  String alertsCategory = 'all';
  static const alertStatuses = ['active', 'developing', 'resolved', 'all'];
  int alertsStatusTab = 0;
  List<cat.CategoryIncident> categoryAlerts = [];
  cat.PhaseCounts? alertCounts;
  int _alertsPage = 1;
  bool alertsHasMore = false;
  bool alertsLoading = false;
  bool alertsLoadingMore = false;
  String? alertsError;
  // bumped on every filter change so a slow older response can't overwrite a newer one
  int _alertsRequest = 0;

  /// Drawer name of the selected category, so the drawer can highlight it.
  String get alertsCategoryName => _categoryBySlug[alertsCategory] ?? 'All alerts';

  IconData categoryIcon(String? slug) {
    final name = slug == 'all' ? 'All alerts' : _categoryBySlug[slug];
    return drawerCategories.firstWhereOrNull((c) => c.$1 == name)?.$2 ?? CupertinoIcons.exclamationmark_triangle;
  }

  /// 'All alerts' chip first, then the API categories.
  List<({String slug, String title, int count})> get categoryChips => [(slug: 'all', title: 'All alerts', count: alertCategories.fold(0, (n, c) => n + (c.activeCount ?? 0))), for (final c in alertCategories) (slug: c.slug ?? '', title: c.title ?? '', count: c.activeCount ?? 0)];

  List<String> get alertStatusTabs => [for (final s in alertStatuses) '${titleCase(s)} (${alertCounts?.of(s) ?? 0})'];

  String get alertsStatusLabel {
    final status = alertStatuses[alertsStatusTab];
    final n = alertCounts?.of(status) ?? 0;
    return '$n ${status == 'all' ? '' : '$status '}alert${n == 1 ? '' : 's'}';
  }

  String alertTone(String? status) => switch (status) {
    'resolved' => 'green',
    'developing' => 'orange',
    _ => 'red',
  };

  Future<void> getAlertCategories() async {
    alertCategoriesLoading = true;
    update([ControllerBuilders.allAlerts]);
    final result = await _repo.alertCategories(cityId);
    alertCategoriesLoading = false;
    // the list has its own error state, the chips just stay empty
    result.fold((_) {}, (r) {
      alertCategories = r.data?.categories ?? [];
      alertsTownName = r.data?.town?.name;
    });
    update([ControllerBuilders.allAlerts]);
  }

  Future<void> getCategoryAlerts({bool more = false}) async {
    if (more && (alertsLoadingMore || alertsLoading || !alertsHasMore)) return;
    final request = more ? _alertsRequest : ++_alertsRequest;
    final page = more ? _alertsPage + 1 : 1;
    if (more) {
      alertsLoadingMore = true;
    } else {
      alertsLoading = true;
      alertsError = null;
      categoryAlerts = [];
    }
    update([ControllerBuilders.allAlertsList]);
    final result = await _repo.categoryIncidents(cityId, category: alertsCategory, phase: alertStatuses[alertsStatusTab], page: page);
    if (request != _alertsRequest) return;
    result.fold(
      (l) {
        if (more) {
          Fluttertoast.showToast(msg: _message(l), gravity: ToastGravity.BOTTOM);
        } else {
          alertsError = _message(l);
        }
      },
      (r) {
        final p = r.data?.pagination;
        categoryAlerts = [...categoryAlerts, ...?r.data?.items];
        alertCounts = r.data?.counts ?? alertCounts;
        _alertsPage = p?.currentPage ?? page;
        alertsHasMore = p?.currentPage != null && p?.lastPage != null && p!.currentPage! < p.lastPage!;
      },
    );
    alertsLoading = false;
    alertsLoadingMore = false;
    update([ControllerBuilders.allAlerts, ControllerBuilders.allAlertsList]);
  }

  /// Called as cards build; loads the next page when the last few come into view.
  void onAlertShown(int index) {
    if (index >= categoryAlerts.length - 3 && alertsHasMore && !alertsLoadingMore) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getCategoryAlerts(more: true));
    }
  }

  void selectAlertsCategory(String slug) {
    alertsCategory = slug;
    update([ControllerBuilders.allAlerts]);
    getCategoryAlerts();
  }

  bool get alertsFilteredByCategory => alertsCategory != 'all';

  String get emptyAlertsTitle {
    final status = alertStatuses[alertsStatusTab];
    return status == 'all' ? 'No alerts yet' : 'No $status alerts';
  }

  String get emptyAlertsMessage {
    final status = alertStatuses[alertsStatusTab];
    final where = alertsFilteredByCategory ? 'in ${categoryChips.where((t) => t.slug == alertsCategory).firstOrNull?.title ?? 'this category'}' : 'in ${alertsTownName ?? 'your town'}';
    final what = status == 'all' ? 'Nothing has been reported' : 'Nothing is $status';
    return '$what $where right now. Try another status or category, or check back later.';
  }

  void showAllCategories() => selectAlertsCategory('all');

  void selectAlertsStatus(int i) {
    alertsStatusTab = i;
    update([ControllerBuilders.allAlerts]);
    getCategoryAlerts();
  }

  static int _minutesAgo(String time) {
    if (time == 'Yesterday') return 1440;
    final n = int.tryParse(time.split(' ').first) ?? 0;
    return time.contains('min')
        ? n
        : time.contains('hr')
        ? n * 60
        : n * 1440;
  }

  void openMyAlerts() {}

  void openIncident(int? id) {
    if (id == null) return;
    photoIndex = 0;
    getIncident(id);
    Get.toNamed(AppRoutes.alertDetail);
  }

  bool openCommunityPhotos() {
    if (Get.currentRoute == AppRoutes.communityPhotos) return false;
    communityPhotoIndex = 0;
    Get.until((r) => r.settings.name == AppRoutes.alerts || r.isFirst);
    Get.toNamed(AppRoutes.communityPhotos);
    return true;
  }

  int journalTab = 0;
  List<String> get journalTabs => ['All', for (final f in sections?.journal?.filters ?? <home.Layer>[]) f.label ?? ''];

  List<home.Feature> get journal {
    final items = sections?.journal?.items ?? <home.Feature>[];
    if (journalTab == 0) return items;
    final slug = sections?.journal?.filters?[journalTab - 1].id;
    return items.where((j) => j.categorySlug == slug).toList();
  }

  int categoryCount(String? slug) => (sections?.journal?.items ?? <home.Feature>[]).where((j) => j.categorySlug == slug).length;

  LatLng? get mapCenter {
    final c = sections?.impactMap?.center;
    return c?.latitude == null || c?.longitude == null ? null : LatLng(c!.latitude!, c.longitude!);
  }

  // shortcut: pins are untyped in the API model, add a Pin class once the backend fixes the schema
  List<Map<String, dynamic>> get mapPins => [
    for (final p in sections?.impactMap?.pins ?? [])
      if (p is Map && p['latitude'] is num && p['longitude'] is num && (p['layer'] == null || activeMapFilters.contains(p['layer']))) {'point': LatLng((p['latitude'] as num).toDouble(), (p['longitude'] as num).toDouble()), 'tone': p['tone'], 'icon': icon(p['icon']), 'title': p['title']},
  ];

  Set<String> activeMapFilters = {};

  List<Map<String, dynamic>> exploreLinks = [
    {'icon': CupertinoIcons.chat_bubble, 'title': 'What are neighbors seeing?', 'body': 'Live observations, questions and local talk', 'link': 'Explore conversations'},
    {'icon': CupertinoIcons.bell, 'title': 'Stay informed your way', 'body': 'Follow your town, routes and topics', 'link': 'Customize my alerts'},
    {'icon': CupertinoIcons.wifi, 'title': 'Internet and cellular alerts', 'body': 'Following Xfinity and Starlink', 'link': 'Manage provider alerts'},
  ];

  List<Map<String, String>> businesses = [
    {'image': 'https://images.unsplash.com/photo-1514933651103-005eec06c04b?w=300', 'title': 'The River Rock Grill', 'body': 'Local food and drinks', 'link': 'View menu'},
    {'image': 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=300', 'title': 'Fall City Outfitters', 'body': 'Gear and essentials', 'link': 'Shop local'},
  ];

  void selectIncidentTab(int i) {
    incidentTab = i;
    update([ControllerBuilders.alertsHome]);
  }

  void selectJournalTab(int i) {
    journalTab = i;
    update([ControllerBuilders.alertsHome]);
  }

  void toggleFollow() {
    following = !following;
    update([ControllerBuilders.alertsHome, ControllerBuilders.alertDetailFollow]);
  }

  void toggleMapFilter(String f) {
    activeMapFilters.contains(f) ? activeMapFilters.remove(f) : activeMapFilters.add(f);
    update([ControllerBuilders.alertsHome]);
  }

  // Alert detail page

  List<Map<String, String>> photos = [
    {'image': 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=900', 'caption': 'Crews assess a fallen tree on a forest road. Photo by a valley resident.'},
    {'image': 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=900', 'caption': 'PSE crews working on lines near SE 45th Street.'},
    {'image': 'https://images.unsplash.com/photo-1511497584788-876760111969?w=900', 'caption': 'Downed branches along the valley road.'},
  ];
  int photoIndex = 0;
  final photoCarousel = CarouselSliderController();

  int communityPhotoIndex = 0;
  final communityCarousel = CarouselSliderController();

  void onCommunityPhotoChanged(int i) {
    communityPhotoIndex = i;
    update([ControllerBuilders.communityPhotos]);
  }

  static const photoTabs = [(title: 'All photos', icon: CupertinoIcons.photo_on_rectangle), (title: 'Power', icon: CupertinoIcons.bolt), (title: 'Roads', icon: CupertinoIcons.car_detailed), (title: 'Weather', icon: CupertinoIcons.cloud), (title: 'Damage', icon: CupertinoIcons.drop), (title: 'Other', icon: CupertinoIcons.square_grid_2x2)];
  int photoTab = 0;

  List<Map<String, dynamic>> communityPhotoList = [
    {'image': 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=600', 'category': 'Damage', 'badge': 'Community', 'badgeTone': 'violet', 'title': 'Storm debris on a valley lane', 'body': 'Maple branches and storm debris cover a wooded valley lane.', 'author': 'Valley resident', 'time': '2 hrs ago', 'comments': 19, 'likes': 41},
    {'image': 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=600', 'category': 'Power', 'badge': 'Verified', 'badgeTone': 'green', 'title': 'PSE crews on SE 45th St', 'body': 'Line crews replacing a snapped pole near Riverbend.', 'author': 'PSE', 'time': '40 min ago', 'comments': 12, 'likes': 58},
    {'image': 'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?w=600', 'category': 'Power', 'badge': 'Community', 'badgeTone': 'violet', 'title': 'Bucket truck at Fall City Park', 'body': 'Crews working on the lines that feed the park and school.', 'author': 'Neighbor', 'time': '1 hr ago', 'comments': 7, 'likes': 23},
    {'image': 'https://images.unsplash.com/photo-1513828583688-c52646db42da?w=600', 'category': 'Power', 'badge': 'Editorial', 'badgeTone': 'blue', 'title': 'Dark streets after the storm', 'body': 'Most of Main St lost power just after midnight.', 'author': 'Fall City editor', 'time': '3 hrs ago', 'comments': 24, 'likes': 66},
    {'image': 'https://images.unsplash.com/photo-1587293852726-70cdb56c2866?w=600', 'category': 'Power', 'badge': 'Community', 'badgeTone': 'violet', 'title': 'Downed line on a driveway', 'body': 'A line came down across a driveway on SE 45th. Stay 30 ft away.', 'author': 'Valley resident', 'time': '5 hrs ago', 'comments': 31, 'likes': 74},
    {'image': 'https://images.unsplash.com/photo-1545158535-c3f7168c28b6?w=600', 'category': 'Roads', 'badge': 'Verified', 'badgeTone': 'green', 'title': 'Backup on I-90 westbound', 'body': 'Traffic slowed to a crawl near the I-405 interchange.', 'author': 'WSDOT', 'time': '25 min ago', 'comments': 5, 'likes': 18},
    {'image': 'https://images.unsplash.com/photo-1476231682828-37e571bc172f?w=600', 'category': 'Roads', 'badge': 'Community', 'badgeTone': 'violet', 'title': 'Tree across Neal Rd', 'body': 'Crews cleared one lane by mid-morning.', 'author': 'Neighbor', 'time': '2 hrs ago', 'comments': 9, 'likes': 27},
    {'image': 'https://images.unsplash.com/photo-1527482797697-8795b05a13fe?w=600', 'category': 'Weather', 'badge': 'Editorial', 'badgeTone': 'blue', 'title': 'Clouds rolling over the valley', 'body': 'Heavy rain bands moving in from the west this afternoon.', 'author': 'Fall City editor', 'time': '1 hr ago', 'comments': 3, 'likes': 35},
    {'image': 'https://images.unsplash.com/photo-1418985991508-e47386d96a71?w=600', 'category': 'Weather', 'badge': 'Community', 'badgeTone': 'violet', 'title': 'First snow on the ridge', 'body': 'Snow line dropped to about 1,500 ft overnight.', 'author': 'Valley resident', 'time': '4 hrs ago', 'comments': 6, 'likes': 52},
    {'image': 'https://images.unsplash.com/photo-1547683905-f686c993aae5?w=600', 'category': 'Damage', 'badge': 'Community', 'badgeTone': 'violet', 'title': 'River over the trail', 'body': 'Snoqualmie River spilling onto the lower trail near the bridge.', 'author': 'Neighbor', 'time': '3 hrs ago', 'comments': 14, 'likes': 39},
    {'image': 'https://images.unsplash.com/photo-1511497584788-876760111969?w=600', 'category': 'Other', 'badge': 'Editorial', 'badgeTone': 'blue', 'title': 'Quiet morning on the river road', 'body': 'Crews and neighbors out clearing branches at first light.', 'author': 'Fall City editor', 'time': '6 hrs ago', 'comments': 2, 'likes': 21},
    {'image': 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=600', 'category': 'Other', 'badge': 'Community', 'badgeTone': 'violet', 'title': 'Hardware store open late', 'body': 'Generators, batteries and tarps in stock until 9 PM.', 'author': 'Neighbor', 'time': '1 hr ago', 'comments': 8, 'likes': 30},
  ];

  int photoCount(String tab) => tab == 'All photos' ? communityPhotoList.length : communityPhotoList.where((p) => p['category'] == tab).length;

  static const photoSorts = ['Newest first', 'Most liked', 'Most discussed'];
  String photoSort = photoSorts.first;

  List<Map<String, dynamic>> get visiblePhotos {
    final list = photoTab == 0 ? [...communityPhotoList] : communityPhotoList.where((p) => p['category'] == photoTabs[photoTab].title).toList();
    return switch (photoSort) {
      'Most liked' => list..sort((a, b) => (b['likes'] as int).compareTo(a['likes'])),
      'Most discussed' => list..sort((a, b) => (b['comments'] as int).compareTo(a['comments'])),
      _ => list..sort((a, b) => _minutesAgo(a['time']).compareTo(_minutesAgo(b['time']))),
    };
  }

  String get galleryPhotosLabel {
    final n = visiblePhotos.length;
    return '$n gallery photo${n == 1 ? '' : 's'}';
  }

  void selectPhotoSort(String sort) {
    photoSort = sort;
    update([ControllerBuilders.communityPhotos]);
  }

  void openCommunityPhoto(int i) => PhotoViewer.open([for (final p in visiblePhotos) p['image'] as String], index: i);

  void selectPhotoTab(int i) {
    photoTab = i;
    update([ControllerBuilders.communityPhotos]);
  }

  bool communityBookmarked = false;
  bool communityFollowing = false;

  void toggleCommunityFollow() {
    communityFollowing = !communityFollowing;
    update([ControllerBuilders.communityPhotos]);
  }

  void toggleCommunityBookmark() {
    communityBookmarked = !communityBookmarked;
    update([ControllerBuilders.communityPhotos]);
  }

  String editorImage = 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200';
  String editorName = 'Fall City community editor';
  String editorUpdated = 'Updated 18 min ago';
  bool bookmarked = false;

  String glanceSource = 'Source: PSE';
  List<Map<String, dynamic>> glance = [
    {'icon': CupertinoIcons.bolt_fill, 'tone': 'orange', 'value': '~4,200', 'label': 'Customers without power'},
    {'icon': CupertinoIcons.car_detailed, 'tone': 'blue', 'value': 'Several areas', 'label': 'Road impacts'},
    {'icon': CupertinoIcons.wifi, 'tone': 'red', 'value': 'Patchy', 'label': 'Internet and cell'},
    {'icon': CupertinoIcons.clock, 'tone': 'orange', 'value': 'By 6 PM', 'label': 'Power back (estimate)'},
  ];
  double restoration = 0.35;
  String restorationEta = 'Est. by 6 PM';
  String restorationNote = 'Crews dispatched 5:58 AM. Estimate from PSE, may change.';

  List<Map<String, dynamic>> verifiedUpdates = [
    {'icon': CupertinoIcons.bolt_fill, 'tone': 'orange', 'title': 'PSE', 'body': 'About 4,200 customers affected, service back by 6 PM', 'time': '7:04 AM'},
    {'icon': CupertinoIcons.checkmark_seal_fill, 'tone': 'green', 'title': 'PSE', 'body': 'Crews dispatched and restoring power across the valley', 'time': '5:58 AM'},
  ];

  int detailTab = 0;
  List<Map<String, dynamic>> impacts = [
    {'icon': CupertinoIcons.bolt_fill, 'tone': 'orange', 'title': 'Power outage', 'body': '~4,200 customers'},
    {'icon': CupertinoIcons.car_detailed, 'tone': 'blue', 'title': 'Road impacts', 'body': 'Several areas'},
    {'icon': CupertinoIcons.wifi, 'tone': 'red', 'title': 'Internet and cell', 'body': 'On and off'},
    {'icon': Icons.park_outlined, 'tone': 'green', 'title': 'Tree damage', 'body': 'Neighbor reports'},
  ];

  List<String> actions = ['Check PSE\'s outage page for restoration estimates.', 'Report downed trees and road hazards to King County roads.', 'Check travel updates before driving through the valley.', 'Share reliable resources and what you see nearby.'];

  List<Map<String, dynamic>> sources = [
    {'icon': CupertinoIcons.bolt, 'title': 'PSE outage information'},
    {'icon': CupertinoIcons.triangle, 'title': 'WSDOT travel information'},
    {'icon': CupertinoIcons.wifi, 'title': 'Xfinity service status'},
    {'icon': CupertinoIcons.shield, 'title': 'King County emergency information'},
  ];

  List<Map<String, String>> articles = [
    {'image': 'https://images.unsplash.com/photo-1527482797697-8795b05a13fe?w=600', 'title': 'Windstorm brings outages to Fall City', 'meta': '32 min ago'},
    {'image': 'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?w=600', 'title': 'Restoration update for the valley', 'meta': '1 hr ago'},
    {'image': 'https://images.unsplash.com/photo-1476231682828-37e571bc172f?w=600', 'title': 'How to report downed trees', 'meta': '2 hr ago'},
  ];

  Map<String, String> sponsor = {'title': 'Cedar River Insurance', 'body': 'Home, auto, business and life cover', 'link': 'Get a quote'};

  final reportText = TextEditingController();
  final reportFocus = FocusNode();

  /// Whole page: loading state, incident data and tab switches.
  void refreshDetail() => update([ControllerBuilders.alertDetail]);

  /// Tab lists, the discussion preview and reply threads only, so async loads don't rebuild the hero.
  void refreshDetailContent() => update([ControllerBuilders.alertDetailContent]);

  void onPhotoChanged(int i) {
    photoIndex = i;
    // the carousel slides every few seconds, only the dots depend on it
    update([ControllerBuilders.alertDetailPhotos]);
  }

  int? incidentId;
  detail.Incident? incident;
  bool incidentLoading = false;
  String? incidentError;
  // tab lists keyed by the tab's content type, loaded the first time the tab opens
  Map<String, List<detail.IncidentEntry>> tabItems = {};
  Set<String> tabLoading = {};
  Map<String, String> tabErrors = {};
  // replies of a comment or answers of a question, keyed by its id
  Map<int, List<detail.IncidentEntry>> threads = {};
  Set<int> openThreads = {};
  Set<int> threadLoading = {};
  int discussionPreviewCount = 2;

  static String _message(Failure l) => (l is ServerFailure ? l.message : null) ?? Constants.someThingWentWrong;

  Future<void> getIncident(int id) async {
    incidentId = id;
    incident = null;
    incidentError = null;
    incidentLoading = true;
    detailTab = 0;
    tabItems = {};
    tabLoading = {};
    tabErrors = {};
    threads = {};
    openThreads = {};
    threadLoading = {};
    refreshDetail();
    final result = await _repo.incidentDetail(id);
    // another incident was opened while this one loaded
    if (id != incidentId) return;
    result.fold((l) => incidentError = _message(l), (r) => incident = r.data);
    incidentLoading = false;
    if (incident == null) return refreshDetail();
    final first = detailTabList.indexWhere((t) => t.id == incident?.defaultTab);
    selectDetailTab(first < 0 ? 0 : first);
    // the overview previews the discussion, which the detail response leaves empty
    if (!tabItems.containsKey('discussion')) loadTab('discussion');
  }

  void retryIncident() {
    if (incidentId != null) getIncident(incidentId!);
  }

  Future<void> loadTab(String type) async {
    final id = incidentId;
    if (id == null || tabLoading.contains(type)) return;
    tabLoading.add(type);
    tabErrors.remove(type);
    refreshDetailContent();
    // shortcut: first page only, add load-more once an incident has more than one page of items
    final result = await _repo.incidentContent(id, type);
    if (id != incidentId) return;
    result.fold((l) => tabErrors[type] = _message(l), (r) => tabItems[type] = r.data?.items ?? []);
    tabLoading.remove(type);
    refreshDetailContent();
  }

  List<detail.IncidentTab> get detailTabList => incident?.tabs ?? [];
  List<String> get detailTabs => [for (final t in detailTabList) t.label ?? ''];
  String? get detailContentType => detailTab < detailTabList.length ? detailTabList[detailTab].contentType : null;

  List<String> get heroPhotos {
    final media = [for (final m in incident?.media ?? <detail.IncidentMedia>[]) ?m.url];
    return media.isNotEmpty ? media : [?incident?.imageUrl];
  }

  String get incidentStatus => titleCase(incident?.incidentStatus ?? '');
  String get incidentUpdated => incident?.updatedAtLabel == null ? '' : 'Updated ${incident!.updatedAtLabel}';

  void selectDetailTab(int i) {
    detailTab = i;
    refreshDetail();
    final type = detailContentType;
    if (type != null && !tabItems.containsKey(type)) loadTab(type);
  }

  void openDetailTab(String type) {
    final i = detailTabList.indexWhere((t) => t.contentType == type);
    if (i >= 0 && i != detailTab) selectDetailTab(i);
  }

  /// Comments, questions and solutions shaped for [PostCard].
  model.Post toPost(detail.IncidentEntry e) => model.Post(id: e.id, firstName: e.author?.name ?? e.authorName, avatar: e.author?.profileImage, createdAtLabel: e.displayTimestamp?.label ?? e.createdAtLabel, body: e.body ?? e.description, likesCount: e.likesCount, isLiked: e.isLiked == true ? 1 : 0, commentsCount: threadCount(e));

  int threadCount(detail.IncidentEntry e) => e.answersCount ?? e.repliesCount ?? 0;

  Future<void> toggleThread(detail.IncidentEntry e) async {
    final id = e.id, incidentId = this.incidentId;
    if (id == null || incidentId == null || threadCount(e) == 0) return;
    if (!openThreads.remove(id)) openThreads.add(id);
    refreshDetailContent();
    if (threads.containsKey(id) || threadLoading.contains(id)) return;
    threadLoading.add(id);
    final question = e.type == 'question';
    // replies and answers both come from the discussion feed
    final result = await _repo.incidentContent(incidentId, 'discussion', parentId: question ? null : id, questionId: question ? id : null);
    if (incidentId != this.incidentId) return;
    threadLoading.remove(id);
    result.fold((l) {
      openThreads.remove(id);
      Fluttertoast.showToast(msg: _message(l), gravity: ToastGravity.BOTTOM);
    }, (r) => threads[id] = r.data?.items ?? []);
    refreshDetailContent();
  }

  void toggleBookmark() {
    bookmarked = !bookmarked;
    refreshDetail();
  }

  void share() {}
  void openSource(Map<String, dynamic> s) {}
  void openArticle(Map<String, String> a) {}
  void addPhoto() {}
  void newPost() => reportFocus.requestFocus();

  void sendReport() {
    if (reportText.text.trim().isEmpty) return;
    // shortcut: shown locally only, post it once the add-comment API exists
    (tabItems['discussion'] ??= []).insert(0, detail.IncidentEntry(type: 'comment', authorName: 'You', body: reportText.text.trim(), createdAtLabel: 'Just now'));
    reportText.clear();
    Get.focusScope?.unfocus();
    refreshDetailContent();
    openDetailTab('discussion');
  }
}
