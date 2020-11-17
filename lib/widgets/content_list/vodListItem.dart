import 'package:flutter/material.dart';
import 'package:tv_app/widgets/image_network/imageNetwork.dart';
import 'package:tv_app/models/DefVodContent.dart';

/// VOD content item with content image and show title
class VodListItem extends StatefulWidget{
  VodListItem({Key key, this.item}) : super(key: key);

  final DefVodContent item;

  @override
  _VodListItemState createState() => _VodListItemState();
}

class _VodListItemState extends State<VodListItem> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ImageNetwork(url: this.widget.item.imageVariation('M', 'poster').imageUrl, type: 'poster', variation: 'M')
        ),
      ],
    );
  }
}