import 'package:flutter/foundation.dart';
import 'package:tv_app/models/Image.dart';

class DefVodContent {
  String actors;
  String ageRating;
  int buyDuration;
  String buyPrice;
  List<String> categories;
  String description;
  String director;
  int duration;
  int expirationTimestamp;
  String genre;
  bool hasTrailer;
  String id;
  Map<String, Image> images;
  int licenceExpiration;
  String originalTitle;
  String serialId;
  String starRating;
  String title;
  int userBookmarkPercentage;
  bool userFavorite;
  bool userLocked;
  bool userOttPlayable;
  bool userPurchasable;
  bool userPurchasePinRequired;
  bool watched;
  String year;

  DefVodContent({this.actors, this.ageRating, this.buyDuration, this.buyPrice, this.categories,
    this.description, this.director, this.duration, this.expirationTimestamp,
    this.genre, this.hasTrailer, this.id, this.images, this.licenceExpiration,
    this.originalTitle, this.serialId, this.starRating, this.title, this.userBookmarkPercentage,
    this.userFavorite, this.userLocked, this.userOttPlayable, this.userPurchasable,
    this.userPurchasePinRequired, this.watched, this.year});

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

  String displayDuration() {
    String formattedDuration = '';
    debugPrint('duration $duration');
    int minInHour = 60;
    int hours = duration ~/ minInHour;
    int minutes = duration % minInHour;
    if (hours > 0) {
      formattedDuration = '${hours}h ';
    }
    formattedDuration += '${minutes}min ';
    return formattedDuration;
  }

  String displayPrice() {
    if ( int.parse(buyPrice) > 0 ) {
      return buyPrice + '€';
    } else {
      return '';
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ageRating'] = this.ageRating;
    data['buyDuration'] = this.buyDuration;
    data['buyPrice'] = this.buyPrice;
    data['description'] = this.description;
    data['director'] = this.director;
    data['duration'] = this.duration;
    data['expirationTimestamp'] = this.expirationTimestamp;
    data['genre'] = this.genre;
    data['hasTrailer'] = this.hasTrailer;
    data['id'] = this.id;
    data['licenceExpiration'] = this.licenceExpiration;
    data['originalTitle'] = this.originalTitle;
    data['starRating'] = this.starRating;
    data['title'] = this.title;
    data['userBookmarkPercentage'] = this.userBookmarkPercentage;
    data['userFavorite'] = this.userFavorite;
    data['userLocked'] = this.userLocked;
    data['userOttPlayable'] = this.userOttPlayable;
    data['userPurchasable'] = this.userPurchasable;
    data['userPurchasePinRequired'] = this.userPurchasePinRequired;
    data['watched'] = this.watched;
    data['year'] = this.year;
    data['actors'] = this.actors;
    data['serialId'] = this.serialId;
    if (this.categories != null) {
      data['categories'] = this.categories;
    }
    if (this.images != null) {
      // data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}