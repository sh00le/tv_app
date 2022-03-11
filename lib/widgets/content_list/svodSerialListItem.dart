import 'package:flutter/material.dart';
import 'package:tv_app/widgets/content_list/vodSerialListItem.dart';

/// SVOD content item with content image and show title
class SvodSerialListItem extends VodSerialListItem {
  SvodSerialListItem({Key? key, required this.item})
      : super(key: key!, item: item);
  final item;
}
