import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'screen/auth/login_screen.dart';
import 'screen/home/movie_homepage.dart';
import 'package:project_team/screen/auth/profile.dart';


final database = FirebaseDatabase.instance.ref();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyCineTimeApp());
}

class MyCineTimeApp extends StatefulWidget {
  @override
  MyCineTimeAppState createState() => MyCineTimeAppState();
}

class MyCineTimeAppState extends State<MyCineTimeApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = (_themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CINEZONE',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      // Đảm bảo LoginScreen đã được import
      home: LoginScreen(onLoginSuccess: (loginContext) {
        Navigator.pushReplacement(
          loginContext,
          MaterialPageRoute(
              builder: (_) => MovieHomePage(toggleTheme: toggleTheme)),
        );
      }),
    );
  }
}