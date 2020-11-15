import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:tv_app/models/Menu.dart';
import 'package:tv_app/models/Recommendation.dart';
import 'package:tv_app/models/Show.dart';
import 'package:tv_app/models/SvodEpisode.dart';
import 'package:tv_app/models/SvodMovie.dart';
import 'package:tv_app/models/SvodSerial.dart';
import 'package:tv_app/models/VodEpisode.dart';
import 'package:tv_app/models/VodMovie.dart';
import 'package:tv_app/models/VodSerial.dart';
import 'package:tv_app/repository/recommendation_repository.dart';
import 'package:tv_app/services/repository_service.dart';
import 'package:tv_app/widgets/tv_infinity_scroll.dart';

enum Widgets{
  menu,
  recommendations,
  contentInfo
}

enum Status{
  loading,
  hidden,
  visible
}

class MenuStatus {
  static String _id = 'menu';
  bool inFocus;
  String get id => _id;
}

class RecommendationsStatus{
  static String _id = 'recommendations';
  bool inFocus;
  Status widgetStatus;
  List data;
  String get id => _id;
}

class DetailsStatus{
  static String _id = 'details';
  bool inFocus;
  Status widgetStatus;
  var data;
  String get id => _id;
}

class HomeStatus {
  final MenuStatus menu = MenuStatus();
  final RecommendationsStatus recommendations = RecommendationsStatus();
  final DetailsStatus details = DetailsStatus();


  HomeStatus.init(){
    menu.inFocus = true;
    recommendations.inFocus = false;
    recommendations.widgetStatus = Status.hidden;
    recommendations.data = [];
    details.inFocus = false;
    details.widgetStatus = Status.hidden;
    details.data = null;
  }
}

class HomeController extends GetxController {
  final TVInfiniteScrollController _menuListController = TVInfiniteScrollController();
  TVInfiniteScrollController _recoListController = TVInfiniteScrollController();
  TVInfiniteScrollController _focusedListController;

  final RepositoryService _repositoryService = Get.find<RepositoryService>();
  final HomeStatus homeStatus = HomeStatus.init();
  bool _isScrolling = false;
  String _recoCategory;
  Menu _selectedMenuItem;

  var items = [];
  int _cnt = 0;


  TVInfiniteScrollController get menuController => _menuListController;
  TVInfiniteScrollController get recoController => _recoListController;

  void handleKeyEvent(RawKeyEvent event) {
    // debugPrint('handleKeyEvent ${event.logicalKey}');
    if (_focusedListController == null) {
      _menuListController.setName('menu');
      _recoListController.setName('reco');
      _focusedListController = _menuListController;
    }

    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        _focusedListController.prevItem();
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        _focusedListController.nextItem();
      }
    }

    if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.select || event.logicalKey == LogicalKeyboardKey.enter) {
        debugPrint('SELECT BUTTON');
        if (homeStatus.details.data is VodMovie) {
          debugPrint('VodMovie');
        } else if (homeStatus.details.data is VodSerial) {
          debugPrint('VodSerial');
        } else if (homeStatus.details.data is VodEpisode) {
          debugPrint('VodEpisode');
        } else if (homeStatus.details.data is SvodMovie) {
          debugPrint('SVODMovie');
        } else if (homeStatus.details.data is SvodSerial) {
          debugPrint('SVODSerial');
        } else if (homeStatus.details.data is SvodEpisode) {
          debugPrint('SVODEpisode');
        } else if (homeStatus.details.data is Show) {
          Get.toNamed('/epg/show', arguments: homeStatus.details.data.showId);
        }
        // Get.toNamed('/test');
      }

      if (_isScrolling == false && event.logicalKey == LogicalKeyboardKey.arrowUp) {
        if (homeStatus.menu.inFocus && homeStatus.recommendations.data.length > 0) {
          homeStatus.menu.inFocus = false;
          homeStatus.recommendations.inFocus = true;
          homeStatus.details.widgetStatus = Status.visible;
          _focusedListController = _recoListController;
          update([homeStatus.menu.id, homeStatus.recommendations.id, homeStatus.details.id]);
        }
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        if (homeStatus.recommendations.inFocus) {
          homeStatus.recommendations.inFocus = false;
          homeStatus.menu.inFocus = true;
          homeStatus.details.widgetStatus = Status.hidden;
          _focusedListController = _menuListController;
          update([homeStatus.menu.id, homeStatus.recommendations.id, homeStatus.details.id]);
        }
      }
    }
  }

  void onScrollEnd() {
    _isScrolling = false;
  }

  void onRecommendationScrollStart() {
    _isScrolling = true;
    homeStatus.details.widgetStatus = Status.hidden;
    update([homeStatus.details.id]);
  }

  void onRecommendationSelect(recommendation) {
    homeStatus.details.data = recommendation;
    homeStatus.details.widgetStatus = Status.visible;
    update([homeStatus.details.id]);
  }

  void onMenuScrollStart() {
    _isScrolling = true;
    homeStatus.recommendations.widgetStatus = Status.hidden;
    update([homeStatus.recommendations.id]);
  }

  Future onMenuSelect(Menu menuItem) async {
    _recoListController = null;
    homeStatus.recommendations.data = [];
    update([homeStatus.recommendations.id]);
    await _getRecommendations(menuItem);
    _recoListController = TVInfiniteScrollController();
    homeStatus.recommendations.widgetStatus = Status.visible;
    update([homeStatus.recommendations.id]);
  }

  Future<void> _getRecommendations(Menu menuItem) async {
    RecommendationRepository _recoRepository = _repositoryService.getRecommendation();
    List<Recommendation> _recommendations;

    if (_selectedMenuItem != menuItem) {
      _selectedMenuItem = menuItem;
      switch (menuItem.recommendation) {
        case 'all':
          _recommendations = await _recoRepository.userAll();
          break;
        case 'epg':
          _recommendations = await _recoRepository.epg();
          break;
        case 'vod':
          _recommendations = await _recoRepository.vodCategories(['0']);
          break;
        case 'svod':
          _recommendations = await _recoRepository.svodCategories(['0']);
          break;
        case 'npvr':
          _recommendations = await _recoRepository.npvr();
          break;
        case 'ppv':
          _recommendations = await _recoRepository.ppv();
          break;
        default:
          _recommendations = null;
          break;
      }
    }

    if (_recommendations != null && _recommendations.isNotEmpty) {
      homeStatus.recommendations.data = _recommendations[0].recommendations;
    } else {
      homeStatus.recommendations.data = [];
    }

    if (homeStatus.recommendations.data != null && homeStatus.recommendations.data.isNotEmpty) {
      homeStatus.details.data = homeStatus.recommendations.data.first;
    } else {
      homeStatus.details.data = null;
    }

  }
}