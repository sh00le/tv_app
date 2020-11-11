import 'package:flutter/foundation.dart';

class Image {
    String imageType;
    String imageUrl;
    String variation;

    Image({this.imageType, this.imageUrl, this.variation});

    factory Image.fromJson(Map<String, dynamic> json) {
        RegExp regExp = new RegExp(r"_\d+_(.+)\.");
        final match = regExp.firstMatch(json['imageUrl']);

        return Image(
            imageType: json['imageType'],
            imageUrl: json['imageUrl'],
            variation: match.group(1)
        );
    }

    static String generateKey(String variation, String type) {
        return '$variation-$type';
    }

    static Map<String, Image> parseImageJson(List<dynamic> json) {
        Map<String, Image> data = {};
        json.forEach((i) {
            Image _img = Image.fromJson(i);
            data[generateKey(_img.variation, _img.imageType)] = _img;
        });
        return data;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['imageType'] = this.imageType;
        data['imageUrl'] = this.imageUrl;
        data['variation'] = this.variation;
        return data;
    }
}