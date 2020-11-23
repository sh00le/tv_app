import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tv_app/models/DefVodContent.dart';
import 'package:tv_app/models/DefVodSeason.dart';
import 'package:tv_app/models/DefVodSerial.dart';
import 'package:tv_app/models/VodEpisode.dart';
import 'package:tv_app/services/repository_service.dart';
import 'package:tv_app/widgets/tv_infinity_scroll.dart';


enum Widgets{
  actions,
  content,
  seasons,
  episodes
}

class Season {
  FocusNode focusNode;
  String title;
  List<VodEpisode> episodes;
}

class Action {
  String id;
  String title;
}

class ActionStatus {
  static String _id = 'actions';
  FocusScopeNode focusNode = FocusScopeNode();
  String get id => _id;
  List<Action> actions = [];
}

class ContentStatus {
  static String _id = 'content';
  FocusScopeNode focusNode = FocusScopeNode();
  String get id => _id;
}

class SeasonsStatus {
  static String _id = 'seasons';
  FocusScopeNode focusNode = FocusScopeNode();
  List<Season> seasons = [];
  String get id => _id;
  bool hadFocus = false;
}

class EpisodeStatus {
  static String _id = 'episodes';
  FocusScopeNode focusNode = FocusScopeNode();
  String get id => _id;
  List<DefVodContent> data = [];
}

class SerialDetailsStatus {
  static String _id = 'serial';
  final ActionStatus action = ActionStatus();
  final ContentStatus content = ContentStatus();
  final SeasonsStatus season = SeasonsStatus();
  final EpisodeStatus episode = EpisodeStatus();
  String get id => _id;

  SerialDetailsStatus.init() {
    action.focusNode.requestFocus();
    content.focusNode.unfocus();
    season.focusNode.unfocus();
    episode.focusNode.unfocus();
  }
}

class VodSerialDetailsPageController extends GetxController {
  final RepositoryService _repositoryService = Get.find<RepositoryService>();
  final SerialDetailsStatus serialStatus = SerialDetailsStatus.init();
  TVInfiniteScrollController _episodeListController = TVInfiniteScrollController();
  DefVodSerial vodSerial;

  TVInfiniteScrollController get episodeListController => _episodeListController;

  void init() {
    // Prepare seasons
    prepareSeasons(vodSerial.seasons);

    // Prepare Content actions
    prepareActions();


    // Attach keyboard listener
    serialStatus.action.focusNode.attach(Get.context, onKey: _handleKeyEvent);
    serialStatus.season.focusNode.attach(Get.context, onKey: _handleKeyEvent);

    update([serialStatus.id]);
  }

  bool _handleKeyEvent(FocusNode node, RawKeyEvent event) {

    if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        if (node == serialStatus.action.focusNode) {
            serialStatus.action.focusNode.unfocus();
            serialStatus.season.focusNode.requestFocus();
            if (serialStatus.season.hadFocus == false) {
              serialStatus.season.seasons.first.focusNode.requestFocus();
              serialStatus.season.hadFocus = true;
            }

        }
      }
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        debugPrint('111');
        if (node == serialStatus.season.focusNode) {
          debugPrint('222');
          serialStatus.season.focusNode.unfocus();
          serialStatus.action.focusNode.requestFocus();
        }
      }
    }

    return false;
  }

  void _handleFocusChange() {
    debugPrint('focus changed');
    serialStatus.season.seasons.forEach((item) {
      if (item.focusNode.hasFocus) {
        serialStatus.episode.data = item.episodes;
      }
    });
    update([serialStatus.episode.id]);
    // debugPrint('${_focusedSeason.title}');
  }

  void prepareActions() {
    debugPrint('prepareActions');
    serialStatus.action.actions = [];
    Action _addToFavorites = Action();
    _addToFavorites.id = 'addToFavoroites';
    _addToFavorites.title = 'Add To Favorites';
    serialStatus.action.actions.add(_addToFavorites);

    Action _like = Action();
    _like.id = 'like';
    _like.title = 'Like';
    serialStatus.action.actions.add(_like);

    Action _dislike = Action();
    _dislike.id = 'dislike';
    _dislike.title = 'Dislike';
    serialStatus.action.actions.add(_dislike);

    Action _similar = Action();
    _similar.id = 'similar';
    _similar.title = 'Similar Content';
    serialStatus.action.actions.add(_similar);

    Action _back = Action();
    _back.id = 'back';
    _back.title = 'Back';
    serialStatus.action.actions.add(_back);

  }

  void prepareSeasons(List<DefVodSeason> inSeasons) {
    List<Season> seasons = [];
    inSeasons.forEach((item) {
      Season season = Season();
      season.focusNode = FocusNode();
      season.focusNode.addListener(_handleFocusChange);
      season.title = item.title;
      season.episodes = item.episodes;
      seasons.add(season);
    });

    serialStatus.season.seasons = seasons;
  }


  Future getSerial(Map<String, dynamic> serialInfo) async {
    var repository;

    debugPrint('serialInfo: $serialInfo');

    int serialId = int.parse(serialInfo['serialId']);
    if (serialInfo['type'] == 'vod') {
      repository = _repositoryService.getVod();
    } else {
      repository = _repositoryService.getSvod();
    }

    if (serialId != -1) {
      vodSerial = await repository.serial(serialId);

      init();

      debugPrint('${vodSerial.seasons[0].title}');

    }
  }
}