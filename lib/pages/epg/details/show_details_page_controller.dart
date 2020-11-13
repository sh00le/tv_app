import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tv_app/models/Show.dart';
import 'package:tv_app/repository/epg_repository.dart';
import 'package:tv_app/services/repository_service.dart';

class ShowDetailsPageController extends GetxController {
  final RepositoryService _repositoryService = Get.find<RepositoryService>();
  Show show;


  Future getShow(int showId) async {
    EpgRepository _epgRepository = _repositoryService.getEpg();
    if (showId != -1) {
      show = await _epgRepository.show(showId);
      debugPrint('${show.title}');
      update(['show']);
    }
  }
}