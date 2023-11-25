import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteSlideRegister.dart';
import 'package:stugetow/views/Authentication/Login.dart';
import 'package:stugetow/views/Authentication/Register/registerSecondPageCompany.dart';
import 'registerSecondPageUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterSelectStatus extends StatefulWidget {
  @override
  _RegisterSelectStatusState createState() => _RegisterSelectStatusState();
}

class _RegisterSelectStatusState extends State<RegisterSelectStatus> {
  int? _selectedRadio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  // color: Colors.red,
                  height: 400.0,
                  child: Image(image: AssetImage('assets/images/logo/tranparentBackground.png')),
                ),
                Positioned(
                  top: 280,
                  child: Container(
                    child: Text(
                      '--Register--',
                      style: TextStyle(
                        color: Color.fromRGBO(48, 126, 171, 1),
                        fontSize: 40.0,
                        fontFamily: 'cursive',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            'What would you like to register as?...',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            _selectRadio(1);
                            _removeData();
                          },
                          child: Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: _selectedRadio,
                                activeColor: Color.fromRGBO(48, 126, 171, 1),
                                onChanged: (dynamic val) {
                                  _selectRadio(val);
                                  _removeData();
                                },
                              ),
                              Text('student',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 18)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            _selectRadio(2);
                            _removeData();
                          },
                          child: Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue: _selectedRadio,
                                activeColor: Color.fromRGBO(48, 126, 171, 1),
                                onChanged: (dynamic val) {
                                  _selectRadio(val);
                                  _removeData();
                                },
                              ),
                              Text('company', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 175, right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Color.fromRGBO(36, 88, 120, 1),
                          size: 22,
                        ),
                        Text(
                          'Cancel',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(36, 88, 120, 1)),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                      _removeData();
                    },
                  ),
                  TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(48, 126, 171, 1),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Color.fromRGBO(48, 126, 171, 1),
                          size: 22,
                        )
                      ],
                    ),
                    onPressed: () {
                      String message = 'You have to select either student or company';
                      if(_selectedRadio != 1 && _selectedRadio != 2)_showToast(context, message);
                      else{
                        var role = _selectedRadio==1? 'student': 'company';
                        _setData(_selectedRadio, role);
                        Navigator.pushReplacement(context,
                          AnimatedPageRouteSlideRegister(
                            page: _selectedRadio == 2 ? RegisterSecondPageCompany()
                                : _selectedRadio == 1 ? RegisterSecondPageUser() : null,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: 'Okay', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt('radio');
    value!=null?setState(() {
      _selectedRadio = value;
    }):null;
  }

  _setData(value, role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('radio',value);
    prefs.setString('role', role);
  }
  _removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
  _selectRadio(int? val) async {
    setState(() {
      _selectedRadio = val;
    });
  }
}
