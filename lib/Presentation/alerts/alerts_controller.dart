import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/widgets/photo_viewer.dart';
import 'package:wikixm/approutes.dart';
import 'package:wikixm/constants/constants.dart';
import '../../data/datasource/remote/models/response/group_detail.dart' as model;

class AlertsController extends GetxController {
  String headerImage = 'https://preetis-html.vercel.app/assets/images/alerts/alerts-home2/valley-town.jpg';
  String location = 'Fall City, WA';
  String updated = 'Thursday, Nov 12. Updated 7:04 AM';
  String greeting = 'Good morning,\nFall City!';
  String intro = 'Important alerts, travel updates and neighbors\' reports in one place. ';
  String introSource = 'From your WikiXM community editor';

  List<Map<String, dynamic>> affecting = [
    {'icon': CupertinoIcons.bolt_fill, 'tone': 'red', 'title': 'Power out', 'tag': 'High', 'body': '~4,200 homes. Back by 6 PM (estimate)'},
    {'icon': CupertinoIcons.car_detailed, 'tone': 'orange', 'title': 'I-90 pass', 'tag': 'Advisory', 'body': 'Chains required at Snoqualmie Pass'},
    {'icon': CupertinoIcons.wifi, 'tone': 'blue', 'title': 'Internet', 'tag': 'Patchy', 'body': 'Xfinity service on and off in parts of town'},
  ];

  List<Map<String, dynamic>> breaking = [
    {'icon': CupertinoIcons.bolt_fill, 'tone': 'red', 'level': 'High impact', 'title': 'Valley power outages', 'body': '~4,200 customers without power', 'time': '26 min ago'},
    {'icon': CupertinoIcons.wifi, 'tone': 'red', 'level': 'Disruption', 'title': 'Xfinity internet', 'body': 'Internet outage in parts of town', 'time': '18 min ago'},
  ];

  @override
  void onClose() {
    reportText.dispose();
    reportFocus.dispose();
    super.onClose();
  }

  String snapshotTime = 'As of 7:04 AM';
  List<Map<String, dynamic>> snapshot = [
    {'value': '6', 'label': 'Active alerts', 'icon': CupertinoIcons.bell_fill, 'tone': 'green'},
    {'value': '4', 'label': 'High impact', 'icon': CupertinoIcons.exclamationmark_triangle_fill, 'tone': 'orange'},
    {'value': '30', 'label': 'Community solutions', 'icon': CupertinoIcons.lightbulb_fill, 'tone': 'orange'},
  ];

  Map<String, dynamic> incident = {
    'updated': 'Updated 26 min ago',
    'image': 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=900',
    'tags': ['High impact', 'Power outage, developing'],
    'title': 'Windstorm power outages across the valley',
    'body': 'High winds knocked out power. Crews are restoring lines while neighbors share updates and photos.',
    'stats': [
      {'label': 'Affected', 'value': '~4,200'},
      {'label': 'Power back', 'value': 'By 6 PM'},
      {'label': 'Source', 'value': 'PSE'},
    ],
    'note': 'The full incident page has the discussion board, solutions and resources.',
  };
  List<String> incidentTabs = ['Timeline', 'News 3', 'Photos 12', 'Discuss'];
  int incidentTab = 0;
  List<Map<String, String>> timeline = [
    {'time': '7:04 AM', 'source': 'Official', 'body': 'PSE: outage area affects about 4,200 customers.'},
    {'time': '6:32 AM', 'source': 'Neighbor', 'body': 'Trees down across SE 45th St. Road partly blocked.'},
    {'time': '5:58 AM', 'source': 'Official', 'body': 'Crews dispatched. Power expected back by 6 PM.'},
    {'time': '4:21 AM', 'source': 'Neighbor', 'body': 'First reports from Riverbend and nearby streets.'},
  ];
  bool following = false;

  void reportAlert() {}
  void openMyAlerts() {}
  void openIncident() {
    // the detail page builds a fresh carousel that starts on the first photo
    photoIndex = 0;
    Get.toNamed(AppRoutes.alertDetail);
  }

  List<Map<String, String>> helps = [
    {'title': 'Warming center open', 'body': 'Fall City Library, 8 AM to 8 PM'},
    {'title': 'PSE outage map', 'body': 'Outage area and restoration notes'},
  ];

  List<Map<String, dynamic>> solutions = [
    {'icon': CupertinoIcons.bolt_fill, 'tone': 'orange', 'title': 'Charging and warming spots', 'body': 'Fall City Library, 8 AM to 8 PM'},
    {'icon': CupertinoIcons.bus, 'tone': 'blue', 'title': 'Commute alternatives', 'body': 'Routes and timing around I-90'},
    {'icon': CupertinoIcons.wifi, 'tone': 'blue', 'title': 'Internet and cellular help', 'body': 'Provider updates and local workarounds'},
  ];

  List<String> followedRoutes = ['I-90 Snoqualmie Pass', 'I-90 Bellevue / Seattle'];
  String notifyLevel = 'Critical, major, advisories';
  List<Map<String, String>> routes = [
    {'image': 'https://images.unsplash.com/photo-1483664852095-d6cc6870702d?w=400', 'title': 'I-90 Snoqualmie Pass', 'tag': 'Advisory', 'tone': 'orange', 'body': 'Snow and ice. Chains required, reduced speeds.', 'source': 'WSDOT, 18 min ago'},
    {'image': 'https://images.unsplash.com/photo-1545158535-c3f7168c28b6?w=400', 'title': 'I-90 to Bellevue', 'tag': '30-45 min', 'tone': 'orange', 'body': 'Collision near I-405. Heavy traffic.', 'source': 'WSDOT, 12 min ago'},
  ];

  List<String> journalTabs = ['Top alerts', 'Local', 'Travel and passes', 'Power'];
  int journalTab = 0;
  List<Map<String, dynamic>> journal = [
    {'icon': CupertinoIcons.bolt_fill, 'tone': 'red', 'title': 'Windstorm power outages across the valley', 'meta': 'PSE. Developing. Updated 26 min ago', 'replies': 48, 'solutions': 11},
    {'icon': CupertinoIcons.wifi, 'tone': 'blue', 'title': 'Xfinity internet disruption in Fall City', 'meta': 'Xfinity. Investigating. Updated 18 min ago', 'replies': 37, 'solutions': 8},
    {'icon': CupertinoIcons.car_detailed, 'tone': 'orange', 'title': 'I-90 Snoqualmie Pass travel advisory', 'meta': 'WSDOT. Chains required. Updated 18 min ago', 'replies': 32, 'solutions': 7},
  ];
  String journalFooter = 'Showing 3 of 6 alerts';

  String mapImage = 'https://preetis-html.vercel.app/assets/images/alerts/alerts-home2/fall-city-map.svg';
  List<String> mapFilters = ['Local alerts', 'Travel', 'Other'];
  Set<String> activeMapFilters = {'Local alerts', 'Travel', 'Other'};

  List<String> newsTabs = ['All 4', 'WikiXM', 'Neighbors', 'Official'];
  int newsTab = 0;
  Map<String, String> newsHero = {'image': 'https://images.unsplash.com/photo-1527482797697-8795b05a13fe?w=900', 'tag': 'WikiXM news', 'title': 'Windstorm brings outages and downed trees to Fall City', 'meta': '5 min read, 24 replies'};
  List<Map<String, String>> news = [
    {'image': 'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?w=300', 'tag': 'Official update', 'tone': 'green', 'title': 'PSE crews working on SE 45th St', 'meta': '18 min ago, 2 photos, 12 replies'},
    {'image': 'https://images.unsplash.com/photo-1544197150-b99a580bb7a8?w=300', 'tag': 'Community report', 'tone': 'violet', 'title': 'Xfinity internet patchy in parts of town', 'meta': '47 min ago, 4 photos, 18 replies'},
    {'image': 'https://images.unsplash.com/photo-1418985991508-e47386d96a71?w=300', 'tag': 'WikiXM news', 'tone': 'blue', 'title': 'Snoqualmie Pass: snow and chains required', 'meta': '1 hr ago, 8 photos, 14 replies'},
  ];
  List<String> neighborPhotos = ['https://images.unsplash.com/photo-1511497584788-876760111969?w=200', 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=200', 'https://images.unsplash.com/photo-1476231682828-37e571bc172f?w=200'];
  String neighborPhotosLabel = '12 neighbor photos';

  List<Map<String, dynamic>> explore = [
    {'icon': CupertinoIcons.car_detailed, 'title': 'Roads', 'count': 1},
    {'icon': CupertinoIcons.triangle_fill, 'title': 'Passes', 'count': 1},
    {'icon': CupertinoIcons.bolt, 'title': 'Power', 'count': 1},
    {'icon': CupertinoIcons.wifi, 'title': 'Internet', 'count': 1},
    {'icon': CupertinoIcons.cloud_sun, 'title': 'Weather', 'count': 1},
    {'icon': Icons.waves, 'title': 'Flooding', 'count': 0},
    {'icon': Icons.monitor_heart_outlined, 'title': 'Quakes', 'count': 0},
    {'icon': CupertinoIcons.shield, 'title': 'Safety', 'count': 0},
  ];
  List<Map<String, dynamic>> exploreLinks = [
    {'icon': CupertinoIcons.chat_bubble, 'title': 'What are neighbors seeing?', 'body': 'Live observations, questions and local talk', 'link': 'Explore conversations'},
    {'icon': CupertinoIcons.bell, 'title': 'Stay informed your way', 'body': 'Follow Fall City, routes and topics', 'link': 'Customize my alerts'},
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

  void selectNewsTab(int i) {
    newsTab = i;
    update([ControllerBuilders.alertsHome]);
  }

  void toggleFollow() {
    following = !following;
    update([ControllerBuilders.alertsHome, ControllerBuilders.alertDetail]);
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

  List<String> detailTags = ['Incident hub', 'Developing'];
  String detailTitle = 'Windstorm power outage';
  String detailIntro = 'Official updates, photos and neighbors\' reports about the Fall City windstorm, all in one place.';
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

  String whatHappened = 'A strong windstorm moved through the Snoqualmie Valley overnight, bringing down trees and power lines. Utility crews and local agencies are responding while neighbors share what they see.';
  List<Map<String, dynamic>> impacts = [
    {'icon': CupertinoIcons.bolt_fill, 'tone': 'orange', 'title': 'Power outage', 'body': '~4,200 customers'},
    {'icon': CupertinoIcons.car_detailed, 'tone': 'blue', 'title': 'Road impacts', 'body': 'Several areas'},
    {'icon': CupertinoIcons.wifi, 'tone': 'red', 'title': 'Internet and cell', 'body': 'On and off'},
    {'icon': Icons.park_outlined, 'tone': 'green', 'title': 'Tree damage', 'body': 'Neighbor reports'},
  ];

  List<Map<String, String>> detailTimeline = [
    {'time': '7:04 AM', 'source': 'PSE', 'body': 'Outage area grew to about 4,200 customers.'},
    {'time': '6:32 AM', 'source': 'Neighbor', 'body': 'Trees reported down near SE 45th Street.'},
    {'time': '5:58 AM', 'source': 'PSE', 'body': 'Crews dispatched. Power estimated back by 6 PM.'},
    {'time': '4:21 AM', 'source': 'Neighbor', 'body': 'First reports from Riverbend and nearby streets.'},
  ];
  int latestCount = 3;

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

  List<String> detailPhotos = [
    'https://images.unsplash.com/photo-1511497584788-876760111969?w=300',
    'https://images.unsplash.com/photo-1448375240586-882707db888b?w=300',
    'https://images.unsplash.com/photo-1476231682828-37e571bc172f?w=300',
    'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=300',
    'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?w=300',
    'https://images.unsplash.com/photo-1527482797697-8795b05a13fe?w=300',
    'https://images.unsplash.com/photo-1418985991508-e47386d96a71?w=300',
    'https://images.unsplash.com/photo-1544197150-b99a580bb7a8?w=300',
  ];

  List<model.Post> discussion = [
    model.Post(firstName: 'Fall City', lastName: 'editor', authorRoleLabel: 'Editor', createdAtLabel: '8 min ago', avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200', title: 'Warming center open at the library', body: 'Fall City Library is open 8 AM to 8 PM with outlets, wifi and hot drinks. Please share with neighbors without power.', likesCount: 42, commentsCount: 9),
    model.Post(firstName: 'Maya', lastName: 'R.', createdAtLabel: '12 min ago', avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200', title: 'Power flickering near Riverbend', body: 'Power just came back on near the elementary school, then went out again a minute later.', likesCount: 14, commentsCount: 3),
    model.Post(
      firstName: 'Dan',
      lastName: 'K.',
      createdAtLabel: '28 min ago',
      avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2a?w=200',
      title: 'Trees still down on SE 45th St',
      body: 'Two trees across the road past the bridge. Crews are on the way, take Fall City-Preston instead.',
      image: 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=400',
      likesCount: 22,
      commentsCount: 6,
      isLiked: 1,
    ),
    model.Post(firstName: 'Priya', lastName: 'S.', createdAtLabel: '41 min ago', avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200', title: 'Generator safety reminder', body: 'Keep generators outside and away from windows. Carbon monoxide builds up fast in garages.', likesCount: 31, commentsCount: 4, isSaved: 1),
  ];

  int discussionPreviewCount = 2;

  List<String> get detailTabs => ['Overview', 'Discussion (${discussion.length})', 'Timeline (${detailTimeline.length})', 'Articles (${articles.length})', 'Photos (${detailPhotos.length})'];

  Map<String, String> sponsor = {'title': 'Cedar River Insurance', 'body': 'Home, auto, business and life cover', 'link': 'Get a quote'};

  final reportText = TextEditingController();
  final reportFocus = FocusNode();

  void refreshDetail() => update([ControllerBuilders.alertDetail]);

  void onPhotoChanged(int i) {
    photoIndex = i;
    refreshDetail();
  }

  void selectDetailTab(int i) {
    detailTab = i;
    refreshDetail();
  }

  void toggleBookmark() {
    bookmarked = !bookmarked;
    refreshDetail();
  }

  void share() {}
  void openSource(Map<String, dynamic> s) {}
  void openArticle(Map<String, String> a) {}
  void addPhoto() {}
  void openPhoto(int i) => PhotoViewer.open(detailPhotos, index: i);
  void newPost() => reportFocus.requestFocus();

  void sendReport() {
    if (reportText.text.trim().isEmpty) return;
    // shortcut: adds the post locally only, send it to the API once the incident report endpoint exists
    discussion.insert(0, model.Post(firstName: 'You', createdAtLabel: 'Just now', avatar: editorImage, title: 'What I\'m seeing', body: reportText.text.trim(), likesCount: 0, commentsCount: 0));
    reportText.clear();
    Get.focusScope?.unfocus();
    selectDetailTab(1);
  }
}
