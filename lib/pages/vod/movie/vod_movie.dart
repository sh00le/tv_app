import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tv_app/pages/vod/movie/vod_movie_controller.dart';
import 'package:tv_app/services/style_service.dart';
import 'package:tv_app/widgets/image_network/imageNetwork.dart';

class VodMovieDetailsPage extends StatelessWidget {
  final StyleService _style = Get.find<StyleService>();
  final VodMovieDetailsPageController _controller = Get.put(VodMovieDetailsPageController());

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    _controller.init();
    _controller.getMovie(Get.arguments);

    return DefaultTextStyle(
      style: textTheme.headline6,
      child: Container(
        width: 950,
        child: GetBuilder<VodMovieDetailsPageController>(
          id: _controller.movieDetailsStatus.id,
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
                    height: 466,
                    width: 960,
                    child: Row(
                      children: [
                        // Spacer - left
                        Shortcuts(
                          shortcuts: <LogicalKeySet, Intent>{
                            LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
                          },
                          child: Container(
                            alignment: Alignment.topCenter,
                            color: Colors.black45,
                            width: 170,
                          // height: 174,
                            child: FocusScope(
                              node: _.movieDetailsStatus.action.focusNode,
                              child: ListView.builder(
                                itemExtent: 40,
                                itemCount: _.movieDetailsStatus.action.actions.length,
                                itemBuilder: (context, index) {
                                  return FlatButton(
                                    autofocus: index == 0 ? true : false,
                                    focusColor: _style.actionFocusedColor,
                                    onPressed: () {
                                      debugPrint('pressed ${_.movieDetailsStatus.action.actions[index].title}');
                                      _.onActionSubmit(_.movieDetailsStatus.action.actions[index]);
                                    },
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(_.movieDetailsStatus.action.actions[index].title, textAlign: TextAlign.right, style: textTheme.headline4,)
                                    ),
                                  );
                                },
                              ),
                              ),
                          ),
                        ),
                        Container(
                        width: 10,
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
                                  alignment: Alignment.topLeft,
                                  height: 160,
                                  child: Text(
                                    _.vodMovie.description != null ? _.vodMovie.description : '',
                                    style: textTheme.bodyText1,
                                    maxLines: 7,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
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
                                  child: ImageNetwork(url: _.vodMovie.imageVariation('M', 'poster'), type: 'poster', variation: 'M'),
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
                ],
              )
          ),
        ),
      ),
    );
  }
}