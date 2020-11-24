import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sticky_infinite_list/models/alignments.dart';
import 'package:tv_app/pages/vod/serial/vod_serial_controller.dart';
import 'package:tv_app/widgets/content_list/contentListItem.dart';
import 'package:tv_app/widgets/image_network/imageNetwork.dart';
import 'package:tv_app/widgets/tv_infinity_scroll.dart';

class VodSerialDetailsPage extends StatelessWidget {
  final VodSerialDetailsPageController _controller = Get.put(VodSerialDetailsPageController());

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Color _focusedColor = Color.fromRGBO( 46,101,126,0.5);

    debugPrint('VodSerialDetailsPage');
    _controller.getSerial(Get.arguments);

    return DefaultTextStyle(
      style: textTheme.headline6,
      child: Container(
        width: 950,
        child: GetBuilder<VodSerialDetailsPageController>(
          id: _controller.serialStatus.id,
          builder: ( _ ) => _.vodSerial == null ? Container() :
            Shortcuts(
              shortcuts: <LogicalKeySet, Intent>{
                LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
              },
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  // Serial data, actions
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
                              FocusScope(
                                node: _.serialStatus.action.focusNode,
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  color: Colors.black45,
                                  width: 170,
                                // height: 174,
                                  child: ListView.builder(
                                    itemExtent: 40,
                                    itemCount: _.serialStatus.action.actions.length,
                                    itemBuilder: (context, index) {
                                      return FlatButton(
                                      autofocus: index == 0 ? true : false,
                                      focusColor: _focusedColor,
                                      onPressed: () => {
                                        debugPrint('pressed ${_.serialStatus.action.actions[index].title}')
                                      },
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(_.serialStatus.action.actions[index].title, textAlign: TextAlign.right, style: textTheme.headline4,)
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ),
                              Container(
                                width: 10,
                              ),
                              // Basic Content info
                              FocusScope(
                                node: _.serialStatus.content.focusNode,
                                child: GetBuilder<VodSerialDetailsPageController>(
                                  id: _.serialStatus.content.id,
                                  builder: (_) => Container(
                                    width: 430,
                                    // height: 340,
                                    child: Column(
                                      children: [
                                        // Content Title
                                        Container(
                                          // color: Colors.yellow,
                                          alignment: Alignment.topLeft,
                                          // height: 28,
                                          child: Text(_.serialStatus.content.data.title, style: textTheme.headline1,  textAlign: TextAlign.left,),
                                        ),
                                        // Content meta data
                                        Container(
                                          height: 28,
                                          child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('${_.serialStatus.content.data.year} | ', style: textTheme.subtitle1, textAlign: TextAlign.start,),
                                                Text(_.serialStatus.content.data.year != null ? _.serialStatus.content.data.year : '', style: textTheme.subtitle2,)
                                              ]
                                          ),
                                        ),
                                        // Content description
                                        Container(
                                          alignment: Alignment.topLeft,
                                          height: 164,
                                          child: Text(
                                            _.serialStatus.content.data.description != null ? _.serialStatus.content.data.description : '',
                                            style: textTheme.bodyText1,
                                            maxLines: 7,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        // Seasons
                                        FocusScope(
                                          node: _.serialStatus.season.focusNode,
                                          child: Container(
                                            padding: EdgeInsets.only(top: 20),
                                            height: 48,
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: _.vodSerial.seasons.length,
                                              itemBuilder: (context, index) {
                                                return RawMaterialButton(
                                                  focusNode: _.serialStatus.season.seasons[index].focusNode,
                                                  focusColor: Colors.black45,
                                                  focusElevation: 100,
                                                  onPressed: () {
                                                    debugPrint('aa');
                                                  },
                                                  child: Text(_.vodSerial.seasons[index].getSeasonTitle()),
                                                );
                                              },
                                              separatorBuilder: (context, index) {
                                                return SizedBox(width: 5,);
                                              }
                                            )
                                          ),
                                        ),
                                      ],
                                    )
                              ),
                                ),
                              ),
                              // Spacer between content in middle
                              Container(
                                height: 90,
                                width: 52,
                              ),
                              // Show image, Director, Actors
                              Container(
                                // color: Colors.white38,
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
                                        child: ImageNetwork(url: _.vodSerial.imageVariation('M', 'poster'), type: 'poster', variation: 'M'),
                                    ),
                                      // Director
                                      Container(
                                        height: 20
                                    ),
                                      Container(
                                        alignment: Alignment.bottomLeft,
                                        child: _.serialStatus.content.data.year != null ? IntrinsicHeight(
                                        child: Row(
                                            children: [
                                              Text('Year: ', style: textTheme.headline6, textAlign: TextAlign.left,),
                                              Expanded (
                                                child: Text(_.serialStatus.content.data.year, style: textTheme.bodyText2, textAlign: TextAlign.left,),
                                              ),
                                            ]
                                        ),
                                      ) : Container(),
                                    ),
                                      _.serialStatus.content.data.director != null ? IntrinsicHeight(
                                      child: Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: Text('Director: ',
                                                  textAlign: TextAlign.left, style: textTheme.headline6),
                                            ),
                                            Expanded (
                                              child: Text(_.serialStatus.content.data.director,
                                                textAlign: TextAlign.left, style: textTheme.bodyText2, maxLines: 2, overflow: TextOverflow.ellipsis,),
                                            ),
                                          ]
                                      ),
                                    ) : Container(),
                                      // Actors
                                      _.serialStatus.content.data.actors != null ? IntrinsicHeight(
                                      child: Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: Text('Actors: ',
                                                  textAlign: TextAlign.left, style: textTheme.headline6),
                                            ),
                                            Expanded (
                                              child: Text(_.serialStatus.content.data.actors,
                                                textAlign: TextAlign.left, style: textTheme.bodyText2, maxLines: 2, overflow: TextOverflow.ellipsis,),
                                            ),
                                          ]
                                      ),
                                    ) : Container(),
                                      // Genre
                                      _.serialStatus.content.data.genre != null ? IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: Text('Genre: ',
                                                  textAlign: TextAlign.left, style: textTheme.headline6),
                                            ),
                                            Expanded (
                                              child: Text(_.serialStatus.content.data.genre,
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
                  // Episode list
                  Container(
                    padding: EdgeInsets.only(left: 172, top: 340),
                    // color: Colors.yellow,
                    height: 500,
                    // width: 960,
                    // Episode list
                    child: GetBuilder<VodSerialDetailsPageController>(
                      id: _controller.serialStatus.episode.id,
                      builder: (_) => FocusScope(
                        node: _.serialStatus.episode.focusNode,
                        child: Container(
                          height: 165,
                          child: AnimatedOpacity(
                            opacity: _.serialStatus.episode.data.isEmpty ? 0.0 : 1.0,
                            duration: Duration(milliseconds: 400),
                            child: _.serialStatus.episode.data.isEmpty  ? Container() : TVInfiniteListView(
                              controller: Get.find<VodSerialDetailsPageController>().episodeListController,
                              direction: InfiniteListDirection.multi,
                              scrollDirection: Axis.horizontal,
                              itemCount: _.serialStatus.episode.data.length,
                              itemSize: 121,
                              selectedItemIndex: 0,
                              loop: false,
                              itemBuilder: (context, index, selected) {
                                bool isSelected = (_.serialStatus.episode.focusNode.hasFocus && selected) ? true : false;
                                return ContentListItem(item: _.serialStatus.episode.data[index], selected: isSelected);
                              },
                              onItemSelected: (selectedIndex) {
                                _.onEpisodeSelected(_.serialStatus.episode.data[selectedIndex]);
                                // if (_.homeStatus.recommendations.inFocus) {
                                //   _homeController.onRecommendationSelect(_.homeStatus.recommendations.data[selectedIndex]);
                                // }
                              },
                              onScrollStart: () {
                                // SchedulerBinding.instance.addPostFrameCallback((_) {
                                //   _homeController.onRecommendationScrollStart();
                                // });
                              },
                              onScrollEnd: () {
                                // SchedulerBinding.instance.addPostFrameCallback((_) {
                                //   _homeController.onScrollEnd();
                                // });
                              },
                            ),
                          ),
                        ),
                      )
                    ),
                  ),
                ]
              ),
            ),
        ),
      ),
    );
  }
}