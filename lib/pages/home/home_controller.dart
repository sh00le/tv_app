import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
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
  TVInfiniteScrollController _recoLIstController = TVInfiniteScrollController();
  TVInfiniteScrollController _focusedListController;
  final HomeStatus homeStatus = HomeStatus.init();
  bool _isScrolling = false;
  var items = [];
  int _cnt = 0;


  TVInfiniteScrollController get menuController => _menuListController;
  TVInfiniteScrollController get recoController => _recoLIstController;

  void handleKeyEvent(RawKeyEvent event) {
    // debugPrint('handleKeyEvent $event');
    if (_focusedListController == null) {
      _menuListController.setName('menu');
      _recoLIstController.setName('reco');
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
      if (_isScrolling == false && event.logicalKey == LogicalKeyboardKey.arrowUp) {
        if (homeStatus.menu.inFocus && items.length > 0) {
          homeStatus.menu.inFocus = false;
          homeStatus.recommendations.inFocus = true;
          homeStatus.details.widgetStatus = Status.visible;
          _focusedListController = _recoLIstController;
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

  Future onMenuSelect(String recommendations) async {
    debugPrint('onMenuSelect 1');
    String url;
    String method = 'get';
    String payload = '';
    Response httpResponse;
    items = [];
    _recoLIstController = null;

    switch (recommendations) {
      case 'all':
        url = 'https://player.maxtvtogo.tportal.hr:8086/OTT4Proxy/proxy/recommendation/user/all';
        break;
      case 'epg':
        url = 'https://player.maxtvtogo.tportal.hr:8086/OTT4Proxy/proxy/recommendation/epg';
        break;
      case 'npvr':
        url = 'https://player.maxtvtogo.tportal.hr:8086/OTT4Proxy/proxy/recommendation/npvr';
        break;
      case 'vod':
        method = 'post';
        payload = '{"categoryList": ["0"]}';
        url = 'https://player.maxtvtogo.tportal.hr:8086/OTT4Proxy/proxy/recommendation/vod';
        break;
      case 'svod':
        method = 'post';
        payload = '{"categoryList": ["0"]}';
        url = 'https://player.maxtvtogo.tportal.hr:8086/OTT4Proxy/proxy/recommendation/svod';
        break;
      case 'ppv':
        url = 'https://player.maxtvtogo.tportal.hr:8086/OTT4Proxy/proxy/recommendation/ppv';
        break;
    }

    if (url != null) {
      if (method == 'get') {
        httpResponse = await http.get(url);
      }
      if (method == 'post') {
        httpResponse = await http.post(url,
            headers: {"Content-Type": "application/json"},
            body: payload
        );
      }

      _recoLIstController = TVInfiniteScrollController();
      homeStatus.recommendations.widgetStatus = Status.visible;
      String body = utf8.decode(httpResponse.bodyBytes);
      var decoded = jsonDecode(body);

      items = decoded["list"][0]["recommendations"];
      homeStatus.details.data = items[0];
      update([homeStatus.recommendations.id]);
    }
  }
}