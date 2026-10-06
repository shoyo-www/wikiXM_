import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wikixm/constants/constants.dart';
import 'package:wikixm/data/datasource/Repository_impl/garage_repository_impl.dart';
import 'package:wikixm/data/datasource/remote/models/request/image_upload.dart';
import 'package:wikixm/data/datasource/remote/models/request/no_params_req.dart';
import 'package:wikixm/data/datasource/remote/models/response/image_analyse.dart';
import 'package:wikixm/data/datasource/remote/models/response/market_brief_ai.dart';
import 'package:wikixm/data/datasource/remote/models/response/market_filters.dart';
import 'package:wikixm/data/datasource/remote/models/response/my_garage_dashboard.dart';

import '../../core/error/failures.dart';
import '../../data/datasource/remote/models/response/market_brief.dart' hide Category;
import '../../data/datasource/remote/models/response/market_brief_charts.dart';
import '../../data/datasource/remote/models/response/market_place.dart';
import '../../data/datasource/remote/models/response/market_place_content.dart';
import '../../data/datasource/remote/models/response/my_garage_AI.dart';

class GarageImageItem {
  final XFile file;
  bool isUploading;
  bool hasError;
  String? url;
  int? photoId;

  GarageImageItem({required this.file, this.isUploading = false, this.hasError = false, this.url, this.photoId});
}

class GarageController extends GetxController {
  bool isLoading = false;
  bool marketLoading = false;
  bool secondStep = false;
  bool thirdStep = false;
  bool fourthStep = false;
  bool fifthStep = false;
  bool allPrices = false;
  String averagePriceRange = 'Last 3 Months';
  String listingActivityRange = 'Last 3 Months';
  final ImagePicker _picker = ImagePicker();
  static const int maxImages = 10;
  final List<GarageImageItem> images = [];
  bool isFeatured = false;
  int selectedSellingOption = 1;
  String description = '';
  String price = '500';
  String selectedLocation = 'Issaquah, WA';
  int? draftId;
  int? itemId;
  final GarageRepositoryImpl garageRepositoryImpl = GarageRepositoryImpl();
  final NoParamsRequest request = NoParamsRequest();

  bool get hasImages => images.isNotEmpty;

  bool get canAddMore => images.length < maxImages;

  int get imageCount => images.length;

  int get remainingImages => maxImages - images.length;

  double get imageProgress => images.length / maxImages;
  AnalyseData? analyseData;
  MarketAiBrief? marketAiBrief;
  MarketBriefData? marketBriefData;
  BriefChartsData? briefChartsData;
  MarketPlaceData? marketPlaceData;
  ContentData? contentData;
  MarketFilters? marketFilters;
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  String? selectedDistance;
  String? selectedSeller;
  String? selectedDate;
  final List<String> selectedConditions = [];
  final List<String> selectedMore = [];
  int currentMarketPlacePage = 1;
  int lastMarketPlacePage = 1;
  bool isLoadingMoreMarketPlace = false;
  bool hasMoreMarketPlace = true;
  static const int marketPlacePerPage = 24;
  Timer? searchDebounce;
  bool isClose = true;
  Category? category;
  String? selectedDiscount;
  GarageDashboardData? dashboardData;
  AIGarageData? aiGarageData;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    isLoading = true;
    update([ControllerBuilders.myGarageController]);
    await Future.wait([
    getMyGarage(),
    getMyGarageAI()
    ]);
    isLoading = false;
    update([ControllerBuilders.myGarageController]);
  }

  void initializeFilterDefaults() {
    final defaults = marketFilters?.defaults;
    selectedDistance = defaults?.distance;
    selectedSeller = defaults?.seller;
    selectedDate = defaults?.date;
    selectedConditions.clear();
    selectedMore.clear();
    minPriceController.clear();
    maxPriceController.clear();
    update([ControllerBuilders.filterController]);
  }

  void onMarketPlaceSearchChanged(String value) {
    isClose = false;
    update([ControllerBuilders.marketPlaceController]);
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(seconds: 1), () {
      getMarketPlace(page: 1);
    });
  }

  void toggleCondition(String value) {
    if (selectedConditions.contains(value)) {
      selectedConditions.remove(value);
    } else {
      selectedConditions.add(value);
    }
    update([ControllerBuilders.filterController]);
  }

  void toggleMoreFilter(String value) {
    if (selectedMore.contains(value)) {
      selectedMore.remove(value);
    } else {
      selectedMore.add(value);
    }
    update([ControllerBuilders.filterController]);
  }

  Future<void> clearFiltersAndReload() async {
    minPriceController.clear();
    maxPriceController.clear();
    selectedConditions.clear();
    selectedMore.clear();
    category = null;
    selectedDistance = marketFilters?.defaults?.distance;
    selectedDate = marketFilters?.defaults?.date;
    selectedSeller = marketFilters?.defaults?.seller;
    currentMarketPlacePage = 1;
    lastMarketPlacePage = 1;
    hasMoreMarketPlace = true;
    isLoadingMoreMarketPlace = false;
    update([ControllerBuilders.filterController, ControllerBuilders.marketPlaceController]);
    await getMarketPlace(page: 1);
  }

  Future<void> createDraft() async {
    if (draftId != null) return;
    final data = await garageRepositoryImpl.draft(request);
    data.fold((l) {}, (r) {
      if (r.success ?? false) {
        draftId = r.data?.itemId ?? 0;
      }
    });
  }

  Future<void> pickImage() => _pickAndUpload(ImageSource.gallery);

  Future<void> pickCameraImage() => _pickAndUpload(ImageSource.camera);

  Future<void> _pickAndUpload(ImageSource source) async {
    if (!canAddMore) return;
    final picked = await _picker.pickImage(source: source, imageQuality: 85, maxWidth: 2000, maxHeight: 2000);
    if (picked == null) return;
    await addAndUploadImage(picked);
  }

  Future<void> addAndUploadImage(XFile picked) async {
    await createDraft();
    if (draftId == null) {
      return;
    }
    final item = GarageImageItem(file: picked, isUploading: true);
    images.add(item);
    update([ControllerBuilders.addGarageItemController]);
    final uploadRequest = FileUploadRequest(filePath: picked.path);
    final result = await garageRepositoryImpl.uploadImage(uploadRequest, draftId ?? 0);
    result.fold(
      (l) {
        item.isUploading = false;
        item.hasError = true;
        update([ControllerBuilders.addGarageItemController]);
      },
      (r) {
        item.isUploading = false;
        if (r.success == true && r.data != null) {
          final data = r.data!;
          item.url = data.url;
          item.photoId = data.photoId;
          if (data.itemId != null) itemId = data.itemId;
        } else {
          item.hasError = true;
        }
        update([ControllerBuilders.addGarageItemController]);
      },
    );
  }

  Future<void> analyseImage() async {
    isLoading = true;
    update([ControllerBuilders.addGarageItemController]);
    final result = await garageRepositoryImpl.analyseImage(draftId ?? 0);
    result.fold(
      (l) {
        isLoading = false;
        update([ControllerBuilders.addGarageItemController]);
      },
      (r) {
        if (r.success == true) {
          analyseData = r.data;
          isLoading = false;
          secondStep = true;
          update([ControllerBuilders.addGarageItemController]);
        } else {
          isLoading = false;
          update([ControllerBuilders.addGarageItemController]);
        }
        update([ControllerBuilders.addGarageItemController]);
      },
    );
  }

  Future<void> removeImage(int index) async {
    secondStep = false;
    update([ControllerBuilders.addGarageItemController]);
    if (index < 0 || index >= images.length) return;
    final item = images[index];
    if (item.photoId == null) {
      images.removeAt(index);
      update([ControllerBuilders.addGarageItemController]);
      return;
    }
    final data = await garageRepositoryImpl.deleteImage(draftId ?? 0, item.photoId ?? 0);
    data.fold((failure) {}, (response) {
      if (response.success == true) {
        images.removeAt(index);
        update([ControllerBuilders.addGarageItemController]);
      }
    });
  }

  void makeMainPhoto(int index) {
    if (index <= 0 || index >= images.length) return;
    final item = images.removeAt(index);
    images.insert(0, item);
    update([ControllerBuilders.addGarageItemController]);
  }

  void updateLocation(String location) {
    selectedLocation = location;
    update([ControllerBuilders.addGarageItemController]);
  }

  void updatePrice(String value) {
    price = value;
    update([ControllerBuilders.addGarageItemController]);
  }

  void updateDescription(String value) {
    description = value;
    update([ControllerBuilders.addGarageItemController]);
  }

  void selectSellingOption(int index) {
    selectedSellingOption = index;
    update([ControllerBuilders.addGarageItemController]);
  }

  void onFeatured(bool value) {
    isFeatured = value;
    update([ControllerBuilders.addGarageItemController]);
  }

  void clearImages() {
    images.clear();
    update([ControllerBuilders.addGarageItemController]);
  }

  void getMarketBriefData() async {
    isLoading = true;
    update([ControllerBuilders.marketBriefController]);
    await Future.wait([getMarketAiBrief(), getMarketBrief(), getMarketBriefCharts()]);
    isLoading = false;
    update([ControllerBuilders.marketBriefController]);
  }

  Future<void> getMarketAiBrief() async {
    var data = await garageRepositoryImpl.marketAiBrief(46820);
    data.fold(
      (l) {
        if (l is ServerFailure) {
          isLoading = false;
          update([ControllerBuilders.marketBriefController]);
        }
      },
      (r) {
        bool status = r.success ?? false;
        if (status == true) {
          marketAiBrief = r.data;
          isLoading = false;
          update([ControllerBuilders.marketBriefController]);
        } else {
          isLoading = false;
          update([ControllerBuilders.marketBriefController]);
        }
      },
    );
  }

  Future<void> getMarketBrief() async {
    var data = await garageRepositoryImpl.marketBrief(46820);
    data.fold(
      (l) {
        if (l is ServerFailure) {
          isLoading = false;
          update([ControllerBuilders.marketBriefController]);
        }
      },
      (r) {
        bool status = r.success ?? false;
        if (status == true) {
          marketBriefData = r.data;
          isLoading = false;
          update([ControllerBuilders.marketBriefController]);
        } else {
          isLoading = false;
          update([ControllerBuilders.marketBriefController]);
        }
      },
    );
  }

  Future<void> getMarketBriefCharts() async {
    var data = await garageRepositoryImpl.marketBriefCharts(46820, 12);
    data.fold(
      (l) {
        if (l is ServerFailure) {
          isLoading = false;
          update([ControllerBuilders.marketBriefController]);
        }
      },
      (r) {
        bool status = r.success ?? false;
        if (status == true) {
          briefChartsData = r.data;
          isLoading = false;
          update([ControllerBuilders.marketBriefController]);
        } else {
          isLoading = false;
          update([ControllerBuilders.marketBriefController]);
        }
      },
    );
  }

  void getMarketPlaceData() async {
    marketLoading = true;
    update([ControllerBuilders.marketPlaceController]);
    await Future.wait([getMarketPlace(), getMarketPlaceContent(), getMarketPlaceFilters()]);
    marketLoading = false;
    update([ControllerBuilders.marketPlaceController]);
  }

  Future<void> getMarketPlace({int page = 1}) async {
    if (page == 1) {
      isLoading = true;
      currentMarketPlacePage = 1;
      lastMarketPlacePage = 1;
      hasMoreMarketPlace = true;
      update([ControllerBuilders.marketPlaceController]);
    } else {
      if (isLoadingMoreMarketPlace || !hasMoreMarketPlace) {
        return;
      }
      if (page > lastMarketPlacePage) {
        hasMoreMarketPlace = false;
        return;
      }
      isLoadingMoreMarketPlace = true;
      update([ControllerBuilders.marketPlaceController]);
    }

    final params = <String, dynamic>{'city_id': 46820, 'page': page, 'per_page': 10};
    if (minPriceController.text.trim().isNotEmpty) {
      final minPrice = double.tryParse(minPriceController.text.trim());

      if (minPrice != null) {
        params['min_price'] = minPrice;
      }
    }
    if (searchController.text.trim().isNotEmpty) {
      params['search'] = searchController.text.trim();
    }

    if (maxPriceController.text.trim().isNotEmpty) {
      final maxPrice = double.tryParse(maxPriceController.text.trim());
      if (maxPrice != null) {
        params['max_price'] = maxPrice;
      }
    }
    if (category != null) {
      params['category_id'] = category?.value;
    }

    if (selectedDistance != null && selectedDistance!.isNotEmpty) {
      params['distance'] = selectedDistance;
    }
    if (selectedConditions.isNotEmpty) {
      params['conditions[]'] = selectedConditions;
    }
    if (selectedDate != null && selectedDate!.isNotEmpty) {
      params['date'] = selectedDate;
    }
    if (selectedSeller != null && selectedSeller!.isNotEmpty) {
      params['seller'] = selectedSeller;
    }
    if (selectedDiscount == '0') {
      params['discount'] = 0;
    }
    params['price_drop_only'] = selectedMore.contains('price_drop_only') ? 1 : 0;
    params['saved_only'] = selectedMore.contains('saved_only') ? 1 : 0;
    final data = await garageRepositoryImpl.marketPlace(params);

    data.fold(
      (l) {
        isLoading = false;
        isLoadingMoreMarketPlace = false;
        update([ControllerBuilders.marketPlaceController]);
      },
      (r) {
        if (r.success == true && r.data != null) {
          final responseData = r.data!;
          final responseItems = responseData.items ?? [];
          if (page == 1) {
            marketPlaceData = responseData;
          } else {
            final existingItems = marketPlaceData?.items ?? [];
            marketPlaceData = MarketPlaceData(items: [...existingItems, ...responseItems], pagination: responseData.pagination);
          }
          currentMarketPlacePage = responseData.pagination?.currentPage ?? page;
          lastMarketPlacePage = responseData.pagination?.lastPage ?? page;
          hasMoreMarketPlace = currentMarketPlacePage < lastMarketPlacePage;
        } else {
          if (page == 1) {
            marketPlaceData = r.data;
          }
          hasMoreMarketPlace = false;
        }
        isLoading = false;
        isLoadingMoreMarketPlace = false;
        update([ControllerBuilders.marketPlaceController]);
      },
    );
  }

  Future<void> getMarketPlaceContent() async {
    var data = await garageRepositoryImpl.marketPlaceContent(46820);
    data.fold(
      (l) {
        if (l is ServerFailure) {
          isLoading = false;
          update([ControllerBuilders.marketPlaceController]);
        }
      },
      (r) {
        bool status = r.success ?? false;
        if (status == true) {
          contentData = r.data;
          isLoading = false;
          update([ControllerBuilders.marketPlaceController]);
        } else {
          isLoading = false;
          update([ControllerBuilders.marketPlaceController]);
        }
      },
    );
  }

  Future<void> getMarketPlaceFilters() async {
    var data = await garageRepositoryImpl.marketPlaceFilters(46820);
    data.fold(
      (l) {
        if (l is ServerFailure) {
          isLoading = false;
          update([ControllerBuilders.filterController]);
        }
      },
      (r) {
        bool status = r.success ?? false;
        if (status == true) {
          marketFilters = r.data;
          isLoading = false;
          initializeFilterDefaults();
          update([ControllerBuilders.filterController]);
        } else {
          isLoading = false;
          update([ControllerBuilders.filterController]);
        }
      },
    );
  }

  Future<void> getMyGarage() async {
    isLoading = true;
    update([ControllerBuilders.myGarageController]);
    var data = await garageRepositoryImpl.myGarage();
    data.fold(
          (l) {
        if (l is ServerFailure) {
          isLoading = false;
          update([ControllerBuilders.myGarageController]);
        }
      },
          (r) {
        bool status = r.success ?? false;
        if (status == true) {
          dashboardData = r.data;
          isLoading = false;
          update([ControllerBuilders.myGarageController]);
        } else {
          isLoading = false;
          update([ControllerBuilders.myGarageController]);
        }
      },
    );
  }

  Future<void> getMyGarageAI() async {
    isLoading = true;
    update([ControllerBuilders.myGarageController]);
    var data = await garageRepositoryImpl.myGarageAI();
    data.fold(
          (l) {
        if (l is ServerFailure) {
          isLoading = false;
          update([ControllerBuilders.myGarageController]);
        }
      },
          (r) {
        bool status = r.success ?? false;
        if (status == true) {
          aiGarageData = r.data;
          isLoading = false;
          update([ControllerBuilders.myGarageController]);
        } else {
          isLoading = false;
          update([ControllerBuilders.myGarageController]);
        }
      },
    );
  }
}
