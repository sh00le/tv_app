import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:tv_app/services/repository_service.dart';
import 'package:flutter/material.dart';

class Action {
  String id;
  String title;
}

class ActionStatus {
  static String _id = 'actions';
  FocusScopeNode focusNode = FocusScopeNode();
  FocusAttachment attachment;
  String get id => _id;
  List<Action> actions = [];
}

class ContentStatus {
  static String _id = 'content';
  FocusScopeNode focusNode = FocusScopeNode();
  String get id => _id;
  var data;
}


class MovieDetailStatus {
  static String _id = 'movie';
  final ActionStatus action = ActionStatus();
  final ContentStatus content = ContentStatus();
  String get id => _id;

  MovieDetailStatus.init() {
    action.focusNode.requestFocus();
    content.focusNode.unfocus();
  }
}


class VodMovieDetailsPageController extends GetxController {
  final RepositoryService _repositoryService = Get.find<RepositoryService>();
  final MovieDetailStatus movieDetailsStatus = MovieDetailStatus.init();
  var vodMovie;

  void init() {

    // Prepare Content actions
    prepareActions();

    update([movieDetailsStatus.id]);
  }

  Future getMovie(Map<String, dynamic> movieInfo) async {
    var repository;
    int movieId = int.parse(movieInfo['movieId']);
    if (movieInfo['type'] == 'vod') {
      repository = _repositoryService.getVod();
    } else {
      repository = _repositoryService.getSvod();
    }

    if (movieId != -1) {
      vodMovie = await repository.movie(movieId);
      debugPrint('${vodMovie.title}');
      update([movieDetailsStatus.id]);
    }
  }

  void onActionSubmit(Action action) {
    switch(action.id) {
      case 'back':
        Get.back(result: true);
        break;
      default:
        Get.snackbar(action.title, '', snackPosition: SnackPosition.BOTTOM);
        break;
    }
  }


  void prepareActions() {
    debugPrint('prepareActions');
    movieDetailsStatus.action.actions = [];
    Action _addToFavorites = Action();
    _addToFavorites.id = 'addToFavoroites';
    _addToFavorites.title = 'Add To Favorites';
    movieDetailsStatus.action.actions.add(_addToFavorites);

    Action _markAsWatched = Action();
    _markAsWatched.id = 'markAsWatched';
    _markAsWatched.title = 'Mark As Watched';
    movieDetailsStatus.action.actions.add(_markAsWatched);

    Action _like = Action();
    _like.id = 'like';
    _like.title = 'Like';
    movieDetailsStatus.action.actions.add(_like);

    Action _dislike = Action();
    _dislike.id = 'dislike';
    _dislike.title = 'Dislike';
    movieDetailsStatus.action.actions.add(_dislike);

    Action _similar = Action();
    _similar.id = 'similar';
    _similar.title = 'Similar Content';
    movieDetailsStatus.action.actions.add(_similar);

    Action _back = Action();
    _back.id = 'back';
    _back.title = 'Back';
    movieDetailsStatus.action.actions.add(_back);

  }
}
