import 'package:tv_app/models/Recommendation.dart';
import 'package:tv_app/repository/repository.dart';
import 'dart:async';

class RecommendationRepository extends Repository {
  List<Recommendation> _prepareRecoResponse(List<dynamic> recoJson) {
    List<Recommendation> output = [];
    for (var recoList in recoJson) {
      output.add(Recommendation.fromJson(recoList));
    }
    return output;
  }

  Future<List<Recommendation>?> _getRecoResponse(String url) async {
    var responseJson;
    responseJson = await provider.get(url);

    if (responseJson['list'] != null) {
      return _prepareRecoResponse(responseJson['list']);
    } else {
      return null;
    }
  }

  Future<List<Recommendation>?> epgOnTV() async {
    final String url = 'recommendation/epg/ontv/';
    return _getRecoResponse(url);
  }

  Future<List<Recommendation>?> epg() async {
    final String url = 'recommendation/epg/';
    return _getRecoResponse(url);
  }

  Future<List<Recommendation>?> npvr() async {
    final String url = 'recommendation/npvr/';
    return _getRecoResponse(url);
  }

  Future<List<Recommendation>?> ppv() async {
    final String url = 'recommendation/ppv/';
    return _getRecoResponse(url);
  }

  Future<List<Recommendation>?> editorial() async {
    final String url = 'recommendation/editorial/';
    return _getRecoResponse(url);
  }

  Future<List<Recommendation>?> newContent() async {
    final String url = 'recommendation/new-content/';
    return _getRecoResponse(url);
  }

  Future<List<Recommendation>?> popularContent() async {
    final String url = 'recommendation/popular-content/';
    return _getRecoResponse(url);
  }

  Future<List<Recommendation>?> similarEpgContent(int contentId) async {
    final String url = 'recommendation/epg/show/$contentId/';
    return _getRecoResponse(url);
  }

  Future<List<Recommendation>?> similarVodContent(int contentId) async {
    final String url = 'recommendation/vod/movie/$contentId/';
    return _getRecoResponse(url);
  }

  Future<List<Recommendation>?> similarSvodContent(int contentId) async {
    final String url = 'recommendation/svod/movie/$contentId/';
    return _getRecoResponse(url);
  }

  Future<List<Recommendation>?> similarSvodContentNextEpisode(
      int contentId) async {
    final String url = 'recommendation/svod/movie/$contentId/next-episode/';
    return _getRecoResponse(url);
  }

  Future<List<Recommendation>?> svodContentNextEpisode(int contentId) async {
    final String url = 'recommendation/svod/next-episode/$contentId/';
    return _getRecoResponse(url);
  }

  Future<List<Recommendation>?> becauseYouWatched() async {
    final String url = 'recommendation/because-you-watched/';
    return _getRecoResponse(url);
  }

  Future<List<Recommendation>?> userAll() async {
    final String url = 'recommendation/user/all/';
    return _getRecoResponse(url);
  }

  Future<List<Recommendation>?> userContinueWatching() async {
    final String url = 'recommendation/user/continue-watching/';
    return _getRecoResponse(url);
  }

  Future<List<Recommendation>?> userYouMayLikeThis() async {
    final String url = 'recommendation/other-content/';
    return _getRecoResponse(url);
  }

  Future<List<Recommendation>?> vodCategories(List<String> categories) async {
    final String url = 'recommendation/vod/';
    var responseJson;

    final Map<String, dynamic> _payload = {
      "categoryList": categories,
      "limit": 10
    };

    responseJson = await provider.post(url, _payload);

    if (responseJson['list'] != null) {
      return _prepareRecoResponse(responseJson['list']);
    } else {
      return null;
    }
  }

  Future<List<Recommendation>?> svodCategories(List<String> categories) async {
    final String url = 'recommendation/svod/';
    var responseJson;

    final Map<String, dynamic> _payload = {
      "categoryList": categories,
      "limit": 10
    };

    responseJson = await provider.post(url, _payload);

    if (responseJson['list'] != null) {
      return _prepareRecoResponse(responseJson['list']);
    } else {
      return null;
    }
  }
}
