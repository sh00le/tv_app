import 'package:flutter/material.dart';
import 'package:tv_app/models/DefVodContent.dart';
import 'package:tv_app/models/DefVodSerial.dart';
import 'package:tv_app/models/Show.dart';

class ContentInfo extends StatelessWidget {
  ContentInfo({Key key, this.content}) : super(key: key);
  final content;

  @override
  Widget build(BuildContext context) {

    if (content is DefVodContent) {
      return VodInfo(vodContent: content);
    } else if (content is DefVodSerial) {
      return VodSerialInfo(vodSerial: content);
    } else if (content is Show) {
      return ShowInfo(show: content);
    } else {
      return Container();
    }
  }
}

class VodInfo extends StatelessWidget {
  VodInfo({Key key, this.vodContent}) : super(key: key);
  final DefVodContent vodContent;

  @override
  Widget build(BuildContext context) {
    return Row(
        children:<Widget>[
          Container(
              width: 464,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    vodContent.title,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23
                    ),
                  ),
                  Text(
                    '1h 36min | ${vodContent.year} | ${vodContent.genre}',
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 13
                    ),
                  ),
                  SizedBox(
                      height: 20
                  ),
                  Text(
                    '${vodContent.description}',
                    textAlign: TextAlign.left,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    ),
                  )
                ],
              )
          ),
          SizedBox(
              width: 20
          ),
          Container(
            width: 358,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget>[
                  SizedBox(
                      height: 60
                  ),
                  Text(
                    'Director: ${vodContent.director}',
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    ),
                  ),
                  Text(
                    'Actors: ${vodContent.actors}',
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    ),
                  )
                ]
            ),
          ),
        ]
    );
  }
}

class VodSerialInfo extends StatelessWidget {
  VodSerialInfo({Key key, this.vodSerial}) : super(key: key);
  final DefVodSerial vodSerial;

  @override
  Widget build(BuildContext context) {
    return Row(
        children:<Widget>[
          Container(
              width: 464,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    vodSerial.title,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23
                    ),
                  ),
                  Text(
                    '1h 36min | ${vodSerial.year} | ${vodSerial.genre}',
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 13
                    ),
                  ),
                  SizedBox(
                      height: 20
                  ),
                  Text(
                    '${vodSerial.description}',
                    textAlign: TextAlign.left,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    ),
                  )
                ],
              )
          ),
          SizedBox(
              width: 20
          ),
          Container(
            width: 358,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget>[
                  SizedBox(
                      height: 60
                  ),
                  Text(
                    'Director: ${vodSerial.director}',
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    ),
                  ),
                  Text(
                    'Actors: ${vodSerial.actors}',
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    ),
                  )
                ]
            ),
          ),
        ]
    );
  }
}

class ShowInfo extends StatelessWidget {
  ShowInfo({Key key, this.show}) : super(key: key);
  final Show show;

  @override
  Widget build(BuildContext context) {
    return Row(
        children:<Widget>[
          Container(
              width: 464,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    show.title,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23
                    ),
                  ),
                  Text(
                    '1h 36min | ${show.channel.title} | ${show.genre}',
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 13
                    ),
                  ),
                  SizedBox(
                      height: 20
                  ),
                  Text(
                    '${show.description}',
                    textAlign: TextAlign.left,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    ),
                  )
                ],
              )
          ),
          SizedBox(
              width: 20
          ),
          Container(
            width: 358,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget>[
                  SizedBox(
                      height: 60
                  ),
                  Text(
                    'Director: ${show.director}',
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    ),
                  ),
                  Text(
                    'Actors: ${show.actors}',
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    ),
                  )
                ]
            ),
          ),
        ]
    );
  }
}