import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageNetwork extends StatelessWidget {
  final String? type;
  final String? variation;
  final String? url;
  final double? width;
  final double? height;

  ImageNetwork(
      {Key? key, this.url, this.type, this.variation, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.url == null) {
      return Image(
        image: AssetImage('assets/no_img_${this.type}.png'),
        width: width,
        height: height,
      );
    } else {
      return Stack(
        children: [
          Center(
            child: CircularProgressIndicator(),
          ),
          Center(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: this.url!,
            ),
          )
        ],
      );
      // return Image.network(this.url, width: width, height: height,);
    }
  }
}
