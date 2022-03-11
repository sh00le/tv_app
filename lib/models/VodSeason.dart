import 'package:tv_app/models/DefVodSeason.dart';
import 'package:tv_app/models/Image.dart';
import 'package:tv_app/models/VodEpisode.dart';
import 'package:tv_app/models/VodMovie.dart';

class VodSeason extends DefVodSeason {
    Map<String, Image>? images;
    List<VodEpisode>? episodes;
    String? externalCode;
    String? id;
    String? originalTitle;
    String? title;
    int? userBookmarkPercentage;
    bool? userLocked;

    VodSeason({this.episodes, this.externalCode, this.id, this.images, this.originalTitle, this.title, this.userBookmarkPercentage, this.userLocked});

    factory VodSeason.fromJson(Map<String, dynamic> json) {
        return VodSeason(
            episodes: json['episodes'] != null ? (json['episodes'] as List).map((i) => VodEpisode.fromJson(i)).toList() : null,
            externalCode: json['externalCode'], 
            id: json['id'], 
            // images: json['images'] != null ? (json['images'] as List).map((i) => Image.fromJson(i)).toList() : null,
            images: json['images'] != null ? Image.parseImageJson(json['images']) : null,
            originalTitle: json['originalTitle'], 
            title: json['title'], 
            userBookmarkPercentage: json['userBookmarkPercentage'], 
            userLocked: json['userLocked'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['externalCode'] = this.externalCode;
        data['id'] = this.id;
        data['originalTitle'] = this.originalTitle;
        data['title'] = this.title;
        data['userBookmarkPercentage'] = this.userBookmarkPercentage;
        data['userLocked'] = this.userLocked;
        if (this.episodes != null) {
            data['episodes'] = this.episodes!.map((v) => v.toJson()).toList();
        }
        // if (this.images != null) {
        //     data['images'] = this.images.map((v) => v.toJson()).toList();
        // }
        return data;
    }
}