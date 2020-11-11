import 'package:tv_app/network/custom_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class ApiProvider {
  // Devel
  // final String _baseUrl = 'https://api.chucknorris.io/';
  // Stage
  // final String _baseUrl = 'https://player.maxtvtogo.tportal.hr:8086/OTT4Proxy/proxy/';
  // Production
  final String _baseUrl = 'https://player.maxtvtogo.tportal.hr:8082/OTT4Proxy/proxy/';
  final Map<String, String> _headers = {
    'Content-type' : 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };

  ApiProvider();


  ///
  /// GET API request
  ///
  Future<dynamic> get(String url) async {
    var responseJson;

    try {
      final response = await http.get(_baseUrl + url, headers: _headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  ///
  /// POST API request
  ///
  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url, body: json.encode(body), headers: _headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  ///
  /// PUT API request
  ///
  Future<dynamic> put(String url, {Map<String, String> body}) async {
    var responseJson;

    try {
      var response;
      if (body != null) {
        response = await http.put(_baseUrl + url, body: json.encode(body), headers: _headers);
      } else {
        response = await http.put(_baseUrl + url, headers: _headers);
      }

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }

  ///
  /// DELETE API request
  ///
  Future<dynamic> delete(String url) async {
    var responseJson;

    try {
      final response = await http.delete(_baseUrl + url, headers: _headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return responseJson;
  }


  ///
  ///  Handle API response
  ///
  dynamic _response(http.Response response) {
    String body = utf8.decode(response.bodyBytes);
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(body);
        return responseJson;
        break;
      case 400:
        throw BadRequestException(body);
        break;
      case 401:
      case 403:
        throw UnauthorisedException(body);
        break;
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        break;
    }
  }
}