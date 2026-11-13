import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' show ImageByteFormat, PictureRecorder;
import 'package:wikixm/Presentation/groups/controller.dart';
import 'package:wikixm/data/datasource/Repository_impl/group_repository_impl.dart';
import '../../approutes.dart';
import '../../constants/appcolor.dart';
import '../../constants/constants.dart';
import '../../core/error/failures.dart';
import '../../data/datasource/local/local_storage.dart';
import '../../data/datasource/remote/models/response/create_group.dart';

String _failureMessage(Failure f) => (f is ServerFailure ? f.message : null) ?? 'Something went wrong';

void _toast(String msg) => Fluttertoast.showToast(msg: msg, gravity: ToastGravity.BOTTOM);

class CreateGroupController extends GetxController {
  final GroupRepositoryImpl _repo = GroupRepositoryImpl();
  final ImagePicker _picker = ImagePicker();

  static const totalSteps = 7;
  static const maxNameLength = 150;
  static const maxDescriptionLength = 2000;
  static const maxGalleryImages = 6;
  static const maxQuestionLength = 500;
  static const _privacyByVisibility = {'public': 1, 'public-approval': 1, 'private': 2, 'hidden': 3};

  bool isLoading = true;
  String? loadError;
  CreateGroupOptions? options;
  int currentStep = 0;
  bool isSubmitting = false;
  String? aiAction;

  /// Errors shown in red under their fields, keyed by field (name, interests, purpose, audience_detail, city, description, question_N).
  final Map<String, String> fieldErrors = {};

  final nameController = TextEditingController();
  final purposeController = TextEditingController();
  final descriptionController = TextEditingController();
  final audienceInviteController = TextEditingController();
  final scrollController = ScrollController();

  int? categoryId;
  int? subcategoryId;
  final List<int> interestIds = [];

  String audience = '';
  String? audienceDetail;

  int? cityId;
  int radius = 0;
  List<GroupTown> coverageTowns = [];
  bool coverageLoading = false;
  final Set<int> includedTownIds = {};
  int _coverageRequest = 0;

  String? coverPath;
  String? avatarPath;
  final List<String> galleryPaths = [];

  String visibility = '';
  final List<TextEditingController> questionControllers = [];
  final List<bool> questionRequired = [];
  final Set<String> permissions = {};
  final Set<String> topics = {};
  String moderation = '';
  final Set<String> rules = {};
  final List<TextEditingController> guidelineControllers = [];

  GroupFormOptions? get form => options?.formOptions;

  /// Saved at login.
  // shortcut: falls back to the staging test user for sessions that logged in before the name was saved; remove once everyone has re-logged in
  String get firstName {
    final saved = LocalStorage.getString(GetXStorageConstants.firstName);
    return saved.isEmpty ? 'Alwin' : saved;
  }

  List<GroupCategory> get categories => options?.categories.where((c) => c.parentId == null).toList() ?? [];

  List<GroupCategory> get subcategories => categoryId == null ? [] : options!.categories.where((c) => c.parentId == categoryId).toList();

  List<GroupInterest> get subcategoryInterests => subcategoryId == null ? [] : options!.interests.where((i) => i.categoryId == subcategoryId).toList();

  String get membership => form?.groupPrivacy.firstWhereOrNull((o) => o.value == visibility)?.membership ?? 'open';

  /// Joining questions only apply when an admin reviews requests (Public · Approval, Private).
  bool get asksQuestions => membership == 'approval';

  bool get allowPhotos => permissions.contains('photos');

  bool get allowComments => permissions.contains('comments');

  GroupTown? get originTown => options?.towns.firstWhereOrNull((t) => t.id == cityId);

  @override
  void onInit() {
    for (final c in [nameController, purposeController, descriptionController, audienceInviteController]) {
      c.addListener(_onTextChanged);
    }
    final prefetched = _prefetched;
    _prefetched = null;
    prefetched == null ? loadOptions() : _applyOptions(prefetched);
    super.onInit();
  }

  // the groups page fetches the options early so the form opens without the shimmer
  static CreateGroupOptionsResponse? _prefetched;

  static Future<void> prefetchOptions() async {
    final result = await GroupRepositoryImpl().createGroupOptions();
    _prefetched = result.fold((l) => null, (r) => r);
  }

  @override
  void onClose() {
    for (final c in [nameController, purposeController, descriptionController, audienceInviteController, ...questionControllers, ...guidelineControllers]) {
      c.dispose();
    }
    scrollController.dispose();
    prefetchOptions(); // ready for the next time the form opens
    super.onClose();
  }

  void _refresh() => update([ControllerBuilders.createGroupController, ControllerBuilders.createGroupProgress]);

  /// How much of each page (0–1) is filled in; drives the progress bar and percentage.
  List<double> get stepProgress {
    if (options == null) return List.filled(totalSteps, 0);
    bool filled(TextEditingController c) => c.text.trim().isNotEmpty;
    double done(List<bool> checks) => checks.where((c) => c).length / checks.length;
    final pages = [
      done([
        filled(nameController) && nameController.text.trim().length <= maxNameLength,
        interestIds.isNotEmpty,
        filled(purposeController),
        switch (audience) {
          'invite' => filled(audienceInviteController),
          'skill' || 'type' => audienceDetail != null,
          _ => audience.isNotEmpty,
        },
      ]),
      done([cityId != null, includedTownIds.isNotEmpty]),
      done([filled(descriptionController) && descriptionController.text.trim().length <= maxDescriptionLength, coverPath != null]),
      done([visibility.isNotEmpty, !asksQuestions || questionControllers.every(filled), permissions.isNotEmpty]),
      done([topics.isNotEmpty, moderation.isNotEmpty]),
      done([rules.isNotEmpty]),
    ];
    // the review page has nothing to fill in; it completes with the rest
    final all = [...pages, pages.every((p) => p == 1) ? 1.0 : 0.0];
    // pages ahead of the user are pre-filled with API defaults, so they only count once reached
    return [for (var i = 0; i < totalSteps; i++) i <= _furthestStep ? all[i] : 0];
  }

  int get progressPercent => (stepProgress.reduce((a, b) => a + b) / totalSteps * 100).round();

  List<double> _lastProgress = [];
  int _furthestStep = 0;

  /// Typing only rebuilds the progress card, and only when a page's completion changes.
  void _onTextChanged() {
    final progress = stepProgress;
    if (listEquals(progress, _lastProgress)) return;
    _lastProgress = progress;
    update([ControllerBuilders.createGroupProgress]);
  }

  String _defaultOf(List<GroupFormOption> list) => (list.firstWhereOrNull((o) => o.defaultChecked) ?? list.firstOrNull)?.value ?? '';

  Future<void> loadOptions() async {
    isLoading = true;
    loadError = null;
    _refresh();
    final result = await _repo.createGroupOptions();
    result.fold((l) {
      loadError = _failureMessage(l);
      isLoading = false;
      _refresh();
    }, _applyOptions);
  }

  void _applyOptions(CreateGroupOptionsResponse r) {
    options = r.data;
    final f = r.data?.formOptions;
    if (f != null) {
      audience = _defaultOf(f.audience);
      visibility = _defaultOf(f.groupPrivacy);
      moderation = _defaultOf(f.moderation);
      permissions.addAll(f.memberPermissions.where((o) => o.defaultChecked).map((o) => o.value));
      topics.addAll(f.topics.where((o) => o.defaultChecked).map((o) => o.value));
      rules.addAll(f.rules.where((o) => o.defaultChecked).map((o) => o.value));
    }
    final towns = r.data?.towns ?? [];
    cityId = (towns.firstWhereOrNull((t) => t.isPrimary == true) ?? towns.firstOrNull)?.id;
    radius = 0; // starts as "Town only"; the user widens coverage from the radius chips
    isLoading = false;
    _refresh();
    if (cityId != null) loadCoverage();
  }

  Future<void> loadCoverage() async {
    if (cityId == null) return;
    final request = ++_coverageRequest;
    coverageLoading = true;
    _refresh();
    final result = await _repo.groupCoverage(cityId!, radius);
    if (request != _coverageRequest) return; // a newer town/radius pick superseded this one
    result.fold((l) => _toast(_failureMessage(l)), (r) {
      coverageTowns = r.towns;
      includedTownIds
        ..clear()
        ..addAll(r.towns.map((t) => t.id).whereType<int>());
    });
    coverageLoading = false;
    _refresh();
  }

  void selectTown(int? id) {
    if (id == null || id == cityId) return;
    cityId = id;
    fieldErrors.remove('city');
    loadCoverage();
  }

  void selectRadius(int value) {
    if (value == radius) return;
    radius = value;
    loadCoverage();
  }

  void toggleTown(int id) {
    if (id == cityId) return; // origin is always included
    includedTownIds.contains(id) ? includedTownIds.remove(id) : includedTownIds.add(id);
    _refresh();
  }

  void selectCategory(int? id) {
    if (id == categoryId) return;
    fieldErrors.remove('interests');
    categoryId = id;
    subcategoryId = null;
    interestIds.clear();
    _refresh();
  }

  void selectSubcategory(int? id) {
    if (id == subcategoryId) return;
    fieldErrors.remove('interests');
    subcategoryId = id;
    interestIds.clear();
    _refresh();
  }

  void toggleInterest(int id) {
    fieldErrors.remove('interests');
    interestIds.contains(id) ? interestIds.remove(id) : interestIds.add(id);
    _refresh();
  }

  void selectAudience(String value) {
    audience = value;
    fieldErrors.remove('audience_detail');
    audienceDetail = switch (value) {
      'skill' => _defaultOf(form!.audienceSkill),
      'type' => _defaultOf(form!.audienceType),
      _ => null,
    };
    _refresh();
  }

  void selectAudienceDetail(String value) {
    audienceDetail = value;
    _refresh();
  }

  void selectVisibility(String value) {
    visibility = value;
    _clearQuestionErrors();
    _refresh();
  }

  void toggleIn(Set<String> set, String value) {
    set.contains(value) ? set.remove(value) : set.add(value);
    _refresh();
  }

  void selectModeration(String value) {
    moderation = value;
    _refresh();
  }

  void addQuestion([String text = '', bool required = false]) {
    if (questionControllers.length >= (form?.joiningQuestions.max ?? 3)) return;
    _clearQuestionErrors();
    questionControllers.add(TextEditingController(text: text)..addListener(_onTextChanged));
    questionRequired.add(required);
    _refresh();
  }

  void removeQuestion(int index) {
    _clearQuestionErrors();
    questionControllers.removeAt(index).dispose();
    questionRequired.removeAt(index);
    _refresh();
  }

  void toggleQuestionRequired(int index) {
    questionRequired[index] = !questionRequired[index];
    _refresh();
  }

  // question errors are keyed by index, which shifts on add/remove
  void _clearQuestionErrors() => fieldErrors.removeWhere((key, _) => key.startsWith('question_'));

  void addGuideline() {
    if (guidelineControllers.length >= (form?.additionalGuidelines.max ?? 3)) return;
    guidelineControllers.add(TextEditingController());
    _refresh();
  }

  void removeGuideline(int index) {
    guidelineControllers.removeAt(index).dispose();
    _refresh();
  }

  Future<String?> _pick() async => (await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85, maxWidth: 2000, maxHeight: 2000))?.path;

  Future<void> pickCover() async {
    final path = await _pick();
    if (path == null) return;
    coverPath = path;
    fieldErrors.remove('cover');
    _refresh();
  }

  Future<void> pickAvatar() async {
    final path = await _pick();
    if (path == null) return;
    avatarPath = path;
    fieldErrors.remove('avatar');
    _refresh();
  }

  Future<void> pickGallery() async {
    final left = maxGalleryImages - galleryPaths.length;
    if (left <= 0) return _toast('You can add up to $maxGalleryImages photos');
    final picked = await _picker.pickMultiImage(imageQuality: 85, maxWidth: 2000, maxHeight: 2000);
    galleryPaths.addAll(picked.take(left).map((x) => x.path));
    _refresh();
  }

  void removeCover() {
    coverPath = null;
    _refresh();
  }

  void removeAvatar() {
    avatarPath = null;
    _refresh();
  }

  void removeGalleryImage(int index) {
    galleryPaths.removeAt(index);
    _refresh();
  }

  String? errorOf(String key) => fieldErrors[key];

  void clearError(String key) {
    if (fieldErrors.remove(key) != null) _refresh();
  }

  static int _stepOf(String key) => switch (key) {
    'city' => 1,
    'description' || 'cover' || 'avatar' || 'gallery' => 2,
    _ when key.startsWith('question_') => 3,
    _ => 0,
  };

  Map<String, String> _validateStep(int step) {
    final errors = <String, String>{};
    switch (step) {
      case 0:
        final name = nameController.text.trim();
        if (name.isEmpty) {
          errors['name'] = 'Group name is required';
        } else if (name.length > maxNameLength) {
          errors['name'] = 'Group name can be at most $maxNameLength characters';
        }
        if (interestIds.isEmpty) {
          errors['interests'] = categoryId == null ? 'Choose a category' : (subcategoryId == null ? 'Choose a subcategory' : 'Choose at least one interest');
        }
        if (purposeController.text.trim().isEmpty) errors['purpose'] = 'Group purpose is required';
        if (audience == 'invite' && audienceInviteController.text.trim().isEmpty) errors['audience_detail'] = 'Describe who you would like to invite';
      case 1:
        if (cityId == null) errors['city'] = 'Choose your primary town';
      case 2:
        final description = descriptionController.text.trim();
        if (description.isEmpty) {
          errors['description'] = 'Group description is required';
        } else if (description.length > maxDescriptionLength) {
          errors['description'] = 'Description can be at most $maxDescriptionLength characters';
        }
        if (coverPath == null) errors['cover'] = 'Cover photo is required';
      case 3:
        for (var i = 0; asksQuestions && i < questionControllers.length; i++) {
          final question = questionControllers[i].text.trim();
          if (question.isEmpty) {
            errors['question_$i'] = 'Write a question or remove it';
          } else if (question.length > maxQuestionLength) {
            errors['question_$i'] = 'A question can be at most $maxQuestionLength characters';
          }
        }
    }
    return errors;
  }

  /// Replaces [step]'s errors with a fresh check; true when the step is valid.
  bool _validate(int step) {
    fieldErrors.removeWhere((key, _) => _stepOf(key) == step);
    final errors = _validateStep(step);
    fieldErrors.addAll(errors);
    _refresh();
    return errors.isEmpty;
  }

  static String? _fieldOfServerKey(String key) {
    final question = RegExp(r'^settings\.membership_questions\.(\d+)\.question$').firstMatch(key);
    if (question != null) return 'question_${question[1]}';
    if (key.startsWith('gallery_images')) return 'gallery'; // also gallery_images.N for one bad photo
    return const {
      'name': 'name',
      'description': 'description',
      'cover_image': 'cover',
      'avatar_image': 'avatar',
      'city_id': 'city',
      'radius_miles': 'city',
      'included_town_ids': 'city',
      'interest_id': 'interests',
      'settings.interest_ids': 'interests',
      'settings.purpose': 'purpose',
      'settings.audience_detail': 'audience_detail',
    }[key];
  }

  /// Shows a 422's field errors under their fields and opens the earliest step that has one.
  void _showServerErrors(Failure failure) {
    final mapped = <String, String>{};
    (failure is ServerFailure ? failure.errors : null)?.forEach((key, value) {
      final field = _fieldOfServerKey(key);
      if (field != null) mapped.putIfAbsent(field, () => value is List && value.isNotEmpty ? value.first.toString() : value.toString());
    });
    if (mapped.isEmpty) return _toast(_failureMessage(failure));
    fieldErrors.addAll(mapped);
    goToStep(mapped.keys.map(_stepOf).reduce(min));
  }

  void nextStep() {
    if (!_validate(currentStep)) return; // errors show in red under each field
    if (currentStep < totalSteps - 1) {
      goToStep(currentStep + 1);
    } else {
      submit();
    }
  }

  void previousStep() {
    if (currentStep == 0) return Get.back();
    goToStep(currentStep - 1);
  }

  void goToStep(int step) {
    // jump before the rebuild: animating would scroll the new step past the user
    if (scrollController.hasClients) scrollController.jumpTo(0);
    currentStep = step.clamp(0, totalSteps - 1);
    _furthestStep = max(_furthestStep, currentStep);
    _refresh();
  }

  String _labelOf(List<GroupFormOption> list, String? value) => list.firstWhereOrNull((o) => o.value == value)?.label ?? '';

  String get audienceSummary {
    final label = _labelOf(form?.audience ?? [], audience);
    final detail = audience == 'invite' ? audienceInviteController.text.trim() : _labelOf(audience == 'skill' ? form!.audienceSkill : form?.audienceType ?? [], audienceDetail);
    return detail.isEmpty ? label : '$label · $detail';
  }

  String labelsOf(List<GroupFormOption> list, Set<String> values) => list.where((o) => values.contains(o.value)).map((o) => o.label).join(', ');

  String get interestSummary => interestIds.map((id) => options!.interests.firstWhereOrNull((i) => i.id == id)?.name).whereType<String>().join(', ');

  String get categorySummary => [categoryId, subcategoryId].map((id) => options?.categories.firstWhereOrNull((c) => c.id == id)?.name).whereType<String>().join(' — ');

  String get visibilityLabel => _labelOf(form?.groupPrivacy ?? [], visibility);

  String get membershipLabel => _labelOf(form?.membershipApproval ?? [], membership);

  String get moderationLabel => _labelOf(form?.moderation ?? [], moderation);

  Map<String, dynamic> _body() => {
    'name': nameController.text.trim(),
    'description': descriptionController.text.trim(),
    'city_id': cityId,
    'interest_id': interestIds.first,
    'privacy': _privacyByVisibility[visibility] ?? 1,
    'radius_miles': radius,
    'included_town_ids': includedTownIds.toList(),
    'settings': {
      'purpose': purposeController.text.trim(),
      'interest_ids': interestIds,
      'audience': audience,
      'audience_detail': audience == 'invite' ? audienceInviteController.text.trim() : audienceDetail,
      'visibility': visibility,
      'membership': membership,
      'membership_questions': [
        for (var i = 0; asksQuestions && i < questionControllers.length; i++) {'id': 'q${i + 1}', 'question': questionControllers[i].text.trim(), 'required': questionRequired[i]},
      ],
      'permissions': permissions.toList(),
      'topics': topics.toList(),
      'moderation': moderation,
      'allow_photos': allowPhotos,
      'allow_comments': allowComments,
      'rules': rules.toList(),
      'additional_rules': guidelineControllers.map((c) => c.text.trim()).where((t) => t.isNotEmpty).toList(),
    },
  };

  Future<void> submit() async {
    if (isSubmitting) return;
    for (var step = 0; step < totalSteps; step++) {
      if (!_validate(step)) {
        return goToStep(step);
      }
    }
    isSubmitting = true;
    _refresh();
    final result = await _repo.createGroup(_body(), coverPath: coverPath, avatarPath: avatarPath, galleryPaths: galleryPaths);
    final groupId = result.fold((l) => null, (id) => id);
    // fetched while the button still spins, so the confirmation screen opens filled
    final created = groupId == null ? null : (await _repo.groupCreated(groupId)).fold((l) => null, (r) => r.data);
    isSubmitting = false;
    _refresh();
    result.fold(_showServerErrors, (groupId) => Get.offNamed(AppRoutes.groupCreated, arguments: {'id': groupId, 'group': created}));
  }

  Future<Map<String, dynamic>?> _ai(String action, Map<String, dynamic> context) async {
    if (aiAction != null) return null;
    aiAction = action;
    _refresh();
    final result = await _repo.groupAiAssist(action, context);
    aiAction = null;
    _refresh();
    return result.fold((l) {
      _toast(_failureMessage(l));
      return null;
    }, (r) => r);
  }

  Future<void> suggestCategory() async {
    if (nameController.text.trim().isEmpty) return _toast('Enter a group name first');
    // suggest_group_details also returns a purpose; suggest_category_interests does not
    final s = await _ai('suggest_group_details', {'name': nameController.text.trim(), 'purpose': purposeController.text.trim()});
    if (s == null) return;
    final purpose = s['purpose'];
    if (purposeController.text.trim().isEmpty && purpose is String && purpose.isNotEmpty) {
      purposeController.text = purpose;
      clearError('purpose');
    }
    categoryId = s['category_id'];
    subcategoryId = s['subcategory_id'];
    interestIds
      ..clear()
      ..addAll(List<int>.from(s['interest_ids'] ?? []).where((id) => options!.interests.any((i) => i.id == id && i.categoryId == subcategoryId)));
    _refresh();
  }

  Future<void> suggestDescription() async {
    if (nameController.text.trim().isEmpty) return _toast('Enter a group name first');
    final current = descriptionController.text.trim();
    final s = await _ai(current.isEmpty ? 'generate_description' : 'improve_description', {
      'name': nameController.text.trim(),
      'purpose': purposeController.text.trim(),
      'audience': _labelOf(form?.audience ?? [], audience),
      'privacy': visibility,
      if (current.isNotEmpty) 'description': current,
    });
    final description = s?['description'];
    if (description is! String) return;
    descriptionController.text = description;
    clearError('description');
    _refresh();
  }

  Future<void> suggestQuestions() async {
    if (nameController.text.trim().isEmpty) return _toast('Enter a group name first');
    final s = await _ai('generate_joining_questions', {'name': nameController.text.trim(), 'purpose': purposeController.text.trim()});
    final questions = s?['questions'];
    if (questions is! List) return;
    for (final c in questionControllers) {
      c.dispose();
    }
    questionControllers.clear();
    questionRequired.clear();
    for (final q in questions.whereType<Map>()) {
      addQuestion(q['question']?.toString() ?? '', q['required'] == true);
    }
  }
}

class GroupCreatedController extends GetxController {
  final GroupRepositoryImpl _repo = GroupRepositoryImpl();

  final int groupId = Get.arguments?['id'] ?? 0;
  GroupCreatedData? group = Get.arguments?['group'];
  late bool isLoading = group == null;

  @override
  void onInit() {
    if (isLoading) loadGroup(); // only when the prefetch failed
    super.onInit();
  }

  void _refresh() => update([ControllerBuilders.createGroupController]);

  Future<void> loadGroup() async {
    final result = await _repo.groupCreated(groupId);
    result.fold((l) => _toast(_failureMessage(l)), (r) => group = r.data);
    isLoading = false;
    _refresh();
  }

  /// Replaces this screen, so back from the group skips the confirmation.
  void viewGroup() {
    final groups = Get.isRegistered<GroupController>() ? Get.find<GroupController>() : Get.put(GroupController(), permanent: true);
    Get.offNamed(AppRoutes.detailPage);
    groups.getGroupDetail('$groupId', 'overview');
  }

  Future<void> copyGroupLink() async {
    final url = group?.url;
    if (url == null || url.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: url));
    _toast('Group link copied');
  }

  Future<void> shareQr() async {
    final url = group?.url;
    if (url == null || url.isEmpty) return;
    // white square with a margin so the code scans on any chat background
    const size = 600.0, margin = 48.0;
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder)..drawRect(const Rect.fromLTWH(0, 0, size, size), Paint()..color = AppColor.white);
    canvas.translate(margin, margin);
    QrPainter(data: url, version: QrVersions.auto, gapless: true).paint(canvas, const Size.square(size - margin * 2));
    final image = await recorder.endRecording().toImage(size.toInt(), size.toInt());
    final png = await image.toByteData(format: ImageByteFormat.png);
    if (png == null) return _toast('Could not create the QR code');
    await _share(ShareParams(
      text: group?.name,
      files: [XFile.fromData(png.buffer.asUint8List(), mimeType: 'image/png')],
      fileNameOverrides: ['group-qr.png'],
      sharePositionOrigin: _shareOrigin,
    ));
  }

  Future<void> shareGroup() async {
    final url = group?.url;
    if (url == null || url.isEmpty) return;
    // a bare uri lets iOS fetch the page's meta tags for the preview card; uri can't be combined with text
    await _share(ShareParams(uri: Uri.tryParse(url), title: group?.name, subject: group?.name, sharePositionOrigin: _shareOrigin));
  }

  // iPad needs an anchor for the share popover; mid-screen works everywhere
  Rect get _shareOrigin => Rect.fromCenter(center: Get.size.center(Offset.zero), width: 1, height: 1);

  Future<void> _share(ShareParams params) async {
    try {
      await SharePlus.instance.share(params);
    } catch (e) {
      _toast('Could not open sharing');
      debugPrint('share failed: $e');
    }
  }
}
