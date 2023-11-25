import 'package:flutter/material.dart';
import 'package:stugetow/views/Authentication/Login.dart';
import 'package:stugetow/views/separateClasses/Chats/messages.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext contextProfile) {
    final MessageChats posted = postByUser[0];
    return Container(
      width: 290,
      color: Colors.blueGrey,
      alignment: Alignment.center,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.only(top: 0.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: new Container(
              height: 250.0,
              decoration: BoxDecoration(color: Colors.black87),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(posted.sender.imageUrl),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("listTile clicked.. ${posted.sender.name}");
            },
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    color: Colors.white60,
                    size: 30.0,
                  ),
                  SizedBox(width: 10.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        child: Text(
                          posted.sender.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        width: 200.0,
                        child: Text(
                          posted.sender.currentWorkStatus,
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              print(
                  "you have clicked the school: ${posted.sender.university.name}");
            },
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.school,
                    color: Colors.white60,
                    size: 30.0,
                  ),
                  SizedBox(width: 10.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        child: Text(
                          posted.sender.university.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        width: 200.0,
                        child: Text(
                          posted.sender.university.describtion,
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              print("you have clicked editProfile...");
            },
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.mode_edit,
                    color: Colors.white60,
                    size: 30.0,
                  ),
                  SizedBox(width: 10.0,),
                  Text(
                    'Edit profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              print("You have clicked settings");
            },
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.settings,
                    color: Colors.white60,
                    size: 30.0,
                  ),
                  SizedBox(width: 10.0,),
                  Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.transit_enterexit,
                    color: Colors.white60,
                    size: 30.0,
                  ),
                  SizedBox(width: 10.0,),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
