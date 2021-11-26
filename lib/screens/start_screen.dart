import 'package:flutter/material.dart';
import 'package:flutter_clone/screens/start/address_page.dart';
import 'package:flutter_clone/screens/start/auth_page.dart';
import 'package:flutter_clone/screens/start/intro_page.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  PageController _pageController = PageController();

  StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<PageController>.value(
      value: _pageController,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          // physics: NeverScrollableScrollPhysics(),
          children: [
            IntroPage(),
            AddressPage(),
            AuthPage(),
          ],
        ),
      ),
    );
  }
}
