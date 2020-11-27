import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:tv_app/models/Menu.dart';
import 'package:tv_app/pages/home/home_controller.dart';
import 'package:tv_app/widgets/tv_infinity_scroll.dart';
import 'package:sticky_infinite_list/sticky_infinite_list.dart';

class HomeMenu extends StatelessWidget {
  final HomeController _homeController = Get.find<HomeController>();
  final TVInfiniteScrollController _controller = Get.find<HomeController>().menuController;
  final List<Menu> _menu = _menuItems.map((item) => Menu.fromMap(item)).toList();


  @override
  Widget build(BuildContext context) {
    return Container(
          height: 85,
          child: GetBuilder<HomeController>(
            id: _homeController.homeStatus.menu.id,
            builder: (_) {
              return TVInfiniteListView(
                controller: _controller,
                direction: InfiniteListDirection.multi,
                scrollDirection: Axis.horizontal,
                itemCount: _menu.length,
                itemSize: 124,
                selectedItemIndex: 0,
                loop: true,
                itemBuilder: (context, index, selected){
                  bool _isSelected = _homeController.homeStatus.menu.focusScopeNode.hasFocus && selected ? true : false;
                  return MenuListItem(item: _menu[index], selected: _isSelected);
                },
                onItemSelected: (selectedIndex) {
                  _homeController.onMenuSelect(_menu[selectedIndex]);
                },
                onScrollStart: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    _homeController.onMenuScrollStart();
                  });
                },
                onScrollEnd: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    _homeController.onScrollEnd();
                  });
                },
              );
            }
          )
      );
  }
}

class MenuListItem extends StatelessWidget {
  MenuListItem({Key key, this.item, this.selected}) : super(key: key);
  final Menu item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 87,
      margin: EdgeInsets.only(left: 2, right: 2),
      decoration: BoxDecoration(
        border: selected ? Border.all(width: 2, color: Colors.white) : Border.all(width: 2, color: Colors.transparent),
        color: Colors.black54,
        image: selected ? DecorationImage(
          image: AssetImage("assets/menu_bg_selected.png"),
          fit: BoxFit.cover,
        ): null,
      ),
      child: Column(
          children: <Widget> [
            SizedBox(
              height: 15,
            ),
            Image(
                width: 32,
                height: 25,
                image: AssetImage(item.icon)
            ),
            SizedBox(
              height: 15,
            ),
            Text(
                item.title,
                style: TextStyle(
                  color: Colors.white,
                )
            )
          ]
      ),
    );
  }
}

/// Menu items
List<Map<String, String>> _menuItems = [
  {
    'title': 'MyTV',
    'icon': 'assets/menu_mytv.png',
    'recommendation': 'all'
  },
  {
    'title': 'EPG',
    'icon': 'assets/menu_live.png',
    'recommendation': 'epg'
  },
  {
    'title': 'nPVR',
    'icon': 'assets/menu_npvr.png',
    'recommendation': 'npvr'
  },
  {
    'title': 'VOD',
    'icon': 'assets/menu_vod.png',
    'recommendation': 'vod'
  },
  {
    'title': 'SVOD',
    'icon': 'assets/menu_mytv.png',
    'recommendation': 'svod'
  },
  {
    'title': 'PPV',
    'icon': 'assets/menu_npvr.png',
    'recommendation': 'ppv'
  },
  {
    'title': 'Search',
    'icon': 'assets/menu_search.png',
    'recommendation': null
  },
  {
    'title': 'Settings',
    'icon': 'assets/menu_settings.png',
    'recommendation': null
  }
];

