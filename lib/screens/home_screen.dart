import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/state/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomSelectedIndex = 0;

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
            onPressed: () {},
            icon: Icon(CupertinoIcons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.text_justify),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomSelectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_bottomSelectedIndex == 0 ? 'assets/images/brocombi_home_selected.png' : 'assets/images/brocombi_home.png')),
            label: '홈'
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_bottomSelectedIndex == 1 ? 'assets/images/brocombi_near_selected.png' : 'assets/images/brocombi_near.png')),
            label: '내 근처'
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_bottomSelectedIndex == 2 ? 'assets/images/brocombi_chat_selected.png' : 'assets/images/brocombi_chat.png')),
            label: '채팅'
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_bottomSelectedIndex == 3 ? 'assets/images/brocombi_user_selected.png' : 'assets/images/brocombi_user.png')),
            label: '내 정보'
          ),
        ],
        onTap: (index) {
          setState(() {
            _bottomSelectedIndex = index;
          });
        },
      ),
    );
  }
}
