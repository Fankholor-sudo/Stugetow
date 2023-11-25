import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stugetow/models/Institutions/Institutions.dart';
import 'package:stugetow/models/Institutions/sharePost.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRoute.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteSlide.dart';
import 'package:stugetow/screens/Chats/UserProfileDestination.dart';
import 'package:stugetow/screens/Chats/ViewPhoto.dart';
import 'package:stugetow/screens/Institutions/StudentPostDestination.dart';
import 'package:stugetow/services/auth.dart';
import 'package:stugetow/views/separateClasses/Chats/messages.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'dart:ui' as ui;

import 'package:stugetow/views/separateClasses/Institution/studentPost.dart';

class School extends StatefulWidget {
  final Function notifyParent;
  School({Key? key, required this.notifyParent}) : super(key: key);

  @override
  SchoolState createState() => SchoolState();
}

class SchoolState extends State<School> {
  bool _isKeyboardVisible = false;
  late List<MessageChats> _postsList;
  late List<bool> _likes;

  EdgeInsets _viewInsetsSchool = EdgeInsets.fromWindowPadding(WidgetsBinding.instance!.window.viewInsets,WidgetsBinding.instance!.window.devicePixelRatio);
  AuthService _auth = AuthService();
  List<StudentPost>? _posts = [];
  String? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: user!='student'?null:ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey)),
        child: Text(
          'Share post',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(255, 255, 255, .9),
          ),
        ),
        onPressed: () {
          // for(var a in _posts!) {
          //   print(a.sender!.lastname);
          //   print(a.imgUrl);
          // }
          Navigator.push(
            context,
            AnimatedPageRouteSlide(page: SharePost(addPost: refreshPosts)),
          );
        },
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: ListView(
                  padding: EdgeInsets.only(bottom: 60.0),
                  children: <Widget>[
                    Institution(),
                    Container(
                      height: 10.0,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 10.0,
                              color: Color.fromRGBO(125, 125, 125, .1)),
                        ),
                      ),
                    ),
                    for (var index = 0; index < _postsList.length; index++)
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 5.0),
                              child: Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      _profileDialog(context, index);
                                    },
                                    child: CircleAvatar(
                                      radius: 24.0,
                                      backgroundImage: AssetImage(
                                          _postsList[index].sender.imageUrl),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 3.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              child: Text(
                                                _postsList[index].sender.name,
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Text(
                                                '${_postsList[index].date}',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, .4),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.55,
                                          child: Text(
                                            _postsList[index]
                                                .sender
                                                .university
                                                .name,
                                            style: TextStyle(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, .4),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.55,
                                          child: Text(
                                            _postsList[index].sender.course,
                                            style: TextStyle(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, .4),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width*.9,
                                          child: Text(
                                            _postsList[index].text,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: "cursive-monospace",
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      AnimatedPageRoute(
                                        page: StudentPostDestinationScreen(
                                            destination: _postsList[index],
                                            liked: _likes[index],
                                            index: index,
                                            notifyParent: refresh),
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(color: Colors.blueGrey[700]),
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Container(
                                            child: _postsList[index].imgPostUrl == "" ?null : (_postsList[index].imgPostUrl.substring(0,6)=='assets'?
                                            Image.asset(_postsList[index].imgPostUrl):Image.file(File(_postsList[index].imgPostUrl))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                              icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                child: Icon(_likes[index]
                                                    ? Icons.favorite
                                                    : Icons.favorite_border),
                                                shaderCallback: (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.red,
                                                      Colors.deepOrangeAccent
                                                    ],
                                                  );
                                                },
                                              ),
                                              iconSize: 22.0,
                                              onPressed: () {
                                                setState(() {
                                                  _likes[index] =
                                                      !_likes[index];
                                                });
                                              },
                                            ),
                                            IconButton(
                                              icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                child: Icon(Icons.comment),
                                                shaderCallback: (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Colors.deepOrangeAccent,
                                                      Color.fromRGBO(
                                                          9, 86, 164, 1)
                                                    ],
                                                  );
                                                },
                                              ),
                                              iconSize: 22.0,
                                              onPressed: () {
                                                _showBottomComment(context);
                                              },
                                            ),
                                            IconButton(
                                              icon: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                child: Icon(Icons.share),
                                                shaderCallback: (Rect bounds) {
                                                  return ui.Gradient.linear(
                                                    Offset(4.0, 24.0),
                                                    Offset(24.0, 4.0),
                                                    [
                                                      Color.fromRGBO(
                                                          9, 86, 164, 1),
                                                      Colors.black54
                                                    ],
                                                  );
                                                },
                                              ),
                                              iconSize: 22.0,
                                              onPressed: () async {
                                                _shareFile(index);
                                              },
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          icon: ShaderMask(
                                              blendMode: BlendMode.srcIn,
                                              child: Icon(Icons.details),
                                              shaderCallback: (Rect bounds) {
                                                return ui.Gradient.linear(
                                                  Offset(4.0, 24),
                                                  Offset(24.0, 4.0),
                                                  [
                                                    Color.fromRGBO(
                                                        9, 86, 164, 1),
                                                    Colors.deepOrangeAccent
                                                  ],
                                                );
                                              }),
                                          iconSize: 21.0,
                                          onPressed: () {
                                            _postBottomMenuOptions(context, index);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                ],
                              ),
                            ),
                            Container(
                              height: 10.0,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      width: 10.0,
                                      color: Color.fromRGBO(125, 125, 125, .1)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomComment(context) {
    final Color backgroundColor = Color.fromRGBO(0, 0, 0, .4);
    final Color textBackground =
        Color.fromRGBO(126, 168, 189, .9); //Color.fromRGBO(255, 255, 255, .85);

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        backgroundColor: backgroundColor,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      height:MediaQuery.of(context).size.height * .9,
                      padding: EdgeInsets.only(top: 50.0, bottom: 63.0 + (_isKeyboardVisible ? _viewInsetsSchool.bottom:0)),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: ListView(
                        // controller: listScrollController,
                        children: [
                          for (var index = 0;
                              index < _postsList.length;
                              index++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 14.0, right: 14.0, top: 10.0),
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 8.0),
                                decoration: BoxDecoration(
                                  color: textBackground,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: 15.0,
                                            backgroundImage: AssetImage(
                                                _postsList[index]
                                                    .sender
                                                    .imageUrl),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .45,
                                                  child: Text(
                                                    _postsList[index]
                                                        .sender
                                                        .name,
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'posted on: ${_postsList[index].date}',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, .4),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .8,
                                      child: Text(
                                        "chats..., nice chats isn't it guys..i would really not mind to read all of it nice chats\nisn't it guys..i would really not mind to read ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 20.0,
                      left: 20.0,
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Icons.comment,
                              color: Colors.white,
                              size: 18.0,
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Container(
                            child: Text(
                              "Comments",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                fontFamily: "serif",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      right: 0,
                      left: 0,
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(1.0, 0),
                          )
                        ]),
                        padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              width: MediaQuery.of(context).size.width * .8,
                              padding: EdgeInsets.only(bottom: _isKeyboardVisible? _viewInsetsSchool.bottom:0),
                              child: new ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 130.0),
                                child: TextField(
                                  maxLines: null,
                                  cursorColor: Colors.blueGrey,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Type text...",
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade700,
                                      fontSize: 18.0,
                                    ),
                                    prefixIcon: IconButton(
                                      icon: Icon(
                                        Icons.tag_faces,
                                        size: 25.0,
                                        color: Colors.amber,
                                      ),
                                      onPressed: () => {},
                                    ),
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade100,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    print("chatting..");
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 2.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(17.0),
                                child: Material(
                                  color: Color.fromRGBO(126, 168, 189, 1),
                                  child: InkWell(
                                    splashColor: Colors.blueGrey[700],
                                    child: SizedBox(
                                      width: 50,
                                      height: 46,
                                      child: Icon(Icons.record_voice_over,
                                          color: Colors.white, size: 16.0),
                                    ),
                                    onTap: () => {},
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // ),
              ],
            ),
          );
        });
  }

  void _postBottomMenuOptions(context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.30,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: ListView(
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      String path = _postsList[index].imgPostUrl;
                      _saveImageToDevice(path);
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.save_alt,
                            color: Colors.blueGrey,
                            size: 30.0,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Save image to phone",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "add photo to your local storage",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    _shareFile(index);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.forward,
                            color: Colors.blueGrey,
                            size: 30.0,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Share post with friends",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "external share to friends",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.notifications_active,
                            color: Colors.blueGrey,
                            size: 30.0,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Turn on Notification",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "you will receive alerts for a new post",
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _profileDialog(context, int index) {
    showGeneralDialog(
      transitionDuration: Duration(milliseconds: 300),
      transitionBuilder: (context, animation, anim2, widget) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.bounceIn,
            reverseCurve: Curves.bounceIn,
          ),
          child: Container(
            margin: EdgeInsets.only(top: 100.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    AnimatedPageRoute(
                      page:
                          ViewPhotoChat(destination: _postsList[index].sender),
                    ),
                  ).then((result) {
                    Navigator.of(context).pop();
                  }),
                  child: Container(
                    width: 200.0,
                    height: 170.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      image: DecorationImage(
                        image: AssetImage(_postsList[index].sender.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[700],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () => Navigator.push(
                          context,
                          AnimatedPageRoute(
                            page: UserDestinationScreen(
                                destination: _postsList[index].sender),
                          ),
                        ).then((result) {
                          Navigator.of(context).pop();
                        }),
                        icon: Icon(Icons.person, color: Colors.white60),
                        label: Text("profile",
                            style: TextStyle(color: Colors.white60)),
                      ),
                      TextButton.icon(
                        onPressed: () => Navigator.push(
                          context,
                          AnimatedPageRoute(
                            page: ViewPhotoChat(
                                destination: _postsList[index].sender),
                          ),
                        ).then((result) {
                          Navigator.of(context).pop();
                        }),
                        icon: Icon(Icons.photo, color: Colors.white60),
                        label: Text("photo",
                            style: TextStyle(color: Colors.white60)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      barrierLabel: "",
      barrierColor: Color.fromRGBO(0, 0, 0, .6),
      barrierDismissible: true,
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Text("picture");
      },
    );
  }

  Future _shareFile(int index) async {
    String originPath = _postsList[index].imgPostUrl;
    File convertedImage;
    if(originPath.substring(0,6)=='assets') {
      convertedImage = await getImageFileFromAssets(originPath.substring(7));
    }
    else convertedImage = File(originPath);
    Share.shareFiles(
      [convertedImage.path],
      text: _postsList[index].text,
      subject: 'Share image from Stugetow',
    );
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');
    final file = File('${(await getTemporaryDirectory()).path}/${basename(path)}');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }


  Future _saveImageToDevice(String originPath) async {
    final dir = await createFolder('images');
    final String dirPath = dir.path;
    final imgPath = originPath;
    File convertedImage;
    if(originPath.substring(0,6)=='assets') {
      convertedImage = await getImageFileFromAssets(imgPath.substring(7));
    }
    else convertedImage = File(originPath);

    String name = basename(convertedImage.path);
    await convertedImage.copy('$dirPath/stugetow_$name');
  }

  Future<Directory> createFolder(String cow) async {
    final folderName = 'Stugetow/$cow';
    final path = Directory("storage/emulated/0/$folderName");
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await path.exists())) {
      return path;
    } else {
      path.create();
      return path;
    }
  }

  @override
  void initState() {
    super.initState();
    _setupPost();
    _getData();
    setState(() {
      _postsList = postByUser;
      _likes = List.filled(_postsList.length, false);
      _viewInsetsSchool = EdgeInsets.fromWindowPadding(WidgetsBinding.instance!.window.viewInsets,WidgetsBinding.instance!.window.devicePixelRatio);
    });
  }

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var role = prefs.getString('role');
    setState((){user=role;});
  }

  _setupPost() async {
    List<StudentPost> post = await _auth.getPostStudent();
    setState(() {
      _posts = post;
    });
  }

  refreshPosts(MessageChats post) {
    setState(() {
      _postsList.add(post);
      _likes = List.filled(_postsList.length, false);
    });
  }

  refresh(dynamic isLiked, int position) {
    setState(() {
      _likes[position] = isLiked;
    });
  }
}
