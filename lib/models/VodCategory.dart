import 'package:tv_app/models/DefVodCategory.dart';

class VodCategory extends DefVodCategory{
    VodCategory({bool hasRecommendation, String id, String parentId, String title}) : super(
        hasRecommendation: hasRecommendation,
        id: id,
        parentId: parentId,
        title: title
    );

    factory VodCategory.fromJson(Map<String, dynamic> json) {
        return VodCategory(
            hasRecommendation: json['hasRecommendation'],
            id: json['id'],
            parentId: json['parentId'],
            title: json['title'],
        );
    }
}