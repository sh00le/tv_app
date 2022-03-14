import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:tv_app/pages/epg/details/show_details_page_controller.dart';
import 'package:tv_app/services/style_service.dart';
import 'package:tv_app/widgets/image_network/imageNetwork.dart';

class ShowDetailsPage extends StatelessWidget {
  final StyleService _style = Get.find<StyleService>();
  final ShowDetailsPageController _controller =
      Get.put(ShowDetailsPageController());

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    _controller.init();
    _controller.getShow(Get.arguments);

    return DefaultTextStyle(
      style: textTheme.headline6!,
      child: Container(
        width: 950,
        child: GetBuilder<ShowDetailsPageController>(
          id: _controller.showDetailsStatus.id,
          builder: (_) => _.show == null
              ? Container()
              : Container(
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
                                LogicalKeySet(LogicalKeyboardKey.select):
                                    ActivateIntent(),
                              },
                              child: Container(
                                alignment: Alignment.topCenter,
                                color: Colors.black45,
                                width: 170,
                                // height: 174,
                                child: FocusScope(
                                  node: _.showDetailsStatus.action.focusNode,
                                  child: ListView.builder(
                                    itemExtent: 40,
                                    itemCount: _.showDetailsStatus.action
                                        .actions.length,
                                    itemBuilder: (context, index) {
                                      return TextButton(
                                        autofocus: index == 0 ? true : false,
                                        // focusColor: _style.actionFocusedColor,
                                        style: ButtonStyle(
                                          overlayColor: MaterialStateProperty
                                              .resolveWith<Color?>(
                                                  (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.focused))
                                              return _style.actionFocusedColor;
                                            return null;
                                          }),
                                        ),
                                        onPressed: () {
                                          debugPrint(
                                              'pressed ${_.showDetailsStatus.action.actions[index].title}');
                                          _.onActionSubmit(_.showDetailsStatus
                                              .action.actions[index]);
                                        },
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              _.showDetailsStatus.action
                                                  .actions[index].title!,
                                              textAlign: TextAlign.right,
                                              style: textTheme.headline4,
                                            )),
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
                                      // height: 28,
                                      child: Text(
                                        _.show!.title!,
                                        style: textTheme.headline1,
                                        textAlign: TextAlign.left,
                                        maxLines: 2,
                                      ),
                                    ),
                                    // Content meta data
                                    Container(
                                      height: 28,
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${_.show!.displayTimeStartToEnd()} | ',
                                              style: textTheme.subtitle1,
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '${_.show!.displayDateDay()} | ',
                                              style: textTheme.subtitle1,
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              _.show!.channel!.title!
                                                  .toUpperCase(),
                                              style: textTheme.subtitle2,
                                            )
                                          ]),
                                    ),
                                    // Content description
                                    Container(
                                      alignment: Alignment.topLeft,
                                      height: 160,
                                      child: Text(
                                        _.show!.description!,
                                        style: textTheme.bodyText1,
                                        maxLines: 11,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    // Actions
                                  ],
                                )),
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
                                        image: AssetImage(
                                          'assets/icons/ic_arrow-up.png',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 15,
                                      height: 15,
                                      child: Image(
                                        image: AssetImage(
                                          'assets/icons/ic_arrow-down.png',
                                        ),
                                      ),
                                    )
                                  ],
                                )),
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
                                      width: 236,
                                      height: 132,
                                      child: ImageNetwork(
                                          url: _.show!
                                              .imageVariation('XL', 'still')!,
                                          type: 'still',
                                          variation: 'M'),
                                    ),
                                    Container(
                                      //color: Colors.orange,
                                      width: 236,
                                      height: 43,
                                      child: Row(
                                        children: [
                                          Text(
                                            _.show!.displayStartTime(),
                                            style: textTheme.bodyText1,
                                            textAlign: TextAlign.left,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: 170,
                                            height: 4,
                                            child: Stack(
                                                // alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    width: 155,
                                                    color: Color.fromRGBO(
                                                        46, 101, 126, 1.0),
                                                  ),
                                                  Container(
                                                    width: _.show!
                                                        .showProgress(155),
                                                    color: Color.fromRGBO(
                                                        0, 158, 222, 1.0),
                                                  ),
                                                ]),
                                          ),
                                          Text(
                                            _.show!.displayEndTime(),
                                            style: textTheme.bodyText1,
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Director
                                    _.show!.director != null
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
                                                  _.show!.director!,
                                                  textAlign: TextAlign.left,
                                                  style: textTheme.bodyText2,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ]),
                                          )
                                        : Container(),
                                    // Actors
                                    _.show!.actors != null
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
                                                  _.show!.actors!,
                                                  textAlign: TextAlign.left,
                                                  style: textTheme.bodyText2,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ]),
                                          )
                                        : Container(),
                                    // Genre
                                    _.show!.genre != null
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
                                                  _.show!.genre!,
                                                  textAlign: TextAlign.left,
                                                  style: textTheme.bodyText2,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ]),
                                          )
                                        : Container(),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      // Container(
                      //   // color: Colors.red,
                      //   width: 960,
                      //   height: 154,
                      //   child: Column(
                      //     children: [
                      //       Text('More like this', style: textTheme.bodyText2,),
                      //       Container(
                      //         height: 10,
                      //       ),
                      //       Image(
                      //           width: 15,
                      //           height: 15,
                      //           image: AssetImage('assets/icons/ic_arrow-down.png')
                      //       ),
                      //       Container(
                      //         height: 20,
                      //       ),
                      //       Container(
                      //           height: 1,
                      //           color: Colors.white
                      //       )
                      //     ],
                      //   ),
                      // )
                    ],
                  )),
        ),
      ),
    );
  }
}
