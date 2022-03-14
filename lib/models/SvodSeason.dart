import 'package:tv_app/models/DefVodEpisode.dart';
import 'package:tv_app/models/DefVodSeason.dart';
import 'package:tv_app/models/Image.dart';

class SvodSeason extends DefVodSeason {
  Map<String, Image>? images;
  List<DefVodEpisode>? episodes;
  String? externalCode;
  String? id;
  String? originalTitle;
  String? title;
  int? userBookmarkPercentage;
  bool? userLocked;

  SvodSeason(
      {this.episodes,
      this.externalCode,
      this.id,
      this.images,
      this.originalTitle,
      this.title,
      this.userBookmarkPercentage,
      this.userLocked});

  factory SvodSeason.fromJson(Map<String, dynamic> json) {
    return SvodSeason(
      episodes: json['episodes'] != null
          ? (json['episodes'] as List)
              .map((i) => DefVodEpisode.fromJson(i))
              .toList()
          : null,
      externalCode: json['externalCode'],
      id: json['id'],
      images:
          json['images'] != null ? Image.parseImageJson(json['images']) : null,
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
    if (this.images != null) {
      // data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
