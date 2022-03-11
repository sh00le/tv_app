import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

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

enum Widgets { menu, recommendations, contentInfo }

enum Status { loading, hidden, visible }

class MenuStatus {
  static String _id = 'menu';
  FocusScopeNode focusScopeNode = FocusScopeNode();
  FocusAttachment? attachment;
  String get id => _id;
}

class RecommendationsStatus {
  static String _id = 'recommendations';
  FocusScopeNode focusScopeNode = FocusScopeNode();
  FocusAttachment? attachment;
  Status? widgetStatus;
  List? data;
  String get id => _id;
}

class DetailsStatus {
  static String _id = 'details';
  FocusScopeNode focusScopeNode = FocusScopeNode();
  FocusAttachment? attachment;
  Status? widgetStatus;
  var data;
  String get id => _id;
}

class HomeStatus {
  final MenuStatus menu = MenuStatus();
  final RecommendationsStatus recommendations = RecommendationsStatus();
  final DetailsStatus details = DetailsStatus();

  HomeStatus.init() {
    recommendations.widgetStatus = Status.hidden;
    recommendations.data = [];
    details.widgetStatus = Status.hidden;
    details.data = null;
  }
}

class HomeController extends GetxController {
  final TVInfiniteScrollController _menuListController =
      TVInfiniteScrollController();
  TVInfiniteScrollController? _recoListController =
      TVInfiniteScrollController();

  final RepositoryService _repositoryService = Get.find<RepositoryService>();
  final HomeStatus homeStatus = HomeStatus.init();
  bool _isScrolling = false;
  Menu? _selectedMenuItem;

  var items = [];

  void init(BuildContext context) {
    debugPrint('INIT!!!');
    homeStatus.menu.attachment =
        homeStatus.menu.focusScopeNode.attach(context, onKey: _handleKeyEvent);
    homeStatus.recommendations.attachment = homeStatus
        .recommendations.focusScopeNode
        .attach(context, onKey: _handleKeyEvent);
    homeStatus.details.attachment = homeStatus.details.focusScopeNode
        .attach(context, onKey: _handleKeyEvent);
    homeStatus.menu.focusScopeNode.requestFocus();

    // debugPrint('homeStatus.menu.focusScopeNode.hasFocus ${homeStatus.menu.focusScopeNode.hasFocus}');
  }

  KeyEventResult _handleKeyEvent(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (node == homeStatus.recommendations.focusScopeNode) {
        if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          _recoListController?.prevItem();
        }
        if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          _recoListController?.nextItem();
        }

        if (event.logicalKey == LogicalKeyboardKey.select ||
            event.logicalKey == LogicalKeyboardKey.enter) {
          _handleNavigation();
        }
      }
      if (node == homeStatus.menu.focusScopeNode) {
        if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          _menuListController.prevItem();
        }
        if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          _menuListController.nextItem();
        }
      }
    }

    if (_isScrolling == false && event is RawKeyUpEvent) {
      if (node == homeStatus.menu.focusScopeNode) {
        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          homeStatus.menu.focusScopeNode.unfocus();
          homeStatus.recommendations.focusScopeNode.requestFocus();

          homeStatus.details.widgetStatus = Status.visible;
          update([
            homeStatus.menu.id,
            homeStatus.recommendations.id,
            homeStatus.details.id
          ]);
        }
      }

      if (node == homeStatus.recommendations.focusScopeNode) {
        // if (event.logicalKey == LogicalKeyboardKey.select || event.logicalKey == LogicalKeyboardKey.enter) {
        //   _handleNavigation();
        // }

        if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          homeStatus.recommendations.focusScopeNode.unfocus();
          homeStatus.menu.focusScopeNode.requestFocus();

          homeStatus.details.widgetStatus = Status.hidden;
          update([
            homeStatus.menu.id,
            homeStatus.recommendations.id,
            homeStatus.details.id
          ]);
        }
      }
    }

    return KeyEventResult.handled;
  }

  TVInfiniteScrollController get menuController => _menuListController;
  TVInfiniteScrollController get recoController => _recoListController!;

  void _handleNavigation() {
    if (homeStatus.details.data is VodMovie) {
      Get.toNamed('/vod/movie',
          arguments: {'movieId': homeStatus.details.data.id, 'type': 'vod'});
    } else if (homeStatus.details.data is VodSerial) {
      Get.toNamed('/vod/serial',
          arguments: {'serialId': homeStatus.details.data.id, 'type': 'vod'});
    } else if (homeStatus.details.data is VodEpisode) {
      Get.toNamed('/vod/episode',
          arguments: {'movieId': homeStatus.details.data.id, 'type': 'vod'});
    } else if (homeStatus.details.data is SvodMovie) {
      Get.toNamed('/svod/movie',
          arguments: {'movieId': homeStatus.details.data.id, 'type': 'svod'});
    } else if (homeStatus.details.data is SvodSerial) {
      Get.toNamed('/svod/serial',
          arguments: {'serialId': homeStatus.details.data.id, 'type': 'svod'});
    } else if (homeStatus.details.data is SvodEpisode) {
      Get.toNamed('/svod/episode',
          arguments: {'movieId': homeStatus.details.data.id, 'type': 'svod'});
    } else if (homeStatus.details.data is Show) {
      Get.toNamed('/epg/show', arguments: homeStatus.details.data.showId);
    }
    // Future.delayed(Duration(milliseconds: 150), () {
    //   homeStatus.recommendations.focusScopeNode.requestFocus();
    // });
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
    if (_selectedMenuItem != menuItem) {
      _recoListController = null;
      homeStatus.recommendations.data = [];
      update([homeStatus.recommendations.id]);
      await _getRecommendations(menuItem);
    }
    _recoListController = TVInfiniteScrollController();
    homeStatus.recommendations.widgetStatus = Status.visible;

    update([homeStatus.recommendations.id]);
  }

  Future<void> _getRecommendations(Menu menuItem) async {
    RecommendationRepository _recoRepository =
        _repositoryService.getRecommendation();
    List<Recommendation>? _recommendations;

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

    if (homeStatus.recommendations.data != null &&
        homeStatus.recommendations.data!.isNotEmpty) {
      homeStatus.details.data = homeStatus.recommendations.data!.first;
    } else {
      homeStatus.details.data = null;
    }
  }
}
