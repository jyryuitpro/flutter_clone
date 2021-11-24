import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/routes/locations.dart';
import 'package:flutter_clone/screens/auth_screen.dart';
import 'package:flutter_clone/screens/splash_screen.dart';
import 'package:flutter_clone/utils/logger.dart';

final _routerDelegate = BeamerDelegate(
  guards: [
    BeamGuard(
      pathBlueprints: ['/'],
      check: (context, location) {
        return false;
      },
      showPage: BeamPage(
        child: AuthScreen(),
      ),
    ),
  ],
  locationBuilder: BeamerLocationBuilder(
    beamLocations: [
      HomeLocation(),
    ],
  ),
);

void main() {
  logger.d('My first log by logger!!');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3), () => 100),
      builder: (context, snapshot) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: _splashLoadingWidget(snapshot),
        );
      },
    );
  }

  StatelessWidget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      print('error occur while loading.');
      return Text('Error occur');
    } else if (snapshot.hasData) {
      return BroCombi();
    } else {
      return SplashScreen();
    }
  }
}

class BroCombi extends StatelessWidget {
  const BroCombi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Jalnan',
        textTheme: TextTheme(button: TextStyle(color: Colors.white)),
      ),
      routeInformationParser: BeamerParser(),
      routerDelegate: _routerDelegate,
    );
  }
}
