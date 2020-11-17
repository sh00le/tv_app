import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tv_app/models/VodMovie.dart';
import 'package:tv_app/repository/vod_repository.dart';
import 'package:tv_app/services/repository_service.dart';

class VodMovieDetailsPageController extends GetxController {
  final RepositoryService _repositoryService = Get.find<RepositoryService>();
  var vodMovie;


  Future getMovie(Map<String, dynamic> movieInfo) async {
    var repository;
    int movieId = int.parse(movieInfo['movieId']);
    if (movieInfo['type'] == 'vod') {
      repository = _repositoryService.getVod();
    } else {
      repository = _repositoryService.getSvod();
    }

    if (movieId != -1) {
      vodMovie = await repository.movie(movieId);
      debugPrint('${vodMovie.title}');
      update(['movie']);
    }
  }
}