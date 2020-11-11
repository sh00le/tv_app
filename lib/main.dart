import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tv_app/pages/home/home.dart';
import 'package:tv_app/pages/player/player.dart';
import 'package:tv_app/services/repository_service.dart';

void main() {
  initServices();
  runApp(TVApp());
}
void initServices() {
  Get.put(RepositoryService());
}

class TVApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TV App Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return DefaultTextStyle(
        style: textTheme.headline6,
        child: Center(
            child: Container (
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Player(),
                      Container(
                        color: Colors.black54,
                        child: Home(),
                      )
                    ]
                )
            )
        )
    );
  }
}