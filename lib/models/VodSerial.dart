import 'package:tv_app/models/DefVodSerial.dart';
import 'package:tv_app/models/VodSeason.dart';
import 'package:tv_app/models/Image.dart';

class VodSerial extends DefVodSerial {

  VodSerial({
    String id,
    String title,
    String originalTitle,
    String genre,
    String category,
    String externalCode,
    String description,
    String actors,
    String year,
    String director,
    String starRating,
    int licenceExpiration,
    int userBookmarkPercentage,
    int matchRating,
    bool userLocked,
    bool userFavorite,
    bool userOttPlayable,
    bool ottAvailable,
    List<VodSeason> seasons,
    Map<String, Image> images }) : super(
      id: id,
      title: title,
      originalTitle: originalTitle,
      genre: genre,
      category: category,
      externalCode: externalCode,
      description: description,
      actors: actors,
      year: year,
      director: director,
      starRating: starRating,
      licenceExpiration: licenceExpiration,
      userBookmarkPercentage: userBookmarkPercentage,
      matchRating: matchRating,
      userLocked: userLocked,
      userFavorite: userFavorite,
      userOttPlayable: userOttPlayable,
      ottAvailable: ottAvailable,
      seasons: seasons,
      images: images
  );

  factory VodSerial.fromJson(Map<String, dynamic> json, List<dynamic> seasonJson) {
    return VodSerial(
      id: json['id'],
      title: json['title'],
      originalTitle: json['originalTitle'],
      genre: json['genre'],
      category: json['category'],
      externalCode: json['externalCode'],
      description: json['description'],
      actors: json['actors'],
      year: json['year'],
      director: json['director'],
      starRating: json['starRating'],
      licenceExpiration: json['licenceExpiration'],
      userBookmarkPercentage: json['userBookmarkPercentage'],
      matchRating: json['matchRating'],
      userLocked: (json['userLocked'] == 1 || json['userLocked'] == true) ? true : false,
      userFavorite: (json['userFavorite'] == 1 || json['userFavorite'] == true) ? true : false,
      userOttPlayable: (json['userOttPlayable'] == 1 || json['userOttPlayable'] == true) ? true : false,
      ottAvailable: (json['ottAvailable'] == 1 || json['ottAvailable'] == true) ? true : false,
      seasons: seasonJson!= null ? seasonJson.map((i) => VodSeason.fromJson(i)).toList() : null,
      // images: json['images'] != null ? (json['images'] as List).map((i) => Image.fromJson(i)).toList() : null,
      images: json['images'] != null ? Image.parseImageJson(json['images']) : null,
    );
  }


}