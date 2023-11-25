import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteSlide.dart';
import 'package:stugetow/screens/CompanyState/StateDestinations.dart';
import 'package:stugetow/views/separateClasses/Company/jobsFeeds.dart';
import 'package:stugetow/views/separateClasses/Relevant_to_you/RelevantJobposts.dart';

class AddToRelevantPage extends StatefulWidget {
  @override
  _AddToRelevantPageState createState() => _AddToRelevantPageState();
}

class _AddToRelevantPageState extends State<AddToRelevantPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        titleSpacing: 0,
        elevation: 1,
        brightness: Brightness.dark,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.blueAccent[200]),
          iconSize: 25.0,
          onPressed: () => Navigator.pop(context,),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                "Add to MyJobs",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
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
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Be advised that by adding a company in this page, you will start receiving notifications and seeing it's "
                    "posts on  myJobs(Relevant Company) page, so make sure you want to add it.",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black.withOpacity(0.3),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                overflow: TextOverflow.visible,
              ),
            ),

            for (var index = 0; index < relevantPosts.length; ++index)
              Container(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                    AnimatedPageRouteSlide(
                                      page: StateDestinationScreen(
                                        destination: relevantPosts[index].sender,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 24.0,
                                      backgroundImage: AssetImage(
                                          relevantPosts[index].sender.imageUrl
                                      ),
                                    ),
                                    SizedBox(width: 10.0,),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Text(
                                            relevantPosts[index].sender.name,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Container(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0.5,
                                            child: Text(
                                              'Company',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, .5),
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
                              TextButton(
                                onPressed: () {
                                  _addDialog(context, index);
                                },
                                child: Text(
                                  'Add',
                                  style: TextStyle(
                                    color: Colors.blueAccent[200],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _addDialog(context, int index) {
    showGeneralDialog(
      transitionDuration: Duration(milliseconds: 200),
      transitionBuilder: (context, animation, anim2, widget) {
        double sidesvert = MediaQuery
            .of(context)
            .size
            .height;
        double sideshor = MediaQuery
            .of(context)
            .size
            .height;
        return ScaleTransition(
          alignment: Alignment.center,
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.bounceIn,
            reverseCurve: Curves.linear,
          ),
          child: Container(
            margin: EdgeInsets.only(
                top: sidesvert * .41,
                bottom: sideshor * .43,
                left: sideshor * .08,
                right: sideshor * .08),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Are you sure you want to add ${relevantPosts[index].sender.name} to MyJobs Page?",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 17.0,
                        backgroundImage: AssetImage(
                            relevantPosts[index].sender.imageUrl
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        relevantPosts[index].sender.name,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,//white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top:10),
                        height: 30,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.close, color: Colors.blueAccent[200], size: 18),
                              Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:10),
                        height: 30,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.check, color: Colors.greenAccent[700], size: 18),
                              Text(
                                "Add",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      barrierLabel: "",
      barrierColor: Color.fromRGBO(0, 0, 0, .4),
      barrierDismissible: true,
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Text("");
      },
    );
  }
}
