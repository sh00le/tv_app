import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:tv_app/pages/home/home_controller.dart';
import 'package:tv_app/widgets/content_list/contentListItem.dart';
import 'package:tv_app/widgets/tv_infinity_scroll.dart';
import 'package:sticky_infinite_list/sticky_infinite_list.dart';

class Recommendations extends StatelessWidget {
  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Container(
          height: 170,
          child: GetBuilder<HomeController>(
              id: _homeController.homeStatus.recommendations.id,
              builder: (_) {
                return AnimatedOpacity(
                  opacity:
                      _.homeStatus.recommendations.widgetStatus == Status.hidden
                          ? 0.0
                          : 1.0,
                  duration: Duration(milliseconds: 400),
                  child: (_.homeStatus.recommendations.data!.length == 0 ||
                          _.homeStatus.recommendations.widgetStatus ==
                              Status.hidden)
                      ? Container()
                      : TVInfiniteListView(
                          controller: Get.find<HomeController>().recoController,
                          direction: InfiniteListDirection.multi,
                          scrollDirection: Axis.horizontal,
                          itemCount: _.homeStatus.recommendations.data!.length,
                          itemSize: 121,
                          selectedItemIndex: 0,
                          loop: true,
                          itemBuilder: (context, index, selected) {
                            bool isSelected = (_.homeStatus.recommendations
                                        .focusScopeNode.hasFocus &&
                                    selected)
                                ? true
                                : false;
                            return ContentListItem(
                                item: _.homeStatus.recommendations.data![index],
                                selected: isSelected);
                          },
                          onItemSelected: (selectedIndex) {
                            if (_.homeStatus.recommendations.focusScopeNode
                                .hasFocus) {
                              _homeController.onRecommendationSelect(_
                                  .homeStatus
                                  .recommendations
                                  .data![selectedIndex]);
                            }
                          },
                          onScrollStart: () {
                            SchedulerBinding.instance
                                ?.addPostFrameCallback((_) {
                              _homeController.onRecommendationScrollStart();
                            });
                          },
                          onScrollEnd: () {
                            SchedulerBinding.instance
                                ?.addPostFrameCallback((_) {
                              _homeController.onScrollEnd();
                            });
                          },
                        ),
                );
              })),
    );
  }
}
