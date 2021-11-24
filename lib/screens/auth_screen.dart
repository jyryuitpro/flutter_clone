import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Center(
            child: Text('Auth Screen!!'),
          ),
          Container(
            color: Colors.accents[2],
          ),
          Container(
            color: Colors.accents[5],
          ),
        ],
      ),
    );
  }
}
