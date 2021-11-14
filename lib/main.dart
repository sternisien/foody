import 'package:flutter/material.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;
  final int mainColor = 0xffe8f5e9;
  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Home h = Home(title: '');
    return MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              color: Color(0xffe8f5e9),
            ),
            bodyText2: TextStyle(
              color: Color(0xffe8f5e9),
            ),
          ),
          colorScheme: const ColorScheme(
              primary: Color(0xff027353),
              primaryVariant: Color(0xff027353),
              secondary: Color(0xff027353),
              secondaryVariant: Color(0xff027353),
              surface: Color(0xff027353),
              background: Color(0xffe8f5e9),
              error: Color(0xff027353),
              onPrimary: Color(0xff027353),
              onSecondary: Color(0xff027353),
              onSurface: Color(0xff027353),
              onBackground: Color(0xffe8f5e9),
              onError: Color(0xff027353),
              brightness: Brightness.light),
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          scaffoldBackgroundColor: const Color(0xffe8f5e9),
        ),
        home: h);
  }
}
