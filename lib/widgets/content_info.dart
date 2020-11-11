import 'package:flutter/material.dart';

class ContentInfo extends StatelessWidget {
  ContentInfo({Key key, this.content}) : super(key: key);
  final content;

  @override
  Widget build(BuildContext context) {

    return content == null ? Container() : Row(
        children:<Widget>[
          Container(
              width: 464,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    content['title'],
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23
                    ),
                  ),
                  Text(
                    '1h 36min | ${content['year']} | ${content['genre']}',
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
                    '${content['description']}',
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
                  'Director: ${content['director']}',
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                  ),
                ),
                Text(
                  'Actors: ${content['actors']}',
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