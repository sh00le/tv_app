import 'package:tv_app/repository/epg_repository.dart';
import 'package:tv_app/repository/recommendation_repository.dart';
import 'package:tv_app/repository/vod_repository.dart';
import 'package:tv_app/repository/svod_repository.dart';

import 'package:get/get.dart';

class RepositoryService extends GetxService {
  EpgRepository _epg;
  RecommendationRepository _recommendation;
  VodRepository _vod;
  SvodRepository _svod;


  EpgRepository getEpg() {
    if (_epg == null) {
      _epg = EpgRepository();
    }
    return _epg;
  }

  RecommendationRepository getRecommendation(){
    if (_recommendation == null) {
      _recommendation = RecommendationRepository();
    }
    return _recommendation;
  }

  VodRepository getVod() {
    if (_vod == null) {
      _vod = VodRepository();
    }
    return _vod;
  }

  SvodRepository getSvod() {
    if (_svod == null) {
      _svod = SvodRepository();
    }
    return _svod;
  }

}
