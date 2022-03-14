import 'package:flutter/material.dart';
import 'package:tv_app/models/DefVodContent.dart';
import 'package:tv_app/models/DefVodSerial.dart';
import 'package:tv_app/models/Show.dart';

class ContentInfo extends StatelessWidget {
  ContentInfo({Key? key, this.content}) : super(key: key);
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
  VodInfo({Key? key, required this.vodContent}) : super(key: key);
  final DefVodContent vodContent;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      height: 240,
      width: 960,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Spacer top
          Container(
            height: 0,
            width: 960,
          ),
          Row(
            children: [
              // Spacer - left
              Container(
                width: 180,
                height: 162,
              ),
              // Basic Content info
              Container(
                  width: 480,
                  height: 162,
                  child: Column(
                    children: [
                      // Content Title
                      Container(
                        alignment: Alignment.topLeft,
                        height: 28,
                        child: Text(
                          vodContent.title!,
                          style: textTheme.headline1,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      // Content meta data
                      Container(
                        height: 28,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              vodContent.duration != null
                                  ? Text(
                                      '${vodContent.duration.toString()} | ',
                                      style: textTheme.subtitle1,
                                      textAlign: TextAlign.start,
                                    )
                                  : Container(),
                              vodContent.year != null
                                  ? Text(
                                      '${vodContent.year.toString()} | ',
                                      style: textTheme.subtitle1,
                                      textAlign: TextAlign.start,
                                    )
                                  : Container(),
                              vodContent.genre != null
                                  ? Text(
                                      '${vodContent.genre.toString()}',
                                      style: textTheme.subtitle1,
                                      textAlign: TextAlign.start,
                                    )
                                  : Container(),
                            ]),
                      ),
                      // Content description
                      Container(
                        child: Text(
                          vodContent.description!,
                          style: textTheme.bodyText1,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  )),
              // Spacer between content in middle
              Container(
                width: 60,
              ),
              // Director, Actors
              Container(
                  height: 162,
                  width: 190,
                  child: Column(
                    children: [
                      // Year
                      vodContent.year != null
                          ? Container(
                              alignment: Alignment.bottomLeft,
                              height: 72,
                              child: IntrinsicHeight(
                                child: Row(children: [
                                  Text(
                                    'Year: ',
                                    style: textTheme.headline6,
                                    textAlign: TextAlign.left,
                                  ),
                                  Expanded(
                                    child: Text(
                                      vodContent.year!,
                                      style: textTheme.bodyText2,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ]),
                              ),
                            )
                          : Container(),
                      // Director
                      vodContent.director != null
                          ? IntrinsicHeight(
                              child: Row(children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text('Director: ',
                                      textAlign: TextAlign.left,
                                      style: textTheme.headline6),
                                ),
                                Expanded(
                                  child: Text(
                                    vodContent.director!,
                                    textAlign: TextAlign.left,
                                    style: textTheme.bodyText2,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]),
                            )
                          : Container(),
                      // Actors
                      vodContent.actors != null
                          ? IntrinsicHeight(
                              child: Row(children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text('Actors: ',
                                      textAlign: TextAlign.left,
                                      style: textTheme.headline6),
                                ),
                                Expanded(
                                  child: Text(
                                    vodContent.actors!,
                                    textAlign: TextAlign.left,
                                    style: textTheme.bodyText2,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]),
                            )
                          : Container(),
                      // Genre
                      vodContent.genre != null
                          ? IntrinsicHeight(
                              child: Row(children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Genre: ',
                                    textAlign: TextAlign.start,
                                    style: textTheme.headline6,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    vodContent.genre!,
                                    textAlign: TextAlign.left,
                                    style: textTheme.bodyText2,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]),
                            )
                          : Container(),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class VodSerialInfo extends StatelessWidget {
  VodSerialInfo({Key? key, required this.vodSerial}) : super(key: key);
  final DefVodSerial vodSerial;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      height: 240,
      width: 960,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Spacer top
          Container(
            height: 0,
            width: 960,
          ),
          Row(
            children: [
              // Spacer - left
              Container(
                width: 180,
                height: 162,
              ),
              // Basic Content info
              Container(
                  width: 480,
                  height: 162,
                  child: Column(
                    children: [
                      // Content Title
                      Container(
                        alignment: Alignment.topLeft,
                        height: 28,
                        child: Text(
                          vodSerial.title!,
                          style: textTheme.headline1,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      // Content meta data
                      Container(
                        height: 28,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // vodSerial.duration != null ? Text('${vodSerial.duration.toString()} | ', style: textTheme.subtitle1, textAlign: TextAlign.start,) : Container(),
                              vodSerial.year != null
                                  ? Text(
                                      '${vodSerial.year.toString()} | ',
                                      style: textTheme.subtitle1,
                                      textAlign: TextAlign.start,
                                    )
                                  : Container(),
                              vodSerial.genre != null
                                  ? Text(
                                      '${vodSerial.genre.toString()}',
                                      style: textTheme.subtitle1,
                                      textAlign: TextAlign.start,
                                    )
                                  : Container(),
                            ]),
                      ),
                      // Content description
                      Container(
                        child: Text(
                          vodSerial.description != null
                              ? vodSerial.description!
                              : '',
                          style: textTheme.bodyText1,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  )),
              // Spacer between content in middle
              Container(
                width: 60,
              ),
              // Director, Actors
              Container(
                  height: 162,
                  width: 190,
                  child: Column(
                    children: [
                      // Year
                      vodSerial.year != null
                          ? Container(
                              alignment: Alignment.bottomLeft,
                              height: 72,
                              child: IntrinsicHeight(
                                child: Row(children: [
                                  Text(
                                    'Year: ',
                                    style: textTheme.headline6,
                                    textAlign: TextAlign.left,
                                  ),
                                  Expanded(
                                    child: Text(
                                      vodSerial.year!,
                                      style: textTheme.bodyText2,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ]),
                              ),
                            )
                          : Container(),
                      // Director
                      vodSerial.director != null
                          ? IntrinsicHeight(
                              child: Row(children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text('Director: ',
                                      textAlign: TextAlign.left,
                                      style: textTheme.headline6),
                                ),
                                Expanded(
                                  child: Text(
                                    vodSerial.director!,
                                    textAlign: TextAlign.left,
                                    style: textTheme.bodyText2,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]),
                            )
                          : Container(),
                      // Actors
                      vodSerial.actors != null
                          ? IntrinsicHeight(
                              child: Row(children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text('Actors: ',
                                      textAlign: TextAlign.left,
                                      style: textTheme.headline6),
                                ),
                                Expanded(
                                  child: Text(
                                    vodSerial.actors!,
                                    textAlign: TextAlign.left,
                                    style: textTheme.bodyText2,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]),
                            )
                          : Container(),
                      // Genre
                      vodSerial.genre != null
                          ? IntrinsicHeight(
                              child: Row(children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Genre: ',
                                    textAlign: TextAlign.start,
                                    style: textTheme.headline6,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    vodSerial.genre!,
                                    textAlign: TextAlign.left,
                                    style: textTheme.bodyText2,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]),
                            )
                          : Container(),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class ShowInfo extends StatelessWidget {
  ShowInfo({Key? key, required this.show}) : super(key: key);
  final Show show;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
        height: 240,
        width: 960,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Spacer top
            Container(
              height: 0,
              width: 960,
            ),
            Row(
              children: [
                // Spacer - left
                Container(
                  width: 180,
                  height: 162,
                ),
                // Basic Content info
                Container(
                    width: 480,
                    height: 162,
                    child: Column(
                      children: [
                        // Content Title
                        Container(
                          alignment: Alignment.topLeft,
                          // height: 28,
                          child: Text(
                            show.title!,
                            style: textTheme.headline1,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                          ),
                        ),
                        // Content meta data
                        Container(
                          height: 28,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${show.displayTimeStartToEnd()} | ',
                                  style: textTheme.subtitle1,
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  '${show.displayDateDay()} | ',
                                  style: textTheme.subtitle1,
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  show.channel!.title!.toUpperCase(),
                                  style: textTheme.subtitle2,
                                )
                              ]),
                        ),
                        // Content description
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            show.description != null ? show.description! : '',
                            style: textTheme.bodyText1,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    )),
                // Spacer between content in middle
                Container(
                  width: 60,
                ),
                // Director, Actors
                Container(
                    height: 162,
                    width: 190,
                    child: Column(
                      children: [
                        Container(
                          height: 58,
                          width: 190,
                        ),
                        // Year
                        // Director
                        show.director != null
                            ? IntrinsicHeight(
                                child: Row(children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text('Director: ',
                                        textAlign: TextAlign.left,
                                        style: textTheme.headline6),
                                  ),
                                  Expanded(
                                    child: Text(
                                      show.director!,
                                      textAlign: TextAlign.left,
                                      style: textTheme.bodyText2,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ]),
                              )
                            : Container(),
                        // Actors
                        show.actors != null
                            ? IntrinsicHeight(
                                child: Row(children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text('Actors: ',
                                        textAlign: TextAlign.left,
                                        style: textTheme.headline6),
                                  ),
                                  Expanded(
                                    child: Text(
                                      show.actors!,
                                      textAlign: TextAlign.left,
                                      style: textTheme.bodyText2,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ]),
                              )
                            : Container(),
                        // Genre
                        show.genre != null
                            ? IntrinsicHeight(
                                child: Row(children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text('Genre: ',
                                        textAlign: TextAlign.left,
                                        style: textTheme.headline6),
                                  ),
                                  Expanded(
                                    child: Text(
                                      show.genre!,
                                      textAlign: TextAlign.left,
                                      style: textTheme.bodyText2,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ]),
                              )
                            : Container(),
                      ],
                    )),
              ],
            )
          ],
        ));
  }
}
