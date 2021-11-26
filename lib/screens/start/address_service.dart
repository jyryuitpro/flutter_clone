import 'package:dio/dio.dart';
import 'package:flutter_clone/constants/keys.dart';
import 'package:flutter_clone/data/address_model_coordinate.dart';
import 'package:flutter_clone/data/address_model_search.dart';
import 'package:flutter_clone/utils/logger.dart';

class AddressService {
  void dioTest() async {
    var responce = await Dio().get('https://randomuser.me/api/').catchError((e) {
      logger.e(e);
    });
    logger.d(responce);

    // try {
    //   var responce = await Dio().get('https://randomuser.me/api/');
    //   logger.d(responce);
    // } on Exception catch (e) {
    //   logger.e(e);
    // }
  }

  Future<AddressModelSearch> searchAddressBystr(String text) async {
    final formData = {
      'key': VWORLD_KEY,
      'request': 'search',
      'size': 30,
      'query': text,
      'type': 'ADDRESS',
      'category': 'ROAD',
    };

    final response = await Dio().get('http://api.vworld.kr/req/search', queryParameters: formData).catchError((e) {
      logger.e(e.message);
    });
    logger.d(response);

    // logger.d(response.data is Map);
    // logger.d(response.data['response']['result']);
    AddressModelSearch addressModelSearch = AddressModelSearch.fromJson(response.data['response']);
    logger.d(addressModelSearch);

    return addressModelSearch;
  }

  Future<List<AddressModelCoordinate>> findAddressByCoordinate({required double log, required double lat}) async {
    final List<Map<String, dynamic>> formDatas = <Map<String, dynamic>>[];

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'getAddress',
      'point': '$log,$lat',
      'type': 'PARCEL',
    });

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'getAddress',
      'point': '${log-0.01},$lat',
      'type': 'PARCEL',
    });

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'getAddress',
      'point': '${log+0.01},$lat',
      'type': 'PARCEL',
    });

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'getAddress',
      'point': '$log,${lat-0.01}',
      'type': 'PARCEL',
    });

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'getAddress',
      'point': '$log,${lat+0.01}',
      'type': 'PARCEL',
    });

    List<AddressModelCoordinate> addressModelCoordinates = [];

    for(Map<String, dynamic> formData in formDatas) {
      final response = await Dio().get('http://api.vworld.kr/req/address', queryParameters: formData).catchError((e) {
        logger.e(e.message);
      });

      logger.d(response);

      AddressModelCoordinate addressModelCoordinate = AddressModelCoordinate.fromJson(response.data['response']);

      if(response.data['response']['status'] == 'OK') {
        addressModelCoordinates.add(addressModelCoordinate);
        logger.d(addressModelCoordinate);
      }
    }
    logger.d(addressModelCoordinates);

    return addressModelCoordinates;
  }
}