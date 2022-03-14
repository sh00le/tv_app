import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tv_app/models/Show.dart';
import 'package:tv_app/widgets/image_network/imageNetwork.dart';

/// EPG content item with content image, channel logo and show title
class ShowListItem extends StatefulWidget {
  ShowListItem({Key? key, required this.item}) : super(key: key);

  final Show item;

  @override
  _ShowListItemState createState() => _ShowListItemState();
}

TextStyle textStyle = TextStyle(
  color: Colors.white,
  fontSize: 13,
);

/// EPG content State
class _ShowListItemState extends State<ShowListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dateFormat = widget.item.startTime == null
        ? ""
        : DateFormat('HH:mm').format(this.widget.item.startTime!);
    return Container(
      color: Colors.black87,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 15,
              width: 110,
              child: Text(
                this.widget.item.channel!.title!,
                maxLines: 1,
                style: textStyle,
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              child: ImageNetwork(
                  url: this.widget.item.imageVariation('M', 'still')!,
                  type: 'still',
                  variation: 'M'),
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
                  this.widget.item.title!,
                  maxLines: 3,
                  style: textStyle,
                  textAlign: TextAlign.left,
                )),
          ]),
    );
  }
}
