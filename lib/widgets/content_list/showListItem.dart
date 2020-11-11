import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tv_app/models/Show.dart';
import 'package:tv_app/widgets/image_network/imageNetwork.dart';

/// EPG content item with content image, channel logo and show title
class showListItem extends StatefulWidget{
  showListItem({Key key, this.item}) : super(key: key);

  final Show item;

  @override
  _showListItemState createState() => _showListItemState();
}

TextStyle textStyle = TextStyle(
  color: Colors.white,
  fontSize: 13,
);



/// EPG content State
class _showListItemState extends State<showListItem> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var time = DateTime.fromMillisecondsSinceEpoch(this.widget.item.startTime * 1000);

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
                this.widget.item.channel.title,
                maxLines: 1,
                style: textStyle,
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              child: ImageNetwork(url: this.widget.item.variation('M', 'still').imageUrl, type: 'still', variation: 'M'),
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
                  this.widget.item.title,
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