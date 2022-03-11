class DefVodCategory {
  bool? hasRecommendation;
  String? id;
  String? parentId;
  String? title;

  DefVodCategory({this.hasRecommendation, this.id, this.parentId, this.title});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasRecommendation'] = this.hasRecommendation;
    data['id'] = this.id;
    data['parentId'] = this.parentId;
    data['title'] = this.title;
    return data;
  }
}