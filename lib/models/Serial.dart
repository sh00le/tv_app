import 'package:tv_app/models/Channel.dart';
import 'package:tv_app/models/Image.dart';
import 'package:tv_app/models/Show.dart';

class Serial {
    String? description;
    String? externalCode;
    bool? hasSeriesRecording;
    String? id;
    String? originalTitle;
    String? starRating;
    String? title;
    int? userBookmarkPercentage;
    bool? userFavorite;
    bool? userLocked;
    bool? userRecording;
    List<Image>? images;
    Channel? channel;
    List<Show>? episodes;

    Serial({this.description, this.externalCode, this.hasSeriesRecording, this.id, this.originalTitle, this.starRating, this.title,
        this.userBookmarkPercentage, this.userFavorite, this.userLocked, this.userRecording,
        this.images, this.channel, this.episodes});

    factory Serial.fromJson(Map<String, dynamic> json) {
        return Serial(
            description: json['description'], 
            externalCode: json['externalCode'], 
            hasSeriesRecording: json['hasSeriesRecording'], 
            id: json['id'],
            originalTitle: json['originalTitle'], 
            starRating: json['starRating'], 
            title: json['title'], 
            userBookmarkPercentage: json['userBookmarkPercentage'], 
            userFavorite: json['userFavorite'], 
            userLocked: json['userLocked'], 
            userRecording: json['userRecording'],
            images: json['images'] != null ? (json['images'] as List).map((i) => Image.fromJson(i)).toList() : null,
            channel: json['channel'] != null ? (Channel.fromJson(json['channel'])) : null,
            episodes: json['episodes'] != null ? (json['episodes'] as List).map((i) => Show.fromJson(i)).toList() : null,
        );
    }

    Image? variation(String variation, String type) {
        Image? outImage;

        this.images!.forEach((image) {
            if (image.imageType == type) {
                if (image.variation == variation) {
                    outImage = image;
                }
            }
        });

        return outImage;
    }


    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['description'] = this.description;
        data['externalCode'] = this.externalCode;
        data['hasSeriesRecording'] = this.hasSeriesRecording;
        data['id'] = this.id;
        data['originalTitle'] = this.originalTitle;
        data['starRating'] = this.starRating;
        data['title'] = this.title;
        data['userBookmarkPercentage'] = this.userBookmarkPercentage;
        data['userFavorite'] = this.userFavorite;
        data['userLocked'] = this.userLocked;
        data['userRecording'] = this.userRecording;
        if (this.images != null) {
            data['images'] = this.images!.map((v) => v.toJson()).toList();
        }
        if (this.channel != null) {
            data['channel'] = this.channel!.toJson();
        }
        if (this.episodes != null) {
            data['episodes'] = this.episodes!.map((v) => v.toJson()).toList();
        }
        return data;
    }
}