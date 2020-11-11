import 'package:flutter/material.dart';
import 'package:tv_app/widgets/image_network/imageNetwork.dart';
import 'package:tv_app/models/DefVodSerial.dart';

/// VOD content item with content image and show title
class VodSerialListItem extends StatefulWidget{
  VodSerialListItem({Key key, this.item}) : super(key: key);

  final DefVodSerial item;

  @override
  _VodSerialListItemState createState() => _VodSerialListItemState();
}

class _VodSerialListItemState extends State<VodSerialListItem> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ImageNetwork(url: this.widget.item.variation('M', 'poster').imageUrl, type: 'poster', variation: 'M'),
        ),
      ],
    );
  }
}