import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Player Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Player(),
      ),
    );
  }

}

class Player extends StatefulWidget {
  Player({Key key}) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      'http://195.29.70.31/PLTV/88888888/224/3221226027/index.m3u8?rrsip=195.29.70.31&zoneoffset=0&servicetype=1&icpid=&accounttype=1&limitflux=-1&limitdur=-1&accountinfo=Q80g0XTDyaE%2FJEc5w0w2K9fOaKtSzari50kMNzqgKG9QKGGlW9jhZHHh7fo0IOKaICtDLdawlNbGDmhvN2SbnCS85lCCdme5Aqhdq12RNJU958IBIGP68pUzKSgO3xe0lTG1Yv0F6OZP%2FPnhQRSQuG12lmOBaSXsZ3ghSz%2FEFzU%3D%3A20200218092102%3AUTC%2C1001610422%2C195.29.4.38%2C20200218092102%2CXTV100001580%2CAAFD9D882FFC1CB2F8123EFCE5FFFF15%2C-1%2C0%2C1%2C%2C%2C2%2C1000010122%2C%2C%2C2%2C1000220050%2C0%2C1000220050%2ClLPgKhNHgCey%2BuD5C50vA8UGpVs%3D%2C2%2CEND&GuardEncType=2',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    _controller.play();

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return VideoPlayer(_controller);
            // return AspectRatio(
            //   aspectRatio: _controller.value.aspectRatio,
            //   // Use the VideoPlayer widget to display the video.
            //   child: VideoPlayer(_controller),
            // );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Wrap the play or pause in a call to `setState`. This ensures the
      //     // correct icon is shown.
      //     setState(() {
      //       // If the video is playing, pause it.
      //       if (_controller.value.isPlaying) {
      //         _controller.pause();
      //       } else {
      //         // If the video is paused, play it.
      //         _controller.play();
      //       }
      //     });
      //   },
      //   // Display the correct icon depending on the state of the player.
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}