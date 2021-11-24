import 'package:flutter/material.dart';
import 'package:flutter_clone/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3), () => 100),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          print('error occur while loading.');
          return Text('Error occur');
        } else if(snapshot.hasData) {
          return BroCombi();
        } else {
          return SplashScreen();
        }
      }
    );
  }
}

class BroCombi extends StatelessWidget {
  const BroCombi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}

