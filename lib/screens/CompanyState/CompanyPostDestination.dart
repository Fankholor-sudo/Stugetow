import 'package:flutter/material.dart';
import 'package:stugetow/models/CompanyState/companyPostDistMenu.dart';
import 'package:stugetow/views/separateClasses/Company/jobsFeeds.dart';
import 'dart:ui' as ui;

class CompanyPostDestinationScreen extends StatefulWidget {
  final dynamic destination;
  final bool? liked;
  final int? index;
  final Function notifyParent;
  CompanyPostDestinationScreen({Key? key,this.destination, this.liked, this.index,required this.notifyParent}):super(key: key);
  @override
  _CompanyPostDestinationScreenState createState() => _CompanyPostDestinationScreenState();
}

class _CompanyPostDestinationScreenState extends State<CompanyPostDestinationScreen> {
  bool isKeyboardVisible = false;
  bool? isliked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          iconSize: 25.0,
          onPressed: () => Navigator.pop(context,),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: null,
            icon: Icon(Icons.more_horiz, color: Colors.white),
            color: Colors.blueGrey,
            itemBuilder: (BuildContext context) {
              return ConstantsCompanyPostMenu.choices.map((String choice) {
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
        color: Colors.black,
        child: Stack(
            children: <Widget>[
              Center(
                child: InteractiveViewer(
                  panEnabled: false,
                  boundaryMargin: EdgeInsets.all(80),
                  minScale: 0.5,
                  maxScale: 4,
                  child: Container(
                    width: double.infinity,
                    color: Colors.blueGrey[700],
                    child: Image.asset(widget.destination.imgPostUrl),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, .8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          child: Icon(!isliked!? Icons.favorite_border:Icons.favorite),
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
                            isliked = !isliked!;
                          });
                          widget.notifyParent(isliked, widget.index);
                        },
                      ),
                      IconButton(
                        icon: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          child: Icon(Icons.comment),
                          shaderCallback: (Rect bounds) {
                            return ui.Gradient.linear(
                              Offset(4.0, 24),
                              Offset(24.0, 4.0),
                              [
                                Colors.deepOrangeAccent,
                                !isliked!?Color.fromRGBO(9, 86, 164, 1):Colors.yellowAccent
                              ],
                            );
                          },
                        ),
                        iconSize: 22.0,
                        onPressed: () {_showBottomComment(context);},
                      ),
                      IconButton(
                        icon: ShaderMask(
                            blendMode: BlendMode.srcIn,
                            child: Icon(Icons.share),
                            shaderCallback: (Rect bounds) {
                              return ui.Gradient.linear(
                                Offset(4.0, 24),
                                Offset(24.0, 4.0),
                                [
                                  Color.fromRGBO(9, 86, 164, 1),
                                  Colors.white
                                ],
                              );
                            }),
                        iconSize: 22.0,
                        onPressed: () async {
                          // final ByteData bytes = await rootBundle.load(allJobPosts[widget.index!].imgPostUrl);
                          // Share.files(
                          //     "share file from stugetow",
                          //     {
                          //       "image.png":bytes.buffer.asUint8List(),
                          //     },
                          //     "*/*",
                          //     text: allJobPosts[widget.index].text
                          // );
                        },
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
    final Color textBackground = Color.fromRGBO(126, 168, 189, .9);//Color.fromRGBO(255, 255, 255, .85);

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
                      height: isKeyboardVisible? 437/*MediaQuery.of(context).viewInsets.bottom*/
                          :MediaQuery.of(context).size.height*.9,
                      padding: EdgeInsets.only(top: 50.0,bottom: 63.0),
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
                          for (var index = 0; index < allJobPosts.length; index++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: Container(
                                margin: const EdgeInsets.only(left:14.0, right:14.0, top: 10.0),
                                padding: const EdgeInsets.only(left:8.0, right:8.0, top: 8.0),
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
                                                allJobPosts[index].sender.imageUrl
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
                                                      fontSize: 12,
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
                                      width: MediaQuery.of(context).size.width*.8,
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
                      top:20.0,
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
                          SizedBox(width: 8.0,),
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
                        decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
                // ),
              ],
            ),
          );
        }
    );
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      isliked = widget.liked;
    });
  }

}
