import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:tv_app/pages/home/home_controller.dart';
import 'package:tv_app/pages/home/menu.dart';
import 'package:tv_app/pages/home/recommendations.dart';
import 'package:tv_app/widgets/content_info.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController homeController = Get.put(HomeController());
  bool selectedSpec = false;
  var selectedContentItem;
  final FocusNode _focusNode = FocusNode();



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context) {
    debugPrint('!!!!!!aaaaaa!!!!!!!');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FocusScope.of(context).requestFocus(_node);
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey:  homeController.handleKeyEvent,
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 75,
              // color: Colors.grey,
            ),
            GetBuilder<HomeController>(
              id: homeController.homeStatus.details.id,
              builder: (_) => Container(
                  height: 165,
                  child: AnimatedOpacity(
                      opacity: homeController.homeStatus.details.widgetStatus == Status.hidden ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 400),
                      child: ContentInfo(content: homeController.homeStatus.details.data)
                  )
              ),
            ),
            Recommendations(),
            SizedBox(
              height: 10,
            ),
            HomeMenu(),
          ],
        ),
      ),
    );
  }
}