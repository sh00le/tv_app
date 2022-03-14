import 'package:tv_app/models/DefVodEpisode.dart';
import 'package:tv_app/models/Image.dart';

class DefVodSeason {
  Map<String, Image>? images;
  List<DefVodEpisode>? episodes;
  String? externalCode;
  String? id;
  String? originalTitle;
  String? title;
  int? userBookmarkPercentage;
  bool? userLocked;

  DefVodSeason(
      {this.episodes,
      this.externalCode,
      this.id,
      this.images,
      this.originalTitle,
      this.title,
      this.userBookmarkPercentage,
      this.userLocked});

  String? getSeasonTitle() {
    RegExp regExp = new RegExp(r"[^ ]+\s+[^ ]+$");
    final match = regExp.firstMatch(title!);
    return match != null ? match.group(0) : '';
  }
}
