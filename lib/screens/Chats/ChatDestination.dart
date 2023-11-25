import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stugetow/models/Chats/chat_menuItems.dart';
import 'package:stugetow/models/Chats/sendImagePreviewScreen.dart';
import 'package:stugetow/models/Chats/sendVideoPreviewScreen.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteSlide.dart';
import 'package:stugetow/models/mainPage/pdfPreview.dart';
import 'package:stugetow/screens/Chats/UserProfileFromChat.dart';
import 'package:stugetow/views/separateClasses/Chats/Users.dart';
import 'package:stugetow/models/Chats/sendAudioPreviewScreen.dart';

class ChatDestinationScreen extends StatefulWidget {
  final dynamic destination;

  ChatDestinationScreen({this.destination});

  @override
  _ChatDestinationScreenState createState() => _ChatDestinationScreenState();
}

class _ChatDestinationScreenState extends State<ChatDestinationScreen> {
  List<String> _attachedNames = [];
  List<File> _attachedfiles = [];
  List<PDFDocument> _pdfFilesList = [];
  final picker = ImagePicker();

  TextEditingController? _typingController;
  final Color backgroundColor = Color.fromRGBO(161, 202, 241, .15);
  final Color? appBarColor = Colors.blueGrey[800];
  final Color leftTextBackground = Color.fromRGBO(2, 111, 133, .5);
  final Color? rightTextBackground = Colors.teal[800];

  bool isTyping = false;
  List<chatMsg> messages = [
    chatMsg('user', 'hey', '16:20', '12-09-2020'),
    chatMsg('me', 'hey friend', '16:20', '12-09-2020'),
    chatMsg('user', 'how are you doing', '16:21', '12-09-2020'),
    chatMsg(
        'me',
        'I am doing great and thank you for asking, it has been a while not seing you, where have you been?',
        '16:23',
        '12-09-2020'),
    chatMsg(
        'user',
        'I have been very great and thank you for asking, how is stugetow coming so far. '
            'I heared you have employed your GirlFriend now, that is very good of you',
        '16:25',
        '12-09-2020'),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        titleSpacing: 0,
        backgroundColor: appBarColor,
        brightness: Brightness.dark,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              iconSize: 25.0,
              onPressed: () => Navigator.pop(
                context,
              ),
            ),
            InkWell(
              splashColor: Colors.blueGrey[500],
              onTap: () => Future.delayed(Duration(milliseconds: 200), () {
                Navigator.push(
                    context,
                    AnimatedPageRouteSlide(
                        page: UserProfileFromChatDestination(
                      destination: widget.destination,
                    )));
              }),
              child: Container(
                padding: EdgeInsets.only(top: 7.5, bottom: 7.5),
                child: Row(
                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundImage:
                            AssetImage(widget.destination.imageUrl),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      width: MediaQuery.of(context).size.width * .42,
                      child: Text(
                        widget.destination.name,
                        style: TextStyle(
                            fontSize: 21.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.phone,
              color: Colors.white,
            ),
            iconSize: 25.0,
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: null,
            icon: Icon(Icons.more_vert, color: Colors.white),
            color: Colors.blueGrey,
            itemBuilder: (BuildContext context) {
              return ConstantsChatMenu.choices.map((String choice) {
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
        height: MediaQuery.of(context).size.height,
        padding: MediaQuery.of(context).viewInsets.bottom != 0
            ? EdgeInsets.only(bottom: 50)
            : EdgeInsets.zero,
        decoration: BoxDecoration(color: backgroundColor),
        child: ListView(
          children: [
            for (var index = 0; index < messages.length; index++)
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        right: (messages[index].from == 'me' ? 10 : 0),
                        left: (messages[index].from == 'me' ? 0 : 10),
                        top: ((index>0 && messages[index].from==messages[index-1].from)? 4 : 10),
                    ),
                    child: Row(
                      mainAxisAlignment: messages[index].from == 'me'
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: messages[index].from == 'me'
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          width: MediaQuery.of(context).size.width * .8,
                          decoration: BoxDecoration(
                            color: messages[index].from == 'me'
                                ? rightTextBackground
                                : leftTextBackground,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 1.0,
                                spreadRadius: 0.0,
                                offset: Offset(0.0, 1.0),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // "chats..., nice chats\nisn't it guys..\ni would really not mind to read all of\n"
                                "${messages[index].msg}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height:3.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${messages[index].time} | ${messages[index].date}',
                                    style: TextStyle(
                                      color: Colors.grey[300],
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
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
                ],
              ),
            SizedBox(height:10),
          ],
        ),
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: BottomAppBar(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, .1),
                  width: 1.0,
                ),
              ),
            ),
            padding: EdgeInsets.only(top: 5.0),
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                isTyping
                    ? Container(height: 10, width: 1)
                    : IconButton(
                        padding: EdgeInsets.only(top: 5.0),
                        icon: Icon(
                          Icons.keyboard_voice_sharp,
                          size: 28.0,
                          color: Colors.blueGrey,
                        ),
                        onPressed: () {},
                      ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withOpacity(.0),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width *
                        (isTyping ? 0.85 : 0.6),
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: new ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 130.0),
                      child: TextField(
                        controller: _typingController,
                        focusNode: FocusNode(),
                        maxLines: null,
                        cursorColor: Colors.blueGrey,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          fontSize: 22.0,
                        ),
                        decoration: InputDecoration(
                          hintText: "Type text...",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade400,
                            fontSize: 22.0,
                          ),
                          contentPadding: EdgeInsets.all(5.0),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          List<String> split = _typingController!.text.split(' ');
                          setState(() {
                            _typingController!.text.length == split.length - 1
                                ? isTyping = false : isTyping = true;
                          });
                          print(value);
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    isTyping
                        ? Container(height: 10, width: 1)
                        : IconButton(
                            padding: EdgeInsets.only(top: 5.0),
                            icon: Icon(
                              Icons.apps,
                              size: 28.0,
                              color: Colors.blueGrey,
                            ),
                            onPressed: () {
                              _multiMediaDialog(context, widget.destination);
                            },
                          ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      margin: EdgeInsets.only(top: 5.0, right: 10.0),
                      child: ClipOval(
                        child: Material(
                          elevation: 15.0,
                          color: rightTextBackground,
                          child: InkWell(
                            splashColor: Colors.blueGrey[500],
                            child: SizedBox(
                              width: 41,
                              height: 41,
                              child: Icon(Icons.send, color: Colors.white),
                            ),
                            onTap: () {
                              SystemChannels.textInput.invokeMethod('TextInput.hide');
                              messages.add(new chatMsg('user',_typingController!.text,'16:50','12-09-2020'));
                              _typingController!.text = '';
                              isTyping=false;
                            },
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
      ),
    );
  }

  void _multiMediaDialog(BuildContext context, User? user) {
    showGeneralDialog(
      transitionDuration: Duration(milliseconds: 200),
      transitionBuilder: (BuildContext diaContext, animation, anim2, widget) {
        double _height = MediaQuery.of(diaContext).size.height;
        double _width = MediaQuery.of(diaContext).size.width;
        return ScaleTransition(
          alignment: Alignment.bottomRight,
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.linear,
            reverseCurve: Curves.bounceIn,
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(
              top: _height * 0.7 - MediaQuery.of(diaContext).viewInsets.bottom,
              bottom:
                  _height * 0.08 + MediaQuery.of(diaContext).viewInsets.bottom,
              right: _width * 0.03,
              left: _width * 0.03,
            ),
            decoration: BoxDecoration(
              color: Colors.blueGrey[800],
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          _uploadImageFile()
                              .then((value) => _attachedfiles.isNotEmpty
                                  ? Navigator.push(
                                      diaContext,
                                      AnimatedPageRouteSlide(
                                          page: SendImagePreviewScreen(
                                        destination: user,
                                        imageList: _attachedfiles,
                                        type: 'galary',
                                      )),
                                    )
                                  : null)
                              .then((value) => Navigator.pop(diaContext));
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              color: Colors.deepOrangeAccent,
                              size: 40,
                            ),
                            Text(
                              "Gallery",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          _uploadCameraImage()
                              .then((value) => Navigator.pop(diaContext))
                              .then((value) => {
                                    _attachedfiles.isNotEmpty
                                        ? Navigator.push(
                                            diaContext,
                                            AnimatedPageRouteSlide(
                                              page: SendImagePreviewScreen(
                                                destination: user,
                                                imageList: _attachedfiles,
                                                type: 'camera',
                                              ),
                                            ),
                                          )
                                        : null,
                                  });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera,
                              color: Colors.blue[400],
                              size: 40,
                            ),
                            Text(
                              "Camera",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          _uploadPdfFile().then(
                            (value) => Navigator.push(
                              context,
                              AnimatedPageRouteSlide(
                                page: SelectedPdfPreview(
                                  pdfNames: _attachedNames,
                                  pdfdocumentList: _pdfFilesList,
                                  user: user,
                                ),
                              ),
                            ),
                          );
                          Navigator.pop(diaContext);
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.description,
                              color: Colors.redAccent[100],
                              size: 40,
                            ),
                            Text(
                              "Document",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        _uploadVideoFile()
                            .then((value) => _attachedfiles.isEmpty
                                ? null
                                : Navigator.push(diaContext,
                                    AnimatedPageRouteSlide(
                                        page: SendVideoPreviewScreen(
                                      destination: user,
                                      fileList: _attachedfiles,
                                    )),
                                  ))
                            .then((value) => Navigator.pop(diaContext));
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.video_library,
                            color: Colors.purpleAccent[100],
                            size: 40,
                          ),
                          Text(
                            "Video",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        // _uploadMusicFile().then((value) => Navigator.pop(diaContext)).then((value) =>
                        //     Navigator.push(diaContext,
                        //       AnimatedPageRouteSlide(
                        //           page: SelectedAudioPreview(
                        //             user: user,
                        //             audioList: _attachedfiles,
                        //           ),
                        //       ),
                        //     ),
                        // );
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.headset,
                            color: Colors.yellow[700],
                            size: 40,
                          ),
                          Text(
                            "Audio",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(diaContext);
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.my_location,
                            color: Colors.green[700],
                            size: 40,
                          ),
                          Text(
                            "Location",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
      barrierLabel: "",
      barrierColor: Color.fromRGBO(0, 0, 0, 0.1),
      barrierDismissible: true,
      context: _scaffoldKey.currentContext!,
      pageBuilder: (diaContext, animation1, animation2) {
        return Text('');
      },
    );
  }

  Future _uploadPdfFile() async {
    _attachedfiles.clear();
    _attachedNames.clear();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'zip', 'txt', 'rar', 'ppt', 'doc'],
    );
    if (result != null) {
      _attachedfiles = result.paths.map((path) => File(path!)).toList();
      _pdfFilesList.clear();

      for (var num = 0; num < _attachedfiles.length; ++num) {
        PDFDocument doc = await PDFDocument.fromFile(_attachedfiles[num]);
        _attachedNames.insert(num, basename(_attachedfiles[num].path));
        _pdfFilesList.insert(num, doc);
      }
    } else
      print("couldn't upload file.");
  }

  Future _uploadImageFile() async {
    _attachedfiles.clear();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
        'jpeg',
        'gif',
        'tiff',
      ],
    );
    if (result != null) {
      _attachedfiles = result.paths.map((path) => File(path!)).toList();
    } else
      print("couldn't upload file.");
  }

  Future _uploadCameraImage() async {
    _attachedfiles.clear();
    final image = await picker.getImage(source: ImageSource.camera);

    if (image != null) {
      File _uploadedFile = File(image.path);
      _attachedfiles.add(_uploadedFile);
    } else
      print("couldn't upload file.");
  }

  Future _uploadVideoFile() async {
    _attachedfiles.clear();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['mp4', 'mov', 'wmv', 'avi', 'webm', 'mkv'],
    );
    if (result != null) {
      _attachedfiles = result.paths.map((path) => File(path!)).toList();
    } else
      print("couldn't upload file.");
  }

  Future _uploadMusicFile() async {
    _attachedfiles.clear();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );
    if (result != null) {
      _attachedfiles = result.paths.map((path) => File(path!)).toList();

      for (var num = 0; num < _attachedfiles.length; ++num) {
        File music = _attachedfiles[num];
        print('music : ${basename(music.path)}');
      }
    } else {
      print("couldn't upload file.");
    }
  }

  @override
  void initState() {
    super.initState();
    _typingController = new TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _typingController!.dispose();
  }
}

class chatMsg {
  final String from;
  final String msg;
  final String time;
  final String date;

  chatMsg(this.from, this.msg, this.time, this.date);
}
