import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(16),
      child: Column(
        children: [
          TextFormField(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.compass,
                  color: Colors.white,
                  size: 20,
                ),
                label: Text(
                  '현재위치로 찾기',
                  style: Theme.of(context).textTheme.button,
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
