import 'package:tv_app/models/DefVodCategory.dart';

class SvodCategory extends DefVodCategory{
  SvodCategory({bool hasRecommendation, String id, String parentId, String title}) : super(
      hasRecommendation: hasRecommendation,
      id: id,
      parentId: parentId,
      title: title
  );

  factory SvodCategory.fromJson(Map<String, dynamic> json) {
    return SvodCategory(
      hasRecommendation: json['hasRecommendation'],
      id: json['id'],
      parentId: json['parentId'],
      title: json['title'],
    );
  }
}