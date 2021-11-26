import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/state/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          '죽전동',
          style: Theme.of(context).appBarTheme.toolbarTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<UserProvider>().setUserAuth(false);
            },
            icon: Icon(CupertinoIcons.nosign),
          ),
          IconButton(
            onPressed: () {
            },
            icon: Icon(CupertinoIcons.search),
          ),
          IconButton(
            onPressed: () {
            },
            icon: Icon(CupertinoIcons.text_justify),
          ),
        ],
      ),
    );
  }
}
