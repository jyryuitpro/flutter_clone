import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/data/address_model_coordinate.dart';
import 'package:flutter_clone/data/address_model_search.dart';
import 'package:flutter_clone/screens/start/address_service.dart';
import 'package:flutter_clone/utils/logger.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _addressController = TextEditingController();

  AddressModelSearch? _addressModelSearch;
  List<AddressModelCoordinate> _addressModelCoordinates = [];
  bool _isGettingLocation = false;

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _addressController,
            onFieldSubmitted: (text) async {
              _addressModelCoordinates.clear();
              _addressModelSearch = await AddressService().searchAddressBystr(text);
              setState(() {});
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintText: '도로명으로 검색',
              hintStyle: TextStyle(color: Colors.grey),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 24,
                minHeight: 24,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () async {
              // final text = _addressController.text;
              // if(text.isNotEmpty) {
              //   AddressService().searchAddressBystr(text);
              // }
              _addressModelSearch = null;
              _addressModelCoordinates.clear();

              setState(() {
                _isGettingLocation = true;
              });

              Location location = new Location();

              bool _serviceEnabled;
              PermissionStatus _permissionGranted;
              LocationData _locationData;

              _serviceEnabled = await location.serviceEnabled();
              if (!_serviceEnabled) {
                _serviceEnabled = await location.requestService();
                if (!_serviceEnabled) {
                  return;
                }
              }

              _permissionGranted = await location.hasPermission();
              if (_permissionGranted == PermissionStatus.denied) {
                _permissionGranted = await location.requestPermission();
                if (_permissionGranted != PermissionStatus.granted) {
                  return;
                }
              }

              _locationData = await location.getLocation();
              List<AddressModelCoordinate> addressModelCoordinates = await AddressService().findAddressByCoordinate(log: _locationData.longitude!, lat: _locationData.latitude!);

              _addressModelCoordinates.addAll(addressModelCoordinates);
              logger.d(_addressModelCoordinates);

              setState(() {
                _isGettingLocation = false;
              });
            },
            icon: _isGettingLocation
                ? SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Icon(
                    CupertinoIcons.compass,
                    color: Colors.white,
                    size: 20,
                  ),
            label: Text(
              _isGettingLocation ? '현재위치를 찾는 중 입니다.' : '현재위치로 찾기',
              style: Theme.of(context).textTheme.button,
            ),
          ),
          if(_addressModelSearch != null)
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 16),
                itemCount: _addressModelSearch == null ||
                        _addressModelSearch!.result == null ||
                        _addressModelSearch!.result!.items == null
                    ? 0
                    : _addressModelSearch!.result!.items!.length,
                itemBuilder: (context, index) {
                  // logger.d('index: $index');
                  if (_addressModelSearch == null ||
                      _addressModelSearch!.result == null ||
                      _addressModelSearch!.result!.items == null ||
                      _addressModelSearch!.result!.items![index].address == null) {
                    return Container();
                  } else {
                    return ListTile(
                      onTap: () async {
                        _saveAddressAndGoToNextPage(_addressModelSearch!.result!.items![index].address!.road ?? '');
                      },
                      title: Text(_addressModelSearch!.result!.items![index].address!.road ?? ''),
                      subtitle: Text(_addressModelSearch!.result!.items![index].address!.parcel ?? ''),
                    );
                  }
                },
              ),
            ),
          if(_addressModelCoordinates.isNotEmpty)
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 16),
                itemCount: _addressModelCoordinates.length,
                itemBuilder: (context, index) {
                  // logger.d('index: $index');
                  if (_addressModelCoordinates[index].result == null ||
                      _addressModelCoordinates[index].result!.isEmpty) {
                    return Container();
                  } else {
                    return ListTile(
                      onTap: () async {
                        _saveAddressAndGoToNextPage(_addressModelCoordinates[index].result![0].text ?? '');
                      },
                      title: Text(_addressModelCoordinates[index].result![0].text ?? ''),
                      subtitle: Text(_addressModelCoordinates[index].result![0].zipcode ?? ''),
                    );
                  }
                },
              ),
            ),
        ],
      ),
    );
  }

  _saveAddressAndGoToNextPage(String address) async {
    await _saveAddressOnSharedPreference(address);
    context.read<PageController>().animateToPage(2, duration: Duration(microseconds: 500), curve: Curves.ease);
  }

  _saveAddressOnSharedPreference(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', address);
  }
}
