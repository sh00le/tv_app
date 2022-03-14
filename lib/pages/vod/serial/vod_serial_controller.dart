import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:tv_app/models/DefVodEpisode.dart';
import 'package:tv_app/models/DefVodSeason.dart';
import 'package:tv_app/models/DefVodSerial.dart';
import 'package:tv_app/models/VodEpisode.dart';
import 'package:tv_app/services/repository_service.dart';
import 'package:tv_app/widgets/tv_infinity_scroll.dart';

enum Widgets { actions, content, seasons, episodes }

class Season {
  FocusNode? focusNode;
  String? title;
  List<DefVodEpisode>? episodes;
}

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

class SeasonsStatus {
  static String _id = 'seasons';
  FocusScopeNode focusNode = FocusScopeNode();
  FocusAttachment? attachment;
  FocusNode? selectedFocusNode;
  List<Season> seasons = [];
  String get id => _id;
  bool hadFocus = false;
}

class EpisodeStatus {
  static String _id = 'episodes';
  FocusScopeNode focusNode = FocusScopeNode();
  FocusAttachment? attachment;
  String get id => _id;
  List<DefVodEpisode> data = [];
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
  TVInfiniteScrollController? _episodeListController =
      TVInfiniteScrollController();
  DefVodSerial? vodSerial;
  Timer? _seasonEpisodesTimer;

  TVInfiniteScrollController? get episodeListController =>
      _episodeListController;

  void init(Map<String, dynamic> serialInfo) async {
    await _getSerial(serialInfo);
    serialStatus.content.data = vodSerial;

    // Prepare seasons
    prepareSeasons(vodSerial?.seasons);

    // Prepare Content actions
    prepareActions();

    // Attach keyboard listener
    serialStatus.action.attachment = serialStatus.action.focusNode
        .attach(Get.context, onKey: _handleKeyEvent);
    serialStatus.season.attachment = serialStatus.season.focusNode
        .attach(Get.context, onKey: _handleKeyEvent);
    serialStatus.episode.attachment = serialStatus.episode.focusNode
        .attach(Get.context, onKey: _handleKeyEvent);

    update([serialStatus.id]);
  }

  KeyEventResult _handleKeyEvent(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (node == serialStatus.episode.focusNode) {
        if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          episodeListController!.nextItem();
        }
        if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          episodeListController!.prevItem();
        }
        if (event.logicalKey == LogicalKeyboardKey.select ||
            event.logicalKey == LogicalKeyboardKey.enter) {
          onEpisodeSubmit(serialStatus.content.data);
        }
      }
    }
    if (event is RawKeyUpEvent) {
      // if (event.logicalKey == LogicalKeyboardKey.select || event.logicalKey == LogicalKeyboardKey.enter) {
      //   if (node == serialStatus.episode.focusNode) {
      //     onEpisodeSubmit(serialStatus.content.data);
      //   }
      // }

      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        if (node == serialStatus.action.focusNode) {
          serialStatus.action.focusNode.unfocus();
          serialStatus.season.focusNode.requestFocus();
          serialStatus.season.attachment?.reparent();

          if (serialStatus.season.hadFocus == false) {
            serialStatus.season.seasons.first.focusNode?.requestFocus();
            serialStatus.season.hadFocus = true;
          }
        }
      }

      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        if (node == serialStatus.season.focusNode) {
          serialStatus.season.focusNode.unfocus();
          serialStatus.action.focusNode.requestFocus();
          serialStatus.action.attachment?.reparent();
          serialStatus.season.selectedFocusNode = null;
          serialStatus.episode.data = [];
          serialStatus.content.data = vodSerial;

          update([
            serialStatus.action.id,
            serialStatus.season.id,
            serialStatus.episode.id,
            serialStatus.content.id
          ]);
        }
        if (node == serialStatus.episode.focusNode) {
          serialStatus.episode.focusNode.unfocus();
          serialStatus.season.focusNode.requestFocus();
          serialStatus.season.attachment?.reparent();
          update([serialStatus.episode.id, serialStatus.season.id]);
        }
      }

      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        if (node == serialStatus.season.focusNode) {
          serialStatus.season.focusNode.unfocus();
          serialStatus.episode.focusNode.requestFocus();
          serialStatus.episode.attachment?.reparent();
          serialStatus.content.data = serialStatus.episode.data.first;
          update([
            serialStatus.episode.id,
            serialStatus.season.id,
            serialStatus.content.id
          ]);
        }
      }
    }

    return KeyEventResult.handled;
  }

  void _handleFocusChange() {
    if (serialStatus.season.focusNode.hasFocus) {
      serialStatus.season.seasons.forEach((item) {
        if (item.focusNode!.hasFocus) {
          if (item.focusNode != serialStatus.season.selectedFocusNode) {
            serialStatus.season.selectedFocusNode = item.focusNode;
            _episodeListController = null;
            serialStatus.episode.data = [];

            update([serialStatus.episode.id]);

            if (_seasonEpisodesTimer != null) {
              if (_seasonEpisodesTimer!.isActive) {
                _seasonEpisodesTimer!.cancel();
              }
            }

            _seasonEpisodesTimer = Timer(Duration(milliseconds: 300), () {
              _episodeListController = TVInfiniteScrollController();
              serialStatus.episode.data = item.episodes!;
              update([serialStatus.episode.id]);
            });
          }
        }
      });
    }
  }

  void prepareActions() {
    debugPrint('prepareActions');
    serialStatus.action.actions = [];
    Action _addToFavorites = Action();
    _addToFavorites.id = 'addToFavoroites';
    _addToFavorites.title = 'Add To Favorites';
    serialStatus.action.actions.add(_addToFavorites);

    Action _markAsWatched = Action();
    _markAsWatched.id = 'markAsWatched';
    _markAsWatched.title = 'Mark As Watched';
    serialStatus.action.actions.add(_markAsWatched);

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

  void prepareSeasons(List<DefVodSeason>? inSeasons) {
    List<Season> seasons = [];
    inSeasons!.forEach((item) {
      Season season = Season();
      season.focusNode = FocusNode();
      season.focusNode?.addListener(_handleFocusChange);
      season.title = item.title;
      season.episodes = item.episodes;
      seasons.add(season);
    });

    serialStatus.season.seasons = seasons;
  }

  void onEpisodeSelected(DefVodEpisode episode) {
    if (serialStatus.episode.focusNode.hasFocus) {
      serialStatus.content.data = episode;
      debugPrint('${episode.title}');
      update([serialStatus.content.id]);
    }
  }

  void onEpisodeSubmit(VodEpisode episode) {
    Get.toNamed('/svod/movie',
        arguments: {'movieId': episode.id, 'type': 'svod'});
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

  Future _getSerial(Map<String, dynamic> serialInfo) async {
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

      debugPrint('${vodSerial?.seasons![0].title}');
    }
  }
}
