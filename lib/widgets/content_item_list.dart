
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


/// EPG content item with content image, channel logo and show title
class EpgListItem extends StatefulWidget{
  EpgListItem({Key key, this.item}) : super(key: key);

  final item;

  @override
  _EpgListItemState createState() => _EpgListItemState();
}

TextStyle textStyle = TextStyle(
  color: Colors.white,
  fontSize: 13,
);



/// EPG content State
class _EpgListItemState extends State<EpgListItem> {

  String getImageUrl() {
    return this.widget.item["images"][this.widget.item["images"].length - 1]["imageUrl"];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var time = DateTime.fromMillisecondsSinceEpoch(this.widget.item['additional']['startTime'] * 1000);

    var dateFormat = DateFormat('HH:mm').format(time);
    return Container(
      color: Colors.black87,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 15,
              width: 110,
              child: Text(
                this.widget.item['additional']['channelTitle'],
                maxLines: 1,
                style: textStyle,
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              child: Image.network(getImageUrl() ?? ""),
            ),
            Container(
              height: 16,
              width: 110,
              child: Text(
                dateFormat,
                maxLines: 1,
                style: textStyle,
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              height: 40,
              child: Text(
                this.widget.item["title"],
                maxLines: 3,
                style: textStyle,
                textAlign: TextAlign.left,
              )
            ),
          ]
      ),
    );
  }
}


/// VOD content item with content image and show title
class VodListItem extends StatefulWidget{
  VodListItem({Key key, this.item}) : super(key: key);

  final item;

  @override
  _VodListItemState createState() => _VodListItemState();
}

class _VodListItemState extends State<VodListItem> {

  String getImageUrl() {
    return this.widget.item["images"][this.widget.item["images"].length - 1]["imageUrl"];
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
          Expanded(
            child: Image.network(getImageUrl() ?? ""),
          ),
      ],
    );
  }
}

/// SVOD content item with content image and show title
class SvodListItem extends VodListItem{
  SvodListItem({Key key, this.item}) : super(key: key);
  final item;

}



/// Content List item widget - detecting which content widget is needed to display on screen
class ContentListItem extends StatelessWidget {
  ContentListItem({Key key, this.item, this.selected}) : super(key: key);
  final item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 117,
      height: 170,
      decoration: BoxDecoration(
          border: selected ? Border.all(width: 3, color: Colors.white) : Border.all(width: 3, color: Colors.transparent)
      ),
      margin: EdgeInsets.only(left: 2, right: 2),
      child: getContentWidget(),
    );
  }

  /// Detect content type widget
  Widget getContentWidget() {
    switch (item['contentType']) {
      case 'VIDEO_VOD':
        return VodListItem(item: item);
        break;
      case 'VIDEO_SVOD':
        return SvodListItem(item: item);
        break;
      case 'PPV':
      case 'PROGRAM':
        return EpgListItem(item: item);
        break;
    }
    return Container();
  }
}