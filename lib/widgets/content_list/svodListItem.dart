import 'package:flutter/material.dart';
import 'package:tv_app/widgets/content_list/vodListItem.dart';

/// SVOD content item with content image and show title
class SvodListItem extends VodListItem {
  SvodListItem({Key? key, required this.item}) : super(key: key, item: item);
  final item;
}
