import 'package:tv_app/repository/repository.dart';
import 'package:tv_app/models/Channel.dart';
import 'package:tv_app/models/Show.dart';
import 'package:tv_app/models/Serial.dart';
import 'dart:async';

class EpgRepository extends Repository{
  int _epgStartTime;
  int _epgEndTime;

  int _getEpgStartTime() {
    if (_epgStartTime == null) {
      _epgStartTime = DateTime.now().millisecondsSinceEpoch;
    }
    return _epgStartTime;
  }

  int _getEpgEndTime() {
    if (_epgEndTime == null) {
      _epgEndTime = DateTime.now().millisecondsSinceEpoch;
    }
    return _epgEndTime;
  }

  Future<List<Channel>> channels() async {
    final String url = 'epg/channels/';
    var responseJson;
    List<Channel> channelList = [];

    responseJson = await provider.get(url);

    if (responseJson['data'] != null) {
      _epgStartTime = responseJson['data']['epgStartTime'];
      _epgEndTime = responseJson['data']['epgEndTime'];

      if (responseJson['data']['channels'] != null) {
        for (var channel in responseJson['data']['channels']) {
          channelList.add(channelFromJson(channel));
        }
      }
    }
    return channelList;
  }

  Future<Map<String, List>> channelGroups() async {
    final String url = 'epg/channels/groups/';
    var responseJson;
    Map<String, List> outResult = {'user': [], 'platform': []};

    responseJson = await provider.get(url);
    if (responseJson['user'] != null) {
      outResult['user'] = responseJson['user'];
    }

    if (responseJson['other'] != null) {
      outResult['platform'] = responseJson['other'];
    }

    return outResult;
  }

  Future<Map<int, List<Show>>> epgOnTV() async {
    final String url = 'epg/ontv/';
    var responseJson;
    List<Show> showList = [];
    Map<int, List<Show>> outMap = {};

    responseJson = await provider.get(url);
    for (var channel in responseJson['data']) {
      showList = [];
      for (var show in channel['shows']) {
        showList.add(showFromJson(show, channel));
      }
      outMap[int.parse(channel['channelId'])] = showList;
    }
    return outMap;
  }

  ///
  /// Max showNum is 5
  ///
  Future<Map<int, List<Show>>> ottOnTV({int showNum = 4}) async {
    final String url = 'epg/ott/ontv/$showNum/';
    var responseJson;
    List<Show> showList = [];
    Map<int, List<Show>> outMap = {};

    responseJson = await provider.get(url);
    for (var channel in responseJson['data']) {
      showList = [];
      for (var show in channel['shows']) {
        showList.add(showFromJson(show, channel));
      }
      outMap[int.parse(channel['channelId'])] = showList;
    }
    return outMap;
  }

  Future<Map<int, List<Show>>> shows({List<int> channels, int startDate, int endDate}) async {
    final String url = 'epg/shows/';
    var responseJson;
    List<Show> showList = [];
    Map<int, List<Show>> outMap = {};

    ///
    /// Default values - empty list
    ///
    if (channels == null) {
      channels = [];
    }

    ///
    /// Default values - startTime
    ///
    if (startDate == null && _epgStartTime != null) {
      startDate = _getEpgStartTime();
    }

    ///
    /// Default values - endTime
    ///
    if (endDate == null && _epgEndTime != null) {
      endDate = _getEpgEndTime();
    }

    final Map<String, dynamic> _payload = {
      'channelList' : channels,
      'startDate' : startDate,
      'endDate' : endDate,
    };

    responseJson = await provider.post(url, _payload);
    for (var channel in responseJson['data']) {
      showList = [];
      for (var show in channel['shows']) {
        showList.add(showFromJson(show, channel));
      }
      outMap[int.parse(channel['channelId'])] = showList;
    }
    return outMap;
  }

  Future<Show> show(int showId) async {
    final String url = 'epg/show/$showId/';
    var responseJson;
    responseJson = await provider.get(url);

    return showFromJson(responseJson['show'], responseJson['channel']);
  }

  Future<Serial> serial(int serialId)  async {
    final String url = 'epg/serial/$serialId/';
    var responseJson;
    responseJson = await provider.get(url);

    return serialFromJson(responseJson['serial'], responseJson['channel'], responseJson['episodes']);

  }

  void setRecording(int showId) {
    final String url = 'epg/recording/$showId/';
    provider.put(url);
  }

  void removeRecording(int showId) {
    final String url = 'epg/recording/$showId/';
    provider.delete(url);
  }

  void setSerialRecording(int serialId) {
    final String url = 'epg/serial_recording/$serialId/';
    provider.put(url);
  }

  void removeSerialRecording(int serialId) {
    final String url = 'epg/serial_recording/$serialId/';
    provider.delete(url);
  }

  void setReminder(int showId) {
    int timeBefore = 0;
    final String url = 'epg/reminder/$showId/time/$timeBefore/';
    provider.put(url);
  }

  void removeReminder(int showId) {
    final String url = 'epg/reminder/$showId/';
    provider.delete(url);
  }

  void setBookmark(int showId) {
    int timeBefore = 0;
    final String url = 'epg/bookmark/$showId/$timeBefore/';
    provider.put(url);
  }

  void removeBookmark(int showId) {
    final String url = 'epg/bookmark/$showId/';
    provider.delete(url);
  }

}