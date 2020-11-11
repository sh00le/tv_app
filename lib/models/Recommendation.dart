import 'package:tv_app/models/Show.dart';
import 'package:tv_app/models/SvodEpisode.dart';
import 'package:tv_app/models/SvodMovie.dart';
import 'package:tv_app/models/SvodSerial.dart';
import 'package:tv_app/models/VodEpisode.dart';
import 'package:tv_app/models/VodMovie.dart';
import 'package:tv_app/models/VodSerial.dart';

class Recommendation {
  String id;
  String title;
  List<dynamic> recommendations;

  Recommendation({this.id, this.title, this.recommendations});

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    List<dynamic> recommendationsList = [];
    if (json['recommendations'] != null) {
      for (var recommendation in json['recommendations']) {
        switch (recommendation['contentType']) {
          case 'PPV':
          case 'PROGRAM':

            var showJson = recommendation;
            showJson['showId'] = showJson['showId'] != null ? showJson['showId'] : showJson['contentId'];
            showJson['startTime'] = showJson['startTime'] != null ? showJson['startTime'] : recommendation["additional"]["startTime"];
            showJson['endTime'] = showJson['endTime'] != null ? showJson['endTime'] : recommendation["additional"]["endTime"];
            showJson['channel'] = showJson['channel'] != null ? showJson['channel'] : recommendation["additional"];
            showJson['channel']['title'] = showJson['channel']['title'] != null ? showJson['channel']['title'] : recommendation["additional"]['channelTitle'];
            recommendationsList.add(Show.fromJson(showJson));

            break;
          case 'VIDEO_VOD':

            var vodJson = recommendation;
            vodJson['id'] = vodJson['id'] != null ? vodJson['id'] : vodJson['contentId'];
            if (vodJson['serialId'] != "") {
              if (vodJson['serialId'] == vodJson['id']) {
                recommendationsList.add(VodSerial.fromJson(vodJson, []));
              } else {
                recommendationsList.add(VodEpisode.fromJson(vodJson));
              }
            } else {
              recommendationsList.add(VodMovie.fromJson(vodJson));
            }

            break;
          case 'VIDEO_SVOD':

            var svodJson = recommendation;
            svodJson['id'] = svodJson['id'] != null ? svodJson['id'] : svodJson['contentId'];
            if (svodJson['serialId'] != "") {
              if(svodJson['serialId'] == svodJson['id']) {
                recommendationsList.add(SvodSerial.fromJson(svodJson, []));
              } else {
                recommendationsList.add(SvodEpisode.fromJson(svodJson));
              }
            } else {
              recommendationsList.add(SvodMovie.fromJson(svodJson));
            }

            break;
        }

      }
    }
    return Recommendation(
      id: json['id'],
      title: json['title'],
      recommendations: recommendationsList
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.recommendations != null) {
      data['recommendations'] = this.recommendations.map((v) => v.toJson()).toList();
    }
  }
}