
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StyleService extends GetxService {

  TextStyle get contentTitle => TextStyle(color: Colors.white, fontSize: 23);
  TextStyle get contentInfo => TextStyle(color: Colors.white, fontSize: 15);
  TextStyle get metaData => TextStyle(color: Colors.white, fontSize: 13);
  TextStyle get metaHighlight => TextStyle(color: Colors.blueAccent, fontSize: 13);
  TextStyle get metaDataTitle => TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold);

}