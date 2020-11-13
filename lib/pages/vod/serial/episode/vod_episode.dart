import 'package:flutter/material.dart';

enum vodTypes{
  vod,
  svod
}

class VodEpisode extends StatelessWidget {
  final String showId;
  final vodTypes vodType;

  VodEpisode(this.showId, this.vodType);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Text("VodEpisode"),
    );
  }
}