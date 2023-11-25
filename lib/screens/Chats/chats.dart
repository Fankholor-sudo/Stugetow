import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stugetow/models/Chats/contacts_fav.dart';
import 'package:stugetow/models/Institutions/PopupMenu/viewUsers.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRoute.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteSlide.dart';
import 'package:stugetow/screens/Chats/ChatDestination.dart';
import 'package:stugetow/screens/Chats/UserProfileDestination.dart';
import 'package:stugetow/screens/Chats/ViewPhoto.dart';
import 'package:stugetow/views/separateClasses/Chats/messages.dart';

class Likes extends StatefulWidget {
  final Function notifyParent;
  Likes({Key? key, required this.notifyParent}) : super(key: key);

  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
            AnimatedPageRouteSlide(
              page: ViewUsers(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: ListView(
                  padding: EdgeInsets.only(bottom: 60.0),
                  children: <Widget>[
                    ContactFavorite(),
                    Container(
                      height: 5.0,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 5.0,
                              color: Color.fromRGBO(125, 125, 125, .1),
                          ),
                        ),
                      ),
                    ),
                    for (var index = 0; index < postByUser.length; index++)
                      InkWell(
                        splashColor: Colors.blueGrey,
                        onTap: () => Future.delayed(Duration(milliseconds: 200),(){
                            Navigator.push(context,
                            AnimatedPageRouteSlide(page: ChatDestinationScreen(
                              destination:postByUser[index].sender,
                            )));
                        }),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                _profilePopup(context,index);
                                              },
                                              child: CircleAvatar(
                                                radius: 25.0,
                                                backgroundImage: AssetImage(
                                                    postByUser[index].sender.imageUrl,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                              Container(
                                                margin: EdgeInsets.only(bottom: 8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.only( top: 4.0),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width *.45,
                                                        child: Text(
                                                          postByUser[index].sender.name,
                                                          style: TextStyle(
                                                            color: Colors.black87,
                                                            fontSize: 16,
                                                            fontWeight:FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only( top: 3.0),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width * .6,
                                                        child: Text(
                                                          "how have i been ths day today post[index].date"+"how have i been ths day today post[index].date",
                                                          style: TextStyle(
                                                            color: Color.fromRGBO(100, 100, 100, 1),
                                                            fontSize: 14,
                                                            fontFamily: "cursive-monospace",
                                                            fontWeight:FontWeight.w400,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                           // ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                postByUser[index].date,
                                                style: TextStyle(
                                                  color:
                                                      Color.fromRGBO(0, 0, 0, .4),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11.0,
                                                ),
                                              ),
                                              SizedBox(height: 5.0),
                                              Text(
                                                "new",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.redAccent,
                                                  fontSize: 11.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                 ),
                              Container(
                                margin: EdgeInsets.only(top:1),
                                width: MediaQuery.of(context).size.width*.7,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        width: .2,
                                        color: Color.fromRGBO(125, 125, 125, .5)),
                                  ),
                                ),
                              ),
                            ],
                          ),
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

  void _profilePopup(context, int index){
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
          margin: EdgeInsets.only(
            top: 100.0,
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(context,
                  AnimatedPageRoute(page:ViewPhotoChat(destination: postByUser[index].sender),
                  ),
                ).then((result){Navigator.of(context).pop();}),
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
                        image: AssetImage(postByUser[index].sender.imageUrl),
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
                    FlatButton.icon(
                      onPressed: ()=> Navigator.push(context,
                        AnimatedPageRoute(page:UserDestinationScreen(destination: postByUser[index].sender),
                        ),
                      ).then((result){Navigator.of(context).pop();}),
                      icon: Icon(Icons.person, color: Colors.white60),
                      label: Text("profile",style:TextStyle(color:Colors.white60)),
                    ),
                    FlatButton.icon(
                      onPressed: ()=>Navigator.push(context,
                        AnimatedPageRoute(page:ViewPhotoChat(
                              destination: postByUser[index].sender
                          ),
                        ),
                      ).then((result){Navigator.of(context).pop();}),
                      icon: Icon(Icons.photo, color:Colors.white60),
                      label: Text("photo",style:TextStyle(color:Colors.white60)),
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
      pageBuilder: (context,
          animation1, animation2) {
        return Text("picture");
      },
    );
  }
  @override
  void initState() {
    super.initState();
  }
}
