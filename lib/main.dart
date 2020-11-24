import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:tv_app/pages/epg/details/show.dart';
import 'package:tv_app/pages/home/home.dart';
import 'package:tv_app/pages/player/player.dart';
import 'package:tv_app/pages/vod/movie/vod_movie.dart';
import 'package:tv_app/pages/vod/serial/vod_serial.dart';
import 'package:tv_app/pages/vod/serial/vod_serial_controller.dart';
import 'package:tv_app/services/repository_service.dart';
import 'package:tv_app/services/style_service.dart';

void main() {
  initServices();
  runApp(TVApp());
}
void initServices() {
  Get.put(RepositoryService());
  Get.put(StyleService());
}

class TVApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Stack (
        alignment: Alignment.topLeft,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              color: Colors.lightBlue,
              child: PlayerApp(),
            ),
          ),
          Container(
            color: Color.fromRGBO(46,101,126,0.75),
          ),
          GetMaterialApp(
            title: 'TV App Demo',
            defaultTransition: Transition.native,
            transitionDuration: Duration(milliseconds: 500),
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'Roboto',
              textTheme:TextTheme(
                headline1: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -1.0, color: Colors.white),
                headline2: GoogleFonts.roboto(fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
                headline3: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: -0.0, color: Colors.white),
                headline4: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.25, color: Colors.white),
                headline5: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
                headline6: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: -0.0, color: Colors.white),
                subtitle1: GoogleFonts.roboto(fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 0.1,  color: Colors.white),
                subtitle2: GoogleFonts.roboto(fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 0.1, color: Colors.blue),
                bodyText1: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: -1.12, color: Colors.white),
                bodyText2: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: -0.6, color: Colors.white),
                button: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
                caption: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
                overline: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),              ),
            ),
            getPages: [
              GetPage(name: "/", page: () => MyStatelessWidget()),
              GetPage(name: '/epg/show', page: () => ShowDetailsPage()),
              GetPage(name: '/vod/movie', page: () => VodMovieDetailsPage()),
              GetPage(name: '/vod/serial', page: () => VodSerialDetailsPage()),
              GetPage(name: '/svod/movie', page: () => VodMovieDetailsPage()),
              GetPage(name: '/svod/serial', page: () => VodSerialDetailsPage()),
            ],
            // home: Scaffold(
            //   body: MyStatelessWidget(),
            // ),
          ),
      ]
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: DefaultTextStyle(
          style: textTheme.headline6,
          child: Center(
              child: Container (
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // PlayerApp(),
                        Container(
                          // color: Colors.black45,
                          child: Home(),
                        )
                      ]
                  )
              )
          )
      ),
    );
  }

  Future<bool> _onBackPressed() {
    debugPrint('_onBackPressed');
    return Get.defaultDialog(
        title: 'Ready to quit?',
        backgroundColor: Colors.blueGrey,
        titleStyle: Get.context.textTheme.headline3,
        middleText: '',
        cancelTextColor: Colors.black,
        confirmTextColor: Colors.black,
        textCancel: 'No',
        textConfirm: 'Yes',
        onCancel: () {
          debugPrint('_onBackPressed - onCancel');
        },
        onConfirm: () {
          Navigator.pop(Get.context, true);
        }
    );
  }
}