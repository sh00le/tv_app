import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:tv_app/pages/home/home_controller.dart';
import 'package:tv_app/widgets/tv_infinity_scroll.dart';
import 'package:tv_app/widgets/content_item_list.dart';
import 'package:sticky_infinite_list/sticky_infinite_list.dart';

class Recommendations extends StatelessWidget {
  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      child: GetBuilder<HomeController>(
        id: _homeController.homeStatus.recommendations.id,
        builder: (_) {
          return AnimatedOpacity(
            opacity: _.homeStatus.recommendations.widgetStatus == Status.hidden ? 0.0 : 1.0,
            duration: Duration(milliseconds: 400),
            child: (_.items.length == 0 || _.homeStatus.recommendations.widgetStatus == Status.hidden) ? Container() : TVInfiniteListView(
              controller: Get.find<HomeController>().recoController,
              direction: InfiniteListDirection.multi,
              scrollDirection: Axis.horizontal,
              itemCount: _.items.length,
              itemSize: 121,
              selectedItemIndex: 0,
              loop: true,
              itemBuilder: (context, index, selected) {
                bool isSelected = (_.homeStatus.recommendations.inFocus && selected) ? true : false;
                return ContentListItem(
                    item: _.items[index], selected: isSelected);
              },
              onItemSelected: (selectedIndex) {
                if (_.homeStatus.recommendations.inFocus) {
                  _homeController.onRecommendationSelect(_.items[selectedIndex]);
                }
              },
              onScrollStart: () {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  _homeController.onRecommendationScrollStart();
                });
              },
              onScrollEnd: () {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  _homeController.onScrollEnd();
                });
              },
            ),
          );
        }
      )
    );
  }

}