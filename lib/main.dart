import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stugetow/screens/SplashScreen/androidSplash.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blueGrey[800],
      statusBarIconBrightness: Brightness.light
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stugetow',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: AndroidSplash(),
    );
  }
}
