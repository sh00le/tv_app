class Menu {
  String title;
  String icon;
  String recommendation;

  Menu({this.title, this.icon, this.recommendation});

  factory Menu.fromMap(Map<String, String> dataList) {
    return Menu(
      title: dataList['title'],
      icon: dataList['icon'],
      recommendation: dataList['recommendation'],
    );
  }
}