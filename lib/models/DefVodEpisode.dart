import 'package:tv_app/models/Image.dart';
import "package:tv_app/models/DefVodContent.dart";

class DefVodEpisode extends DefVodContent {
  DefVodEpisode(
      {String? actors,
      String? ageRating,
      int? buyDuration,
      String? buyPrice,
      List<String>? categories,
      String? description,
      String? director,
      int? duration,
      int? expirationTimestamp,
      String? genre,
      bool? hasTrailer,
      String? id,
      Map<String, Image>? images,
      int? licenceExpiration,
      String? originalTitle,
      String? serialId,
      String? starRating,
      String? title,
      int? userBookmarkPercentage,
      bool? userFavorite,
      bool? userLocked,
      bool? userOttPlayable,
      bool? userPurchasable,
      bool? userPurchasePinRequired,
      bool? watched,
      String? year})
      : super(
          actors: actors,
          ageRating: ageRating,
          buyDuration: buyDuration,
          buyPrice: buyPrice,
          categories: categories,
          description: description,
          director: director,
          duration: duration,
          expirationTimestamp: expirationTimestamp,
          genre: genre,
          hasTrailer: hasTrailer,
          id: id,
          images: images,
          licenceExpiration: licenceExpiration,
          originalTitle: originalTitle,
          serialId: serialId,
          starRating: starRating,
          title: title,
          userBookmarkPercentage: userBookmarkPercentage,
          userFavorite: userFavorite,
          userLocked: userLocked,
          userOttPlayable: userOttPlayable,
          userPurchasable: userPurchasable,
          userPurchasePinRequired: userPurchasePinRequired,
          watched: watched,
          year: year,
        );

  factory DefVodEpisode.fromJson(Map<String, dynamic> json) {
    return DefVodEpisode(
      actors: json['actors'],
      ageRating: json['ageRating'],
      buyDuration: json['buyDuration'],
      buyPrice: json['buyPrice'],
      categories: json['categories'] != null
          ? List<String>.from(json['categories'])
          : null,
      description: json['description'],
      director: json['director'],
      duration: json['duration'],
      expirationTimestamp: json['expirationTimestamp'],
      genre: json['genre'],
      hasTrailer: json['hasTrailer'],
      id: json['id'],
      // images: json['images'] != null ? (json['images'] as List).map((i) => Image.fromJson(i)).toList() : null,
      images:
          json['images'] != null ? Image.parseImageJson(json['images']) : null,
      licenceExpiration: json['licenceExpiration'],
      originalTitle: json['originalTitle'],
      serialId: json['serialId'],
      starRating: json['starRating'],
      title: json['title'],
      userBookmarkPercentage: json['userBookmarkPercentage'],
      userFavorite: json['userFavorite'],
      userLocked: json['userLocked'],
      userOttPlayable: json['userOttPlayable'],
      userPurchasable: json['userPurchasable'],
      userPurchasePinRequired: json['userPurchasePinRequired'],
      watched: json['watched'],
      year: json['year'],
    );
  }
}
