import 'package:flutter/material.dart';
import 'package:tv_app/models/Show.dart';
import 'package:tv_app/models/VodEpisode.dart';
import 'package:tv_app/models/VodMovie.dart';
import 'package:tv_app/models/VodSerial.dart';
import 'package:tv_app/models/SvodMovie.dart';
import 'package:tv_app/models/SvodSerial.dart';
import 'package:tv_app/widgets/content_list/showListItem.dart';
import 'package:tv_app/widgets/content_list/vodListItem.dart';
import 'package:tv_app/widgets/content_list/svodListItem.dart';
import 'package:tv_app/widgets/content_list/svodSerialListItem.dart';
import 'package:tv_app/widgets/content_list/vodSerialListItem.dart';


/// Content List item widget - detecting which content widget is needed to display on screen
class ContentListItem extends StatelessWidget {
  ContentListItem({Key key, this.item, this.selected}) : super(key: key);
  final dynamic item;
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
    debugPrint('$item');
    if (item is Show) {
      return showListItem(item: item);
    } else if (item is VodEpisode) {
      return VodListItem(item: item);
    } else if (item is VodMovie) {
      return VodListItem(item: item);
    } else if (item is VodSerial) {
      return VodSerialListItem(item: item);
    } else if (item is SvodMovie) {
      return SvodListItem(item: item);
    } else if (item is SvodSerial) {
      return SvodSerialListItem(item: item);
    } else {
      return Container();
    }
  }
}