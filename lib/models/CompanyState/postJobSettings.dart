import 'package:flutter/material.dart';

class PostJobSettings extends StatefulWidget {
  final Function notifyParent;
  PostJobSettings({Key? key, required this.notifyParent}) : super(key: key);
  @override
  _PostJobSettingsState createState() => _PostJobSettingsState();
}

class _PostJobSettingsState extends State<PostJobSettings> {
  bool _commentEnabled = true;
  bool _applicationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        titleSpacing: 0,
        elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15),
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
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                setState(() {
                  widget.notifyParent(_commentEnabled, _applicationsEnabled);
                });
                Navigator.pop(context);
              },
              child: Text('Save',
                  style: TextStyle(
                      color: Colors.blueAccent[200],
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                  ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 18.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "Allow comments",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .5,
                      ),
                    ),
                  ),
                  Switch(
                    value: _commentEnabled,
                    onChanged: (value) {
                      setState(() {
                        _commentEnabled = value;
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
            SizedBox(
              height: 8.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 18.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "Allow applications",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .5,
                      ),
                    ),
                  ),
                  Switch(
                    value: _applicationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _applicationsEnabled = value;
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
                "Be aware that when you disable comments, no one will be able to comment on the post you posted "
                "and when you disable applications, no one will be able to submit any application for the post posted.",
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
