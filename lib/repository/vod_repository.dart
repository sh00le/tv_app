import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:tv_app/repository/repository.dart';
import 'package:tv_app/models/VodCategory.dart';
import 'package:tv_app/models/SvodCategory.dart';

class VodRepository extends Repository {
  @protected
  String prefix = 'vod';

  Future<List<dynamic>> categories() async {
    final String url = '$prefix/categories/';
    List<dynamic> categoryList = [];
    var responseJson = await provider.get(url);

    if (responseJson['list'] != null) {
      if (prefix == 'vod') {
        categoryList = (responseJson['list'] as List)
            .map((i) => VodCategory.fromJson(i))
            .toList();
      } else {
        categoryList = (responseJson['list'] as List)
            .map((i) => SvodCategory.fromJson(i))
            .toList();
      }
    }
    return categoryList;
  }

  Future<List<dynamic>> categoryContent(String categoryId) async {
    final String url = '$prefix/categories/content/$categoryId/';
    List<dynamic> contentList = [];
    var responseJson = await provider.get(url);

    if (responseJson['list'] != null) {
      if (prefix == 'vod') {
        contentList = (responseJson['list'] as List)
            .map((i) => vodContentFromJson(i))
            .toList();
      } else {
        contentList = (responseJson['list'] as List)
            .map((i) => svodContentFromJson(i))
            .toList();
      }
    }
    return contentList;
  }

  Future<List<dynamic>> allCategoryContent(String categoryId,
      {String sort = 'date'}) async {
    final catSort = (sort == 'name') ? 'name' : 'date';
    final String url = '$prefix/categories/all_content/$categoryId/$catSort/';
    List<dynamic> contentList = [];
    var responseJson = await provider.get(url);

    if (responseJson['list'] != null) {
      if (prefix == 'vod') {
        contentList = (responseJson['list'] as List)
            .map((i) => vodContentFromJson(i))
            .toList();
      } else {
        contentList = (responseJson['list'] as List)
            .map((i) => svodContentFromJson(i))
            .toList();
      }
    }
    return contentList;
  }

  Future<dynamic> serial(int serialId) async {
    final String url = '$prefix/serial/$serialId/';

    var responseJson;
    responseJson = await provider.get(url);

    if (prefix == 'vod') {
      return vodSerialFromJson(responseJson['serial'], responseJson['seasons']);
    } else {
      return svodSerialFromJson(
          responseJson['serial'], responseJson['seasons']);
    }
  }

  Future<dynamic> movie(int contentId) async {
    final String url = '$prefix/movie/$contentId/';

    var responseJson;
    responseJson = await provider.get(url);

    if (prefix == 'vod') {
      return vodContentFromJson(responseJson['movie']);
    } else {
      return svodContentFromJson(responseJson['movie']);
    }
  }

  Future<dynamic> episode(int contentId) async {
    final String url = '$prefix/episode/$contentId/';

    var responseJson;
    responseJson = await provider.get(url);

    if (prefix == 'vod') {
      return vodContentFromJson(responseJson['movie']);
    } else {
      return svodContentFromJson(responseJson['movie']);
    }
  }
}
