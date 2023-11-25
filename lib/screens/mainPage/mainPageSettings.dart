import 'package:flutter/material.dart';

class MainPageSettings extends StatefulWidget {
  @override
  _MainPageSettingsState createState() => _MainPageSettingsState();
}

class _MainPageSettingsState extends State<MainPageSettings> {
  bool _switchedNotify = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        titleSpacing: 0,
        elevation: 1,
        brightness: Brightness.dark,
        backgroundColor: Colors.white,
        leading:  IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.blueAccent[200]),
          iconSize: 25.0,
          onPressed: () => Navigator.pop(context,),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                "Settings",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),

      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 18.0, right:10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child:Text(
                      "Disable notification",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .5,
                      ),
                    ),
                  ),
                  Switch(
                    value: _switchedNotify,
                    onChanged: (value){
                      setState(() {
                        _switchedNotify = value;
                        print(_switchedNotify);
                      });
                    },
                    activeTrackColor: Colors.blue[400],
                    activeColor: Colors.white,
                    inactiveTrackColor: Colors.blueGrey[300],
                    inactiveThumbColor: Colors.white,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Be aware that when you disable notification, you are not going to receive any notification from Stugetow.",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black.withOpacity(0.3),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
