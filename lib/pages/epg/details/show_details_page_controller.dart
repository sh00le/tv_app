import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tv_app/models/Show.dart';
import 'package:tv_app/repository/epg_repository.dart';
import 'package:tv_app/services/repository_service.dart';

class Action {
  String? id;
  String? title;
}

class ActionStatus {
  static String _id = 'actions';
  FocusScopeNode focusNode = FocusScopeNode();
  FocusAttachment? attachment;
  String get id => _id;
  List<Action> actions = [];
}

class ContentStatus {
  static String _id = 'content';
  FocusScopeNode focusNode = FocusScopeNode();
  String get id => _id;
  var data;
}

class ShowDetailsStatus {
  static String _id = 'show';
  final ActionStatus action = ActionStatus();
  final ContentStatus content = ContentStatus();
  String get id => _id;

  ShowDetailsStatus.init() {
    action.focusNode.requestFocus();
    content.focusNode.unfocus();
  }
}

class ShowDetailsPageController extends GetxController {
  final RepositoryService _repositoryService = Get.find<RepositoryService>();
  final ShowDetailsStatus showDetailsStatus = ShowDetailsStatus.init();
  Show? show;

  void init() {
    // Prepare Content actions
    prepareActions();

    update([showDetailsStatus.id]);
  }

  Future getShow(int showId) async {
    EpgRepository _epgRepository = _repositoryService.getEpg();
    if (showId != -1) {
      show = await _epgRepository.show(showId);
      debugPrint('${show!.title!}');
      update([showDetailsStatus.id]);
    }
  }

  void onActionSubmit(Action action) {
    switch (action.id) {
      case 'back':
        Get.back(result: true);
        break;
      default:
        Get.snackbar(action.title!, '', snackPosition: SnackPosition.BOTTOM);
        break;
    }
  }

  void prepareActions() {
    debugPrint('prepareActions');
    showDetailsStatus.action.actions = [];
    Action _addToFavorites = Action();
    _addToFavorites.id = 'addToFavoroites';
    _addToFavorites.title = 'Add To Favorites';
    showDetailsStatus.action.actions.add(_addToFavorites);

    Action _markAsWatched = Action();
    _markAsWatched.id = 'markAsWatched';
    _markAsWatched.title = 'Mark As Watched';
    showDetailsStatus.action.actions.add(_markAsWatched);

    Action _like = Action();
    _like.id = 'like';
    _like.title = 'Like';
    showDetailsStatus.action.actions.add(_like);

    Action _dislike = Action();
    _dislike.id = 'dislike';
    _dislike.title = 'Dislike';
    showDetailsStatus.action.actions.add(_dislike);

    Action _similar = Action();
    _similar.id = 'similar';
    _similar.title = 'Similar Content';
    showDetailsStatus.action.actions.add(_similar);

    Action _back = Action();
    _back.id = 'back';
    _back.title = 'Back';
    showDetailsStatus.action.actions.add(_back);
  }
}
