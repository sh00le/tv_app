import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:tv_app/models/Image.dart';
import 'package:tv_app/models/Channel.dart';

class Show {
    String actors;
    String ageRating;
    bool blackout;
    String buyPrice;
    String category;
    String description;
    String director;
    DateTime endTime;
    String episode;
    String genre;
    bool isPPV;
    String season;
    String seriesId;
    bool showClientId;
    int showId;
    DateTime startTime;
    String title;
    bool hasCatchup;
    bool hasRecording;
    bool hasReminder;
    bool hasSeriesRecording;
    bool userIptvPlayable;
    bool userLocked;
    bool userOttPlayable;
    bool userRecording;
    bool userReminder;
    bool userStbPaired;
    Map<String, Image> images;
    Channel channel;

    Show({
        this.actors, this.ageRating, this.blackout, this.buyPrice, this.category, this.description,
        this.director, this.endTime, this.episode, this.genre, this.hasCatchup, this.hasRecording, this.hasReminder,
        this.hasSeriesRecording, this.isPPV, this.season, this.seriesId, this.showClientId,
        this.showId, this.startTime, this.title, this.userIptvPlayable, this.userLocked, this.userOttPlayable,
        this.userRecording, this.userReminder, this.userStbPaired, this.images, this.channel
    });

    factory Show.fromJson(Map<String, dynamic> json) {
        return Show(
            actors: json['actors'],
            ageRating: json['ageRating'], 
            blackout: json['blackout'], 
            buyPrice: json['buyPrice'], 
            category: json['category'], 
            description: json['description'], 
            director: json['director'],
            episode: json['episode'], 
            genre: json['genre'],
            hasCatchup: (json['hasCatchup'] == 1 || json['hasCatchup'] == true) ? true : false,
            hasRecording: (json['hasRecording'] == 1 || json['hasRecording'] == true) ? true : false,
            hasReminder: (json['hasReminder'] == 1 || json['hasReminder'] == true) ? true : false,
            hasSeriesRecording: (json['hasSeriesRecording'] == 1 || json['hasSeriesRecording'] == true) ? true : false,
            isPPV: json['isPPV'], 
            season: json['season'], 
            seriesId: json['seriesId'], 
            showClientId: json['showClientId'] != null ? json['showClientId'] : false,
            showId: int.parse(json['showId']),
            startTime: DateTime.fromMillisecondsSinceEpoch(json['startTime'] * 1000),
            endTime: DateTime.fromMillisecondsSinceEpoch(json['endTime'] * 1000),
            title: json['title'], 
            userIptvPlayable: (json['userIptvPlayable'] == 1 || json['userIptvPlayable'] == true) ? true : false,
            userLocked: json['userLocked'], 
            userOttPlayable: (json['userOttPlayable'] == 1 || json['userOttPlayable'] == true) ? true : false,
            userRecording: (json['userRecording'] == 1 || json['userRecording'] == true) ? true : false,
            userReminder: (json['userReminder'] == 1 || json['userReminder'] == true) ? true : false,
            userStbPaired: (json['userStbPaired'] == 1 || json['userStbPaired'] == true) ? true : false,
            // images: json['images'] != null ? (json['images'] as List).map((i) => Image.fromJson(i)).toList() : null,
            images: json['images'] != null ? Image.parseImageJson(json['images']) : null,

            channel: json['channel'] != null ? Channel.fromJson(json['channel']) : null
        );
    }

    Image imageVariation(String variation, String type) {
        Image outImage;
        if (this.images != null) {
            String _key = Image.generateKey(variation, type);
            if (this.images.containsKey(_key)) {
                outImage = this.images[_key];
            }
        }
        return outImage;
    }

    String displayTimeStartToEnd() {
        var todayDay = DateTime.now();
        if ( startTime.isBefore(todayDay) && todayDay.isBefore(endTime)) {
            return 'NOW';
        } else {
            return '${displayStartTime()} - ${displayEndTime()}';
        }
    }

    String displayStartTime() {
        var timeFormat = DateFormat('HH:mm');
        return '${timeFormat.format(startTime)}';
    }

    String displayEndTime() {
        var timeFormat = DateFormat('HH:mm');
        return '${timeFormat.format(endTime)}';
    }

    double showProgress(double width) {
        double progress = 0.0;
        var todayDay = DateTime.now();
        debugPrint('todayDay $todayDay');
        debugPrint('endTime $endTime');

        if (todayDay.isAfter(endTime) ) {
            progress = width;
        } else if (todayDay.isAfter(startTime)) {
            var duration = endTime.difference(startTime).inSeconds;
            var currentProgress = todayDay.difference(startTime).inSeconds;
            progress = (currentProgress / duration) * width;
        }
        debugPrint('showProgress $progress');
        return progress;
    }

    String displayDateDay() {
        String outDay = '';
        var weekDay = startTime.weekday;
        var todayDay = DateTime.now();

        debugPrint('$startTime - $weekDay - ${todayDay.weekday}');

        if (todayDay.weekday == weekDay) {
            outDay = 'Today';
        } else if (todayDay.weekday - 1 == weekDay) {
            outDay = 'Yesterday';
        } else if (todayDay.weekday + 1 == weekDay) {
            outDay = 'Tomorrow';
        } else {
            switch (weekDay) {
                case DateTime.monday:
                    outDay = 'Monday';
                    break;
                case DateTime.tuesday:
                    outDay = 'Tuesday';
                    break;
                case DateTime.wednesday:
                    outDay = 'Wednesday';
                    break;
                case DateTime.thursday:
                    outDay = 'Thursday';
                    break;
                case DateTime.friday:
                    outDay = 'Friday';
                    break;
                case DateTime.saturday:
                    outDay = 'Saturday';
                    break;
                case DateTime.sunday:
                    outDay = 'Sunday';
                    break;
            }
        }
        return outDay;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['ageRating'] = this.ageRating;
        data['blackout'] = this.blackout;
        data['buyPrice'] = this.buyPrice;
        data['category'] = this.category;
        data['description'] = this.description;
        data['endTime'] = this.endTime.millisecondsSinceEpoch / 1000;
        data['episode'] = this.episode;
        data['genre'] = this.genre;
        data['hasCatchup'] = this.hasCatchup;
        data['hasRecording'] = this.hasRecording;
        data['hasReminder'] = this.hasReminder;
        data['hasSeriesRecording'] = this.hasSeriesRecording;
        data['isPPV'] = this.isPPV;
        data['season'] = this.season;
        data['seriesId'] = this.seriesId;
        data['showId'] = this.showId;
        data['startTime'] = this.startTime.millisecondsSinceEpoch / 1000;
        data['title'] = this.title;
        data['userIptvPlayable'] = this.userIptvPlayable;
        data['userLocked'] = this.userLocked;
        data['userOttPlayable'] = this.userOttPlayable;
        data['userRecording'] = this.userRecording;
        data['userReminder'] = this.userReminder;
        data['userStbPaired'] = this.userStbPaired;
        data['actors'] = this.actors;
        data['director'] = this.director;
        data['showClientId'] = this.showClientId;
        if (this.images != null) {
            // data['images'] = this.images.map((v) => v.toJson()).toList();
        }
        if (this.channel != null) {
            data['channel'] = this.channel.toJson();
        }

        return data;
    }
}