import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:stugetow/models/Chats/profileDistMenu.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRoute.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteSlide.dart';
import 'package:stugetow/screens/Chats/ChatDestination.dart';
import 'package:stugetow/screens/Chats/ViewPhoto.dart';
import 'package:stugetow/screens/Institutions/StudentPostDestination.dart';
import 'package:stugetow/views/separateClasses/Chats/Users.dart';
import 'package:stugetow/views/separateClasses/Chats/messages.dart';
import 'dart:ui' as ui;

class UserDestinationScreen extends StatefulWidget {
  final User? destination;

  UserDestinationScreen({this.destination});

  @override
  _UserDestinationScreenState createState() => _UserDestinationScreenState();
}

class _UserDestinationScreenState extends State<UserDestinationScreen> {
  List<bool> _likes = List.filled(postByUser.length, false);
  bool _isKeyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        brightness: Brightness.dark,
        titleSpacing: 0,
        backgroundColor: Color.fromRGBO(255, 255, 255, .9),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(9, 86, 164, 1)),
          iconSize: 25.0,
          onPressed: () => Navigator.pop(
            context,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * .7,
              child: Text(
                widget.destination!.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: null,
            icon: Icon(Icons.more_horiz, color: Color.fromRGBO(9, 86, 164, 1)),
            color: Colors.blueGrey,
            itemBuilder: (BuildContext context) {
              return ConstantsProfiletMenu.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, .8)),
        child: ListView(
          padding: EdgeInsets.only(bottom: 50.0),
          children: <Widget>[
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 200,
                        color: Color.fromRGBO(10, 90, 150, .8),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          AnimatedPageRoute(
                            page: ViewPhotoChat(destination: widget.destination),
                          ),
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.width * .6,
                          width: MediaQuery.of(context).size.width * .6,
                          margin: EdgeInsets.only(top: 70),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              width: 1,
                              color: Colors.white54,
                            ),
                            borderRadius: BorderRadius.circular(2),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(widget.destination!.imageUrl),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .9,
                  margin: EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.destination!.name,
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "serif"),
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 180,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 0)),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: RaisedButton(
                          color: Color.fromRGBO(9, 86, 164, .5),
                          onPressed: () {
                            Navigator.push(
                              context,
                              AnimatedPageRouteSlide(
                                  page: ChatDestinationScreen(
                                destination: widget.destination,
                              )),
                            );
                          },
                          child: Text(
                            'Text',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontFamily: 'serif',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: RaisedButton(
                          color: Colors.white,
                          onPressed: () {},
                          child: Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontSize: 15.0,
                              fontFamily: 'serif',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 15,
                  endIndent: 15,
                  color: Color.fromRGBO(10,90,150,.8),
                  thickness: 3,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.school,
                            color: Colors.black38,
                            size: 15.0,
                          ),
                          SizedBox(width: 5.0),
                          Container(
                            width: MediaQuery.of(context).size.width * .85,
                            child: Text(
                              "I study " + widget.destination!.course,
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Color.fromRGBO(0, 0, 0, 1),
                                //fontFamily: 'serif',
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Icon(
                            Icons.school,
                            color: Colors.black38,
                            size: 15.0,
                          ),
                          SizedBox(width: 5.0),
                          Container(
                            width: MediaQuery.of(context).size.width * .85,
                            child: Text(
                              "Faculty of " + widget.destination!.faculty,
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Color.fromRGBO(0, 0, 0, 1),
                                //fontFamily: 'serif',
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.black38,
                            size: 15.0,
                          ),
                          SizedBox(width: 5.0),
                          Container(
                            width: MediaQuery.of(context).size.width * .85,
                            child: Text(
                              "Year of study: 2nd year",
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Color.fromRGBO(0, 0, 0, 1),
                                //fontFamily: 'serif',
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Icon(
                            Icons.work,
                            color: Colors.black38,
                            size: 15.0,
                          ),
                          SizedBox(width: 5.0),
                          Container(
                            width: MediaQuery.of(context).size.width * .85,
                            child: Text(
                              "Work experience: 90-days",
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Color.fromRGBO(0, 0, 0, 1),
                                //fontFamily: 'serif',
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance,
                            color: Colors.black38,
                            size: 16.0,
                          ),
                          SizedBox(width: 5.0),
                          Container(
                            width: MediaQuery.of(context).size.width * .85,
                            child: Text(
                              "Studies at " +
                                  widget.destination!.university.name,
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Color.fromRGBO(0, 0, 0, 1),
                                //fontFamily: 'serif',
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .8,
                      margin: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Pianist(musician).\nFullstack Software, Website, and MobileApp\n"
                        "Developer(Programmer).\nMentor.\nStress and Enxiety Counselor.\n"
                        "Inventor and Entrepreneur",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Color.fromRGBO(0, 0, 0, 1),
                          //fontFamily: 'serif',
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              height: 10.0,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: 10.0, color: Color.fromRGBO(125, 125, 125, .4)),
                ),
              ),
            ),
            for (var index = 2; index < 6; index++)
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            '${postByUser[index].date}',
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, .4),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Text(
                        postByUser[index].text,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: "cursive-monospace",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        AnimatedPageRoute(
                          page: StudentPostDestinationScreen(
                            destination: postByUser[index],
                            liked: _likes[index],
                            index: index,
                            notifyParent: refresh,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.blueGrey[700]),
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              child: postByUser[index].imgPostUrl == ""
                                  ? null
                                  : Image.asset(postByUser[index].imgPostUrl),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      [Colors.red, Colors.deepOrangeAccent],
                                    );
                                  },
                                ),
                                iconSize: 22.0,
                                onPressed: () {
                                  setState(() {
                                    _likes[index] = !_likes[index];
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
                                        Color.fromRGBO(9, 86, 164, 1)
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
                                        Color.fromRGBO(9, 86, 164, 1),
                                        Colors.black54
                                      ],
                                    );
                                  },
                                ),
                                iconSize: 22.0,
                                onPressed: () async {
                                  final ByteData bytes = await rootBundle
                                      .load(postByUser[index].imgPostUrl);
                                  // Share.files(
                                  //     "share file from stugetow",
                                  //     {
                                  //       "image.png": bytes.buffer.asUint8List(),
                                  //     },
                                  //     "*/*",
                                  //     text: postByUser[index].text);
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
                                      Color.fromRGBO(9, 86, 164, 1),
                                      Colors.deepOrangeAccent
                                    ],
                                  );
                                }),
                            iconSize: 21.0,
                            onPressed: () {
                              _postBottomMenuOptions(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 10.0,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 10.0,
                            color: Color.fromRGBO(125, 125, 125, .1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showBottomComment(context) {
    final Color backgroundColor = Color.fromRGBO(0, 0, 0, .4);
    final Color textBackground = Color.fromRGBO(126, 168, 189, .9);

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
                      duration: Duration(milliseconds: 300),
                      height: _isKeyboardVisible
                          ? 437 //MediaQuery.of(context).size.height*.51
                          : MediaQuery.of(context).size.height * .9,
                      padding: EdgeInsets.only(top: 50.0, bottom: 63.0),
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
                              index < postByUser.length;
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
                                                postByUser[index]
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
                                                    postByUser[index]
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
                                                'posted on: ${postByUser[index].date}',
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
                            Container(
                              width: MediaQuery.of(context).size.width * .8,
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

  void _postBottomMenuOptions(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.40,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  onPressed: () => {},
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
                FlatButton(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  onPressed: () => {},
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
                FlatButton(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  onPressed: () => {},
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
                FlatButton(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  onPressed: () => {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.bubble_chart,
                          color: Colors.blueGrey,
                          size: 30.0,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Add to Relevant Company",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "add company to your relevant jobs",
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
                FlatButton(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  onPressed: () => {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.file_upload,
                          color: Colors.blueGrey,
                          size: 30.0,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Send your Curriculum Vitae",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "upload and send a cv for the job posted",
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
      },
    );
  }

  void onClickMenu(String item) {
    if (item == ConstantsProfiletMenu.report) {
      Navigator.push(
        context,
        AnimatedPageRouteSlide(
          page: null,
        ),
      );
    } else if (item == ConstantsProfiletMenu.follow) {
      Navigator.push(
        context,
        AnimatedPageRouteSlide(
          page: null,
        ),
      );
    } else if (item == ConstantsProfiletMenu.block) {
      Navigator.pushReplacement(
        context,
        AnimatedPageRouteSlide(
          page: null,
        ),
      );
    }
  }

  void initState() {
    super.initState();
    // KeyboardVisibilityNotification().addNewListener(
    //   onChange: (bool visible) {
    //     _isKeyboardVisible = visible;
    //   },
    // );
  }

  refresh(dynamic isLiked, int position) {
    setState(() {
      _likes[position] = isLiked;
    });
  }
}
