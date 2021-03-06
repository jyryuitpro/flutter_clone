import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clone/routes/locations.dart';
import 'package:flutter_clone/screens/splash_screen.dart';
import 'package:flutter_clone/screens/start_screen.dart';
import 'package:flutter_clone/state/user_provider.dart';
import 'package:flutter_clone/utils/logger.dart';
import 'package:provider/provider.dart';

final _routerDelegate = BeamerDelegate(
  guards: [
    BeamGuard(
      pathBlueprints: ['/'],
      check: (context, location) {
        return context.watch<UserProvider>().user != null;
      },
      showPage: BeamPage(
        child: StartScreen(),
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
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
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
    } else if (snapshot.connectionState == ConnectionState.done) {
      return BroCombi();
    } else {
      return SplashScreen();
    }
  }
}

class BroCombi extends StatelessWidget {
  const BroCombi({Key? key}) : super(key: key);

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (BuildContext context) {
        return UserProvider();
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: createMaterialColor(Color(0xff71d686)),
          fontFamily: 'Jalnan',
          hintColor: Colors.grey,
          textTheme: TextTheme(
            button: TextStyle(
              color: Colors.white,
            ),
            subtitle1: TextStyle(
              color: Colors.black87,
              fontSize: 15,
            ),
            subtitle2: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              backgroundColor: createMaterialColor(
                Color(0xff71d686),
              ),
              primary: Colors.white,
              minimumSize: Size(40, 40),
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 2,
            toolbarTextStyle: TextStyle(
              color: Colors.black87,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.black87,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.black87,
            unselectedItemColor: Colors.black54,
          ),
        ),
        routeInformationParser: BeamerParser(),
        routerDelegate: _routerDelegate,
      ),
    );
  }
}
