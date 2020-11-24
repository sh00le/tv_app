import 'package:tv_app/models/DefVodSeason.dart';
import 'package:tv_app/models/Image.dart';

class DefVodSerial {
    List<DefVodSeason> seasons;
    Map<String, Image> images;
    String id;
    String title;
    String originalTitle;
    String genre;
    String category;
    String externalCode;
    String description;
    String actors;
    String year;
    String director;
    String starRating;
    int licenceExpiration;
    int userBookmarkPercentage;
    int matchRating;
    bool userLocked;
    bool userFavorite;
    bool userOttPlayable;
    bool ottAvailable;

    DefVodSerial({this.id, this.title, this.originalTitle, this.genre, this.category,
        this.externalCode, this.description, this.actors, this.year, this.director, this.starRating,
        this.licenceExpiration, this.userBookmarkPercentage, this.matchRating, this.userLocked,
        this.userFavorite, this.userOttPlayable, this.ottAvailable, this.seasons, this.images});

    String imageVariation(String variation, String type) {
        String outImageUrl;
        if (this.images != null) {
            String _key = Image.generateKey(variation, type);
            if (this.images.containsKey(_key)) {
                outImageUrl = this.images[_key].imageUrl;
            }
        }
        return outImageUrl;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.seasons != null) {
            // data['seasons'] = this.seasons.map((v) => v.toJson()).toList();
        }
        if (this.images != null) {
            // data['images'] = this.images.map((v) => v.toJson()).toList();
        }
        data['id'] = this.id;
        data['title'] = this.title;
        data['originalTitle'] = this.originalTitle;
        data['genre'] = this.genre;
        data['category'] = this.category;
        data['externalCode'] = this.externalCode;
        data['description'] = this.description;
        data['actors'] = this.actors;
        data['year'] = this.year;
        data['director'] = this.director;
        data['starRating'] = this.starRating;
        data['licenceExpiration'] = this.licenceExpiration;
        data['userBookmarkPercentage'] = this.userBookmarkPercentage;
        data['matchRating'] = this.matchRating;
        data['userLocked'] = this.userLocked == true ? true : false;
        data['userFavorite'] = this.userFavorite == true ? true : false;
        data['userOttPlayable'] = this.userOttPlayable == true ? true : false;
        data['ottAvailable'] = this.ottAvailable == true ? true : false;
        return data;
    }
}