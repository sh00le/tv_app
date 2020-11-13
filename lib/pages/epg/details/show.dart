import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tv_app/models/Show.dart';
import 'package:tv_app/pages/epg/details/show_details_page_controller.dart';
import 'package:tv_app/services/style_service.dart';
import 'package:tv_app/widgets/image_network/imageNetwork.dart';

class ShowDetailsPage extends StatelessWidget {
  final StyleService _style = Get.find<StyleService>();
  final ShowDetailsPageController _controller = Get.put(ShowDetailsPageController());

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    _controller.getShow(Get.arguments);

    return DefaultTextStyle(
      style: textTheme.headline6,
      child: Container(
        width: 950,
        child: GetBuilder<ShowDetailsPageController>(
          id: 'show',
          builder: ( _ ) => _.show == null ? Container() : Row(
              children:<Widget>[
                Container(
                    width: 464,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _.show.title,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          style: _style.contentTitle,
                        ),
                        Text(
                          '1h 36min | ${_.show.startTime} - ${_.show.endTime} | ${_.show.channel.title}',
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          style: _style.metaData,
                        ),
                        SizedBox(
                            height: 20
                        ),
                        Text(
                          '${_.show.description}',
                          textAlign: TextAlign.left,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: _style.contentInfo,
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

                        Container(
                          width: 200,
                          child: ImageNetwork(url: _.show.imageVariation('XL', 'still').imageUrl, type: 'still', variation: 'M'),
                          ),
                        Text(
                          'Director: ${_.show.director}',
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: _style.metaDataTitle,
                        ),
                        Text(
                          'Actors: ${_.show.actors}',
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: _style.metaDataTitle,
                        )
                      ]
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}