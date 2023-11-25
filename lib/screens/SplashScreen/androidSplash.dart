import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stugetow/screens/mainPage/mainPage.dart';
import 'package:stugetow/views/Authentication/Login.dart';

class AndroidSplash extends StatefulWidget {
  @override
  _AndroidSplashState createState() => _AndroidSplashState();
}

class _AndroidSplashState extends State<AndroidSplash> {

  Future<bool> _checkSession() async {
    await Future.delayed(Duration(milliseconds: 5000), () {});
    return _getUID();
  }

  Future<bool> _getUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid')==null? false: true;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) => MainPage(),
    ));
  }

  void _navigateToLogIn() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) => Login(),
    ));
  }

  @override
  void initState() {
    super.initState();
    _checkSession().then((status) {
      if (status) {
        _navigateToHome();
      } else {
        _navigateToLogIn();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/logo/tranparentBackground.png'),
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
