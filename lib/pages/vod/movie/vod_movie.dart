import 'package:flutter/material.dart';

enum vodTypes{
  vod,
  svod
}

class VodMovie extends StatelessWidget {
  final String showId;
  final vodTypes vodType;

  VodMovie(this.showId, this.vodType);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Text("VodMovie"),
    );
  }
}