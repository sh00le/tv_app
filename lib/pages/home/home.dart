import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:tv_app/pages/home/home_controller.dart';
import 'package:tv_app/pages/home/menu.dart';
import 'package:tv_app/pages/home/recommendations.dart';
import 'package:tv_app/widgets/content_info.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController homeController = Get.put(HomeController());
  bool selectedSpec = false;
  var selectedContentItem;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context) {
    debugPrint('!!!!!!aaaaaa!!!!!!!');
    homeController.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FocusScope.of(context).requestFocus(_node);
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            height: 75,
            // color: Colors.grey,
          ),
          FocusScope(
            node: homeController.homeStatus.details.focusScopeNode,
            autofocus: true,
            child: GetBuilder<HomeController>(
              id: homeController.homeStatus.details.id,
              builder: (_) => Container(
                  height: 165,
                  child: AnimatedOpacity(
                      opacity: homeController.homeStatus.details.widgetStatus ==
                              Status.hidden
                          ? 0.0
                          : 1.0,
                      duration: Duration(milliseconds: 400),
                      child: ContentInfo(
                          content: homeController.homeStatus.details.data))),
            ),
          ),
          FocusScope(
              node: homeController.homeStatus.recommendations.focusScopeNode,
              child: Recommendations()),
          SizedBox(
            height: 10,
          ),
          FocusScope(
              node: homeController.homeStatus.menu.focusScopeNode,
              child: HomeMenu()),
        ],
      ),
    );
  }
}
