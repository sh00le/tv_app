import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  final String type;
  final String variation;
  final String url;
  ImageNetwork({Key key, this.url, this.type, this.variation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.url == null) {
      return Image(image: AssetImage('assets/no_img_${this.type}.png'));
    } else {
      return Image.network(this.url);
    }

  }
}