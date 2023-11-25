import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:stugetow/models/Institutions/sharePostSettings.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteSlide.dart';
import 'package:stugetow/models/mainPage/Loading.dart';
import 'package:stugetow/services/auth.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'package:stugetow/views/separateClasses/Chats/Student.dart';

class SharePost extends StatefulWidget {
  final Function? addPost;
  SharePost({Key? key, this.addPost}) : super(key: key);

  @override
  _SharePostState createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> {
  bool? _settingsDisabledComment;
  bool _isTyping = false;
  bool _inProcess = false;
  bool _isImageSelected = false;
  final picker = ImagePicker();
  File? _image;

  TextEditingController? _textEditingController;
  FocusNode? _textFocusNode;

  static var _postDate = new DateTime.now();
  static var now = new TimeOfDay.fromDateTime(DateTime.parse(_postDate.toString()));
  String _postTime = now.toString().substring(10, 15);
  DateFormat dateFormat = new DateFormat("dd MMMM yyyy");

  Future _pickTime(context) async {
    TimeOfDay? timePick = await showTimePicker(context: context, initialTime: new TimeOfDay.now());
    if (timePick != null) {
      setState(() {
        _postTime = timePick.toString().substring(10, 15);
      });
    }
  }

  Future _pickDate(context) async {
    DateTime? datePick = await showDatePicker(context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(Duration(days: -365)),
        lastDate: new DateTime.now().add(Duration(days: 365)));
    if (datePick != null) {
      setState(() {
        _postDate = datePick;
      });
    }
  }

  AuthService _auth = AuthService();
  late Student _student;

  @override
  Widget build(BuildContext context) {
    return _inProcess? Loading():Scaffold(
      appBar: new AppBar(
        titleSpacing: 0,
        elevation: 1,
        backgroundColor: Colors.grey[50],
        leading:  IconButton(
          icon: Icon(Icons.close,color: Colors.blueAccent[200]),
          iconSize: 30.0,
          onPressed: () => _confirmDialog(context),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                "New post",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
                Icons.check, color: (!_isTyping && !_isImageSelected)? Colors.grey[500]:Colors.blueAccent[200]
            ),
            iconSize: 30.0,
            onPressed: () async {
            if(_isTyping || _isImageSelected) {
              setState((){_inProcess=true;});
              dynamic result = await _auth.postStudent(
                  userParam: _student,
                  date: _postDate.toString(),
                  time: _postTime,
                  text: _textEditingController!.text,
                  img: _image,
                  likes: 0,
                  allowComment: _settingsDisabledComment,
              );
              if(result!=false) {
                print('i guess we good');
                Navigator.pop(context);
              }
              else{
                setState((){_inProcess=false;});
                _showToast(context, 'Connection problem, please try again later!');
              }
            }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      _textFocusNode!.requestFocus();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 60.0),
                    child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: TextFormField(
                            controller: _textEditingController,
                            focusNode: _textFocusNode,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.w400),
                            decoration: new InputDecoration(
                              hintText: "What's new?",
                              hintStyle: TextStyle(fontFamily: 'monospace', fontSize: 20.0),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {
                                value==""?
                                _isTyping=false:_isTyping=true;
                              });
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.black),
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                child: _image!=null?Stack(
                                  children: [
                                    Image.file(_image!),
                                    Positioned(
                                      top: 0.0,
                                      right: 0.0,
                                      child: IconButton(
                                        padding: EdgeInsets.all(4.0),
                                        alignment: Alignment.topRight,
                                        icon: Icon(
                                          Icons.close,size: 40,
                                          color: Colors.blue,
                                        ),
                                        onPressed: (){
                                          setState(() {
                                            _image = null;
                                            _isImageSelected = false;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ):
                                null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 0.0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.grey[50]),
              child: Column(
                children: [
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: ShaderMask(
                              blendMode: BlendMode.srcIn,
                              child: Icon(Icons.insert_photo),
                              shaderCallback: (Rect bounds) {
                                return ui.Gradient.linear(
                                  Offset(4.0, 24.0),
                                  Offset(24.0, 4.0),
                                  [
                                    Colors.red,
                                    Colors.purple
                                  ],
                                );
                              },
                            ),
                            iconSize: 32.0,
                            onPressed: () {
                              _image = null;
                              _getImage(ImageSource.gallery);
                            },
                          ),
                          IconButton(
                            icon: ShaderMask(
                              blendMode: BlendMode.srcIn,
                              child: Icon(Icons.camera_alt),
                              shaderCallback: (Rect bounds) {
                                return ui.Gradient.linear(
                                  Offset(4.0, 24.0),
                                  Offset(24.0, 4.0),
                                  [
                                    Colors.purple,
                                    Colors.red
                                  ],
                                );
                              },
                            ),
                            iconSize: 32.0,
                            onPressed: () {
                              _image = null;
                              _getImage(ImageSource.camera);
                              },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              _dateTimeDialog(context);
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*.4,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      "$_postTime | ${dateFormat.format(_postDate)}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 23,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: ShaderMask(
                              blendMode: BlendMode.srcIn,
                              child: Icon(Icons.settings),
                              shaderCallback: (Rect bounds) {
                                return ui.Gradient.linear(
                                  Offset(4.0, 24),
                                  Offset(24.0, 4.0),
                                  [
                                    Colors.deepOrangeAccent,
                                    Color.fromRGBO(9, 86, 164, 1)
                                  ],
                                );
                              },
                            ),
                            iconSize: 32.0,
                            onPressed: () {
                              Navigator.push(context,
                                AnimatedPageRouteSlide(page: SharePostSettings(notifyParent: refresh,)),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _getImage(ImageSource source) async{
    setState(() {_inProcess=true; _isImageSelected=false;});
    final image = await picker.pickImage(source: source);

    if(image != null){
      final cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1.5),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.blueGrey[700],
          toolbarTitle: "Crop Image",
          toolbarWidgetColor: Colors.blueGrey[100],
          statusBarColor: Colors.blueGrey[700],
          backgroundColor: Colors.white
        )
      );
      setState(() {_image = cropped;_inProcess = false;
      _image==null?_isImageSelected=false:_isImageSelected = true;});
    }
    else{
      setState(() {_inProcess = false;_isImageSelected = false;});
    }
  }
  void _dateTimeDialog(context) {
    showGeneralDialog(
      transitionDuration: Duration(milliseconds: 300),
      transitionBuilder: (context, animation, anim2, widget) {
        double sidesvert = MediaQuery.of(context).size.height;
        double sideshor = MediaQuery.of(context).size.height;
        return ScaleTransition(
          alignment: Alignment.bottomCenter,
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.bounceIn,
            reverseCurve: Curves.bounceIn,
          ),
          child: Container(
            margin: EdgeInsets.only(
                top: sidesvert * .8,
                bottom: sideshor * .08,
                left: sideshor * .12,
                right: sideshor * .12),
            decoration: BoxDecoration(
              color: Colors.blueGrey[700],
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Post on this date",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "$_postTime  |  ${dateFormat.format(_postDate)}",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white.withOpacity(.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  Divider(
                    indent: 15,
                    endIndent: 15,
                    color: Color.fromRGBO(255, 255, 255, .8),
                    thickness: 1,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        child: TextButton(
                          onPressed: () {
                            _pickTime(context).then((result) {
                              Navigator.of(context, rootNavigator:true).pop();
                            });
                          },
                          child: Text(
                            "Time",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: TextButton(
                          onPressed: () {
                            _pickDate(context).then((result) {
                              Navigator.of(context, rootNavigator:true).pop();
                            });
                          },
                          child: Text(
                            "Date",
                            style: TextStyle(
                              color: Colors.white,
                            ),
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

  @override
  void initState(){
    super.initState();
    _getUserDetails();
    setState(() {
      _textEditingController = new TextEditingController(text: null);
      _textFocusNode = new FocusNode();
      _postDate = new DateTime.now();
      now = new TimeOfDay.fromDateTime(DateTime.parse(_postDate.toString()));
      _postTime = "Now";
      _settingsDisabledComment = false;
    });
  }

  @override
  void dispose(){
    super.dispose();
    _textFocusNode!.dispose();
  }

  refresh(dynamic commentDisabled) {
    setState(() {
      _settingsDisabledComment = commentDisabled;
      print('comment: ' + _settingsDisabledComment.toString());
    });
  }

  _getUserDetails() async {
    dynamic result = await _auth.getUserData();
    setState((){
      String? firstname = result['firstname'];
      String? lastname = result['lastname'];
      String? school = result['school'];
      String? faculty = result['faculty'];
      String? course = result['course'];
      String? studyLevel = result['studyLevel'];
      String? work = result['work'];
      String? bio = result['bio'];
      String? role = result['role'];
      String? profileImg = result['profileImg'];
      _student = new Student(
          firstname, lastname, school, faculty, course,
          studyLevel, work, bio, role, profileImg
      );
    });
  }

  _confirmDialog(context){
    showDialog(
        context: context,
        builder: (BuildContext ctxt) {
          return new AlertDialog(
            title: new Text('Are you sure ?'),
            content: new Text('Unsaved data will be lost.'),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.pop(ctxt),
                child: new Text('No'),
              ),
              new TextButton(
                onPressed: () {
                  Navigator.pop(ctxt);
                  Navigator.pop(context);
                },
                child: new Text('Yes'),
              ),
            ],
          );
        }
    );
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: 'Okay', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
