import 'package:flutter/material.dart';
import 'package:stugetow/views/separateClasses/Company/jobsFeeds.dart';

class CompanyCommentDestination extends StatefulWidget {
  final CompanyJobFeeds? destination;
  CompanyCommentDestination({this.destination});

  @override
  _CompanyCommentDestinationState createState() => _CompanyCommentDestinationState();
}

class _CompanyCommentDestinationState extends State<CompanyCommentDestination> {
  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Colors.white;
    final Color? appBarColor = Colors.blueGrey[600];
    final Color leftTextBackground = Colors.white;
    // final Color rightTextBackground = Color.fromRGBO(126, 168, 189, 1);

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(top: 60.0, bottom: 60.0),
                    decoration: BoxDecoration(color: backgroundColor),
                    child: ListView(
                      children: [
                        for (var index = 0; index < 10; index++)
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: leftTextBackground,
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(1.0, 0),
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(top: 0.0),
                                          child: CircleAvatar(
                                            radius: 16.0,
                                            backgroundImage: AssetImage(
                                                allJobPosts[index].sender.imageUrl
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),

                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only( top: 4.0),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width *.45,
                                                child: Text(
                                                  allJobPosts[index].sender.name,
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 13,
                                                    fontWeight:FontWeight.bold,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'posted on: ${allJobPosts[index].date}',
                                              style: TextStyle(
                                                color: Color.fromRGBO(0, 0, 0, .4),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "chats..., nice chats\nisn't it guys..\ni would really not mind to read all of it",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
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
                  Container(
                    decoration: BoxDecoration(color: appBarColor),
                    padding: EdgeInsets.zero,
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 21.0),
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios, size:18.0),
                                  color: Colors.white,
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(top: 35.0),
                                width: MediaQuery.of(context).size.width * .55,
                                child: Text(
                                  "Comments",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 21.0,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: Container(
                      decoration: BoxDecoration(color: backgroundColor, boxShadow: [
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
                                      child:
                                      Icon(Icons.record_voice_over, color: Colors.white, size:16.0),
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
            ],
          ),
        ),
      ),
    );
  }
}
