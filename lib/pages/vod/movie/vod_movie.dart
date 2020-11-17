import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tv_app/pages/vod/movie/vod_movie_controller.dart';
import 'package:tv_app/services/style_service.dart';
import 'package:tv_app/widgets/image_network/imageNetwork.dart';

class VodMovieDetailsPage extends StatelessWidget {
  final VodMovieDetailsPageController _controller = Get.put(VodMovieDetailsPageController());

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    _controller.getMovie(Get.arguments);

    return DefaultTextStyle(
      style: textTheme.headline6,
      child: Container(
        width: 950,
        child: GetBuilder<VodMovieDetailsPageController>(
          id: 'movie',
          builder: ( _ ) => _.vodMovie == null ? Container() :
          Container(
            // height: 350,
              width: 960,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Spacer top
                  Container(
                    height: 74,
                    width: 960,
                  ),
                  Container(
                    height: 280,
                    width: 960,
                    child: Row(
                      children: [
                        // Spacer - left
                        Container(
                          width: 180,
                          height: 172,
                        ),
                        // Basic Content info
                        Container(
                            width: 430,
                            // height: 340,
                            child: Column(
                              children: [
                                // Content Title
                                Container(
                                  // color: Colors.yellow,
                                  alignment: Alignment.topLeft,
                                  height: 28,
                                  child: Text(_.vodMovie.title, style: textTheme.headline1,  textAlign: TextAlign.left,),
                                ),
                                // Content meta data
                                Container(
                                  height: 28,
                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${_.vodMovie.displayDuration()} | ', style: textTheme.subtitle1, textAlign: TextAlign.start,),
                                        Text(_.vodMovie.displayPrice(), style: textTheme.subtitle2,)
                                      ]
                                  ),
                                ),
                                // Content description
                                Container(
                                  height: 160,
                                  child: Text(
                                    _.vodMovie.description != null ? _.vodMovie.description : '',
                                    style: textTheme.bodyText1,
                                    maxLines: 7,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // Actions
                                Container(
                                  // color: Colors.deepPurple,
                                  height: 30,
                                  child: ListView(
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      FlatButton.icon(
                                          icon: Icon(Icons.play_arrow),//icon image
                                          label: Text('WATCH', style: textTheme.bodyText1),//text to show in button
                                          textColor: Colors.white,//button text and icon color.
                                          color: Color.fromRGBO(46,101,126,1.0),//button background color
                                          onPressed: () {}
                                      ),
                                      Container(width: 10, height: 10,),
                                      FlatButton.icon(
                                          icon: Icon(Icons.favorite),//icon image
                                          label: Text('FAVORITE', style: textTheme.bodyText1),//text to show in button
                                          textColor: Colors.white,//button text and icon color.
                                          color: Color.fromRGBO(46,101,126,1.0),//button background color
                                          onPressed: () {}
                                      ),
                                      Container(width: 10, height: 10,),
                                      FlatButton.icon(
                                          icon: Icon(Icons.watch_later_outlined),//icon image
                                          label: Text('REMINDER', style: textTheme.bodyText1),//text to show in button
                                          textColor: Colors.white,//button text and icon color.
                                          color: Color.fromRGBO(46,101,126,1.0),//button background color
                                          onPressed: () {}
                                      ),
                                      Container(width: 10, height: 10,),
                                      FlatButton.icon(
                                          icon: Icon(Icons.star_border),//icon image
                                          label: Text('RATE', style: textTheme.bodyText1),//text to show in button
                                          textColor: Colors.white,//button text and icon color.
                                          color: Color.fromRGBO(46,101,126,1.0),//button background color
                                          onPressed: () {}
                                      ),
                                      Container(width: 10, height: 10,),
                                    ],
                                  ),
                                  // width: 200
                                )
                              ],
                            )
                        ),
                        // Spacer between content in middle
                        Container(
                            height: 90,
                            width: 52,
                            child: Column(
                              children: [
                                Container(
                                  width: 15,
                                  height: 15,
                                  child: Image(
                                    image: AssetImage('assets/icons/ic_arrow-up.png',),
                                  ),
                                ),
                                Container(
                                  width: 15,
                                  height: 15,
                                  child: Image(
                                    image: AssetImage('assets/icons/ic_arrow-down.png',),
                                  ),
                                )
                              ],
                            )

                        ),
                        // Show image, Director, Actors
                        Container(
                          // height: 340,
                            width: 236,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Spacer
                                Container(
                                  width: 190,
                                ),
                                // Show image
                                Container(
                                  width: 116,
                                  height: 165,
                                  child: ImageNetwork(url: _.vodMovie.imageVariation('M', 'poster').imageUrl, type: 'poster', variation: 'M'),
                                ),
                                // Director
                                Container(
                                    height: 20
                                ),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: _.vodMovie.year != null ? IntrinsicHeight(
                                    child: Row(
                                        children: [
                                          Text('Year: ', style: textTheme.headline6, textAlign: TextAlign.left,),
                                          Expanded (
                                            child: Text(_.vodMovie.year, style: textTheme.bodyText2, textAlign: TextAlign.left,),
                                          ),
                                        ]
                                    ),
                                  ) : Container(),
                                ),
                                _.vodMovie.director != null ? IntrinsicHeight(
                                  child: Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text('Director: ',
                                              textAlign: TextAlign.left, style: textTheme.headline6),
                                        ),
                                        Expanded (
                                          child: Text(_.vodMovie.director,
                                            textAlign: TextAlign.left, style: textTheme.bodyText2, maxLines: 2, overflow: TextOverflow.ellipsis,),
                                        ),
                                      ]
                                  ),
                                ) : Container(),
                                // Actors
                                _.vodMovie.actors != null ? IntrinsicHeight(
                                  child: Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text('Actors: ',
                                              textAlign: TextAlign.left, style: textTheme.headline6),
                                        ),
                                        Expanded (
                                          child: Text(_.vodMovie.actors,
                                            textAlign: TextAlign.left, style: textTheme.bodyText2, maxLines: 2, overflow: TextOverflow.ellipsis,),
                                        ),
                                      ]
                                  ),
                                ) : Container(),
                                // Genre
                                _.vodMovie.genre != null ? IntrinsicHeight(
                                  child: Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text('Genre: ',
                                              textAlign: TextAlign.left, style: textTheme.headline6),
                                        ),
                                        Expanded (
                                          child: Text(_.vodMovie.genre,
                                            textAlign: TextAlign.left, style: textTheme.bodyText2, maxLines: 2, overflow: TextOverflow.ellipsis,),
                                        ),
                                      ]
                                  ),
                                ) : Container(),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.red,
                    width: 960,
                    height: 154,
                    child: Column(
                      children: [
                        Text('More like this', style: textTheme.bodyText2,),
                        Container(
                          height: 10,
                        ),
                        Image(
                            width: 15,
                            height: 15,
                            image: AssetImage('assets/icons/ic_arrow-down.png')
                        ),
                        Container(
                          height: 20,
                        ),
                        Container(
                            height: 1,
                            color: Colors.white
                        )
                      ],
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}