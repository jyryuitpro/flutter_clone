import 'package:dio/dio.dart';
import 'package:flutter_clone/constants/keys.dart';
import 'package:flutter_clone/data/address_model.dart';
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

  Future<AddressModel> searchAddressBystr(String text) async {
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
    AddressModel addressModel = AddressModel.fromJson(response.data['response']);
    logger.d(addressModel);

    return addressModel;
  }

  Future<void> findAddressByCoordinate({required double log, required double lat}) async {
    final formData = {
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'getAddress',
      'point': '$log,$lat',
      'type': 'BOTH',
    };

    final response = await Dio().get('http://api.vworld.kr/req/address', queryParameters: formData).catchError((e) {
      logger.e(e.message);
    });
    logger.d(response);

    return;
  }
}