import 'package:flutter/foundation.dart';
import 'package:tv_app/network/api_provider.dart';
import 'package:tv_app/models/Show.dart';
import 'package:tv_app/models/Channel.dart';
import 'package:tv_app/models/Serial.dart';
import 'package:tv_app/models/VodMovie.dart';
import 'package:tv_app/models/VodSerial.dart';
import 'package:tv_app/models/VodEpisode.dart';
import 'package:tv_app/models/SvodSerial.dart';
import 'package:tv_app/models/SvodEpisode.dart';

class Repository {
  @protected
  ApiProvider provider = ApiProvider();

  @protected
  Show showFromJson(
      Map<String, dynamic> epgJson, Map<String, dynamic> channelJson) {
    epgJson['channel'] = channelJson;
    return Show.fromJson(epgJson);
  }

  @protected
  Channel channelFromJson(Map<String, dynamic> channelJson) {
    return Channel.fromJson(channelJson);
  }

  @protected
  Serial serialFromJson(Map<String, dynamic> serialJson,
      Map<String, dynamic> channelJson, List<dynamic> episodesJson) {
    serialJson['channel'] = channelJson;
    serialJson['episodes'] = episodesJson;
    return Serial.fromJson(serialJson);
  }

  @protected
  dynamic vodContentFromJson(Map<String, dynamic> vodJson) {
    if (vodJson['isSerial'] == true) {
      // From category content - serial
      return vodSerialFromJson(vodJson, []);
    }
    if (vodJson['isSerial'] == false) {
      // From category content - Movie
      return _vodMovieFromJson(vodJson);
    }
    if (vodJson['isSerial'] == null) {
      // From content details
      if (vodJson['serialId'] != null) {
        // Serial ID not null - could be Serial or Episode
        if (vodJson['serialId'] == vodJson['id']) {
          // Same ID as serialID - serial
          return vodSerialFromJson(vodJson, []);
        } else {
          // Different ID from serialID - Episode
          return _vodEpisodeFromJson(vodJson);
        }
      } else {
        // without serialID - Movie
        return _vodMovieFromJson(vodJson);
      }
    }
  }

  @protected
  dynamic svodContentFromJson(Map<String, dynamic> svodJson) {
    if (svodJson['isSerial'] == true) {
      // From category content - serial
      return svodSerialFromJson(svodJson, []);
    }
    if (svodJson['isSerial'] == false) {
      // From category content - Movie
      return _svodMovieFromJson(svodJson);
    }
    if (svodJson['isSerial'] == null) {
      // From content details
      if (svodJson['serialId'] != null) {
        // Serial ID not null - could be Serial or Episode
        if (svodJson['serialId'] == svodJson['id']) {
          // Same ID as serialID - serial
          return svodSerialFromJson(svodJson, []);
        } else {
          // Different ID from serialID - Episode
          return _svodEpisodeFromJson(svodJson);
        }
      } else {
        // without serialID - Movie
        return _svodMovieFromJson(svodJson);
      }
    }
  }

  @protected
  VodSerial vodSerialFromJson(
      Map<String, dynamic> serialJson, List<dynamic> seasonJson) {
    return VodSerial.fromJson(serialJson, seasonJson);
  }

  @protected
  SvodSerial svodSerialFromJson(
      Map<String, dynamic> serialJson, List<dynamic> seasonJson) {
    return SvodSerial.fromJson(serialJson, seasonJson);
  }

  VodMovie _vodMovieFromJson(Map<String, dynamic> vodJson) {
    return VodMovie.fromJson(vodJson);
  }

  VodEpisode _vodEpisodeFromJson(Map<String, dynamic> vodJson) {
    return VodEpisode.fromJson(vodJson);
  }

  SvodEpisode _svodMovieFromJson(Map<String, dynamic> svodJson) {
    return SvodEpisode.fromJson(svodJson);
  }

  SvodEpisode _svodEpisodeFromJson(Map<String, dynamic> svodJson) {
    return SvodEpisode.fromJson(svodJson);
  }
}
