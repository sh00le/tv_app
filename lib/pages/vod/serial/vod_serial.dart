import 'package:flutter/material.dart';

enum vodTypes{
  vod,
  svod
}

class VodSerial extends StatelessWidget {
  final String showId;
  final vodTypes vodType;

  VodSerial(this.showId, this.vodType);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Text("VodSerial"),
    );
  }
}