import 'package:flutter/material.dart';
import 'package:flutter_clone/screens/start/address_page.dart';
import 'package:flutter_clone/screens/start/intro_page.dart';

class AuthScreen extends StatelessWidget {
  PageController _pageController = PageController();

  AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        // physics: NeverScrollableScrollPhysics(),
        children: [
          IntroPage(_pageController),
          AddressPage(),
          Container(
            color: Colors.accents[5],
          ),
        ],
      ),
    );
  }
}
