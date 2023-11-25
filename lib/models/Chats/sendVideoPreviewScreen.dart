import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stugetow/views/separateClasses/Chats/Users.dart';
import 'package:video_player/video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';

// ignore: must_be_immutable
class SendVideoPreviewScreen extends StatefulWidget {
  List<File>? fileList;
  final User? destination;

  SendVideoPreviewScreen({this.fileList, this.destination});

  @override
  _SendVideoPreviewScreenState createState() => _SendVideoPreviewScreenState();
}

class _SendVideoPreviewScreenState extends State<SendVideoPreviewScreen> {
  final CarouselController _carouselController = new CarouselController();
  TextEditingController? _typingController;
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;

  List<TextEditingController?> _textEditingControllerList = [];
  List<VideoHolder> _videoHolderList = [];
  List<File>_attachedfiles = [];
  int idxBottom = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      // resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
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
            Container(
              padding: EdgeInsets.only(top: 7.5, bottom: 7.5),
              child: Row(
                children: [
                  Container(
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundImage: AssetImage(widget.destination!.imageUrl),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    width: MediaQuery.of(context).size.width * .4,
                    child: Text(
                      widget.destination!.name,
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
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.tag_faces_rounded,
              color: Colors.white,
            ),
            iconSize: 27.0,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.edit_outlined,
              color: Colors.white,
            ),
            iconSize: 27.0,
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.black.withOpacity(.5),
          onPressed: () {
            setState(() {
              if (_videoHolderList[idxBottom].vcontroller!.value.isPlaying) {
                _videoHolderList[idxBottom].vcontroller!.pause();
              } else {
                _videoHolderList[idxBottom].vcontroller!.play();
              }
            });
          },
          child: Icon(
            _videoHolderList[idxBottom].vcontroller!.value.isPlaying
                ? Icons.pause
                : Icons.play_arrow,
          ),
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: _videoHolderList[idxBottom].initVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final Size size = _videoHolderList[idxBottom].vcontroller!.value.size;
                return CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: false,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: onPageChanged,
                  ),
                  items: _videoHolderList.map((item) =>ClipRect(
                    child: OverflowBox(
                      maxHeight: double.infinity,
                      alignment: Alignment.center,
                      child: FittedBox(
                        alignment: Alignment.center,
                        child: Container(
                          height: size.height,
                          width: size.width,
                          child: VideoPlayer(_videoHolderList[idxBottom].vcontroller!),
                        ),
                      ),
                    ),
                  )).toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 0.0+MediaQuery.of(context).viewInsets.bottom,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.4),
              ),
              padding: EdgeInsets.only(top: 4.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: 70,
                    margin: EdgeInsets.only(left: 5,right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          child: Container(
                            margin: EdgeInsets.all(2),
                            height: 60,
                            width: 60,
                            color: Colors.blueGrey[800],
                            child: InkWell(
                              splashColor: Colors.white54,
                              onTap: () async {
                               _uploadVideoFile();
                              },
                              child: Icon(
                                Icons.add_photo_alternate_outlined,
                                size:
                                30,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _videoHolderList.length,
                            itemBuilder: (BuildContext context, int count){
                              return GestureDetector(
                                onTap: ()=>{
                                  _carouselController.jumpToPage(count)
                                },
                                child: Stack(
                                  children: [
                                    Card(
                                      color: idxBottom==count?Colors.yellowAccent:null,
                                      child: Container(
                                        margin: EdgeInsets.all(2),
                                        height: 60,
                                        width: 60,
                                        child: VideoPlayer(_videoHolderList[count].vcontroller!),
                                      ),
                                    ),

                                    idxBottom==count?Positioned(
                                      top: 0.0,
                                      right: 0.0,
                                      child: IconButton(
                                        padding: EdgeInsets.all(4.0),
                                        alignment: Alignment.topRight,
                                        icon: Icon(
                                          Icons.close,size: 30,
                                          color: Colors.blue,
                                        ),
                                        onPressed: (){
                                          if(widget.fileList!.length==1){
                                            widget.fileList!.removeAt(count);
                                            _videoHolderList.removeAt(count);
                                            _textEditingControllerList.removeAt(count);
                                            Navigator.pop(context);
                                          }
                                          count==0? _carouselController.nextPage():_carouselController.previousPage();
                                          widget.fileList!.removeAt(count);
                                          _videoHolderList.removeAt(count);
                                          _textEditingControllerList.removeAt(count);
                                        },
                                      ),
                                    ):Text(''),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .8,
                              padding: EdgeInsets.only(bottom: 5.0),
                              child: new ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight: 250),
                                child: TextField(
                                  controller: _typingController,
                                  focusNode: FocusNode(),
                                  maxLines: null,
                                  cursorColor: Colors.blueGrey,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[100],
                                    fontSize: 22.0,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Type a caption...",
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[400],
                                      fontSize: 20.0,
                                    ),
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    print("chatting..");
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        margin: EdgeInsets.only(top: 5.0),
                        child: ClipOval(
                          child: Material(
                            elevation: 15.0,
                            color: Colors.teal[800],
                            child: InkWell(
                              splashColor: Colors.blueGrey[500],
                              child: SizedBox(
                                width: 41,
                                height: 41,
                                child: Icon(Icons.send, color: Colors.white),
                              ),
                              onTap: () => {
                                Navigator.pop(context),
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
        ],
      ),
    );
  }

  void onPageChanged(int index, CarouselPageChangedReason reason){
    setState(() {
      idxBottom = index;
      _videoHolderList[idxBottom].vcontroller!.pause();
    });
  }
  Future _uploadVideoFile() async {
    _attachedfiles.clear();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'mp4',
        'mov',
        'wmv',
        'avi',
        'webm',
        'mkv'
      ],
    );
    if (result != null) {
      _attachedfiles = result.paths.map((path) => File(path!)).toList();
      for (var num = 0; num < _attachedfiles.length; ++num) {
        File img = _attachedfiles[num];
        widget.fileList!.add(img);

        _controller = new VideoPlayerController.file(File(_attachedfiles[num].path));
        _initializeVideoPlayerFuture = _controller!.initialize();
        _controller!.setLooping(true);
        VideoHolder videoHolder = new VideoHolder(_controller, _initializeVideoPlayerFuture);
        _videoHolderList.add(videoHolder);

        _textEditingControllerList.add(new TextEditingController());
      }
      _carouselController.jumpToPage(_videoHolderList.length-1);
      setState(() {idxBottom = _videoHolderList.length-1;});
    }
    else print("couldn't upload file.");
  }

  @override
  void initState() {
    super.initState();
    _videoHolderList.clear();
    _textEditingControllerList.clear();

    for (var i = 0; i < widget.fileList!.length; i++) {
      _controller = new VideoPlayerController.file(File(widget.fileList![i].path));
      _initializeVideoPlayerFuture = _controller!.initialize();
      _controller!.setLooping(true);
      VideoHolder videoHolder = new VideoHolder(_controller, _initializeVideoPlayerFuture);
      _videoHolderList.add(videoHolder);

      _typingController = new TextEditingController();
      _textEditingControllerList.add(_typingController);
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (var i=0; i<_videoHolderList.length; ++i){
      _videoHolderList[i].vcontroller!.dispose();
      _textEditingControllerList[i]!.dispose();
    }
  }
}

class VideoHolder {
  final VideoPlayerController? vcontroller;
  final Future<void>? initVideoPlayerFuture;
  VideoHolder(this.vcontroller, this.initVideoPlayerFuture);
}
