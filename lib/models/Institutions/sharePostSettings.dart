import 'package:flutter/material.dart';

class SharePostSettings extends StatefulWidget {
  final Function notifyParent;
  SharePostSettings({Key? key, required this.notifyParent}) : super(key: key);
  @override
  _SharePostSettingsState createState() => _SharePostSettingsState();
}

class _SharePostSettingsState extends State<SharePostSettings> {
  bool _switchedComment = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        titleSpacing: 0,
        elevation: 1,
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

        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                setState(() {
                  widget.notifyParent(_switchedComment);
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
              padding: EdgeInsets.only(left: 18.0, right:10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child:Text(
                      "Disable comments",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .5,
                      ),
                    ),
                  ),
                  Switch(
                    value: _switchedComment,
                    onChanged: (value){
                      setState(() {
                        _switchedComment = value;
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
                "Be aware that when you disable comments, no one will be able to comment on the post you posted ",
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
