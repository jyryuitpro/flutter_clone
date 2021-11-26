import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/data/address_model.dart';
import 'package:flutter_clone/screens/start/address_service.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _addressController = TextEditingController();

  AddressModel? _addressModel;

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
              _addressModel = await AddressService().searchAddressBystr(text);
              setState(() {

              });
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
            onPressed: () {
              // final text = _addressController.text;
              // if(text.isNotEmpty) {
              //   AddressService().searchAddressBystr(text);
              // }

            },
            icon: Icon(
              CupertinoIcons.compass,
              color: Colors.white,
              size: 20,
            ),
            label: Text(
              '현재위치로 찾기',
              style: Theme.of(context).textTheme.button,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16),
              itemCount: _addressModel == null || _addressModel!.result == null || _addressModel!.result!.items == null ? 0 : _addressModel!.result!.items!.length,
              itemBuilder: (context, index) {
                // logger.d('index: $index');
                if(_addressModel == null || _addressModel!.result == null || _addressModel!.result!.items == null || _addressModel!.result!.items![index].address == null) {
                  return Container();
                } else {
                  return ListTile(
                    title: Text(_addressModel!.result!.items![index].address!.road ?? ''),
                    subtitle: Text(_addressModel!.result!.items![index].address!.parcel ?? ''),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
