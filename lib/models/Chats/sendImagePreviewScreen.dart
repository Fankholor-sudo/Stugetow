import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stugetow/views/separateClasses/Chats/Users.dart';

// ignore: must_be_immutable
class SendImagePreviewScreen extends StatefulWidget {
  final User? destination;
  final String? type;
  List<File?>? imageList = [];
  SendImagePreviewScreen({Key? key,this.destination, this.type,this.imageList}):super(key: key);

  @override
  _SendImagePreviewScreenState createState() => _SendImagePreviewScreenState();
}

class _SendImagePreviewScreenState extends State<SendImagePreviewScreen> {
  TextEditingController? _typingController;
  List<TextEditingController?> _textEditingControllerList = [];
  final CarouselController _carouselController = new CarouselController();

  int idxBottom = 0;
  File? _uploadedFile;
  final picker = ImagePicker();
  late List<File>_attachedfiles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      // resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        titleSpacing: 0,
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
              Icons.crop_rotate_rounded,
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
      body: Container(
          child: Stack(
            children: [
              Builder(
                builder: (context) {
                  final double height = MediaQuery.of(context).size.height;
                  return CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      height: height,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: onPageChanged,
                    ),
                    items: widget.imageList!.map((item) => Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height,
                            child: Image.file(item!),
                          ),
                        ],
                      ),
                    )).toList(),
                  );
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
                                    // _uploadImageFile();
                                    widget.type=='galary'?_uploadImageFile():_uploadCameraImage();
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
                                itemCount: widget.imageList!.length,
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
                                            child: Image.file(
                                              widget.imageList![count]!,
                                              fit: BoxFit.fill,
                                            ),
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
                                                if(widget.imageList!.length==1){
                                                  widget.imageList!.removeAt(count);
                                                  _textEditingControllerList.removeAt(count);
                                                  Navigator.pop(context);
                                                }
                                                count==0? _carouselController.nextPage():_carouselController.previousPage();
                                                widget.imageList!.removeAt(count);
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
                                      controller: _textEditingControllerList[idxBottom],
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
        ),
    );
  }

  Future _uploadCameraImage() async {
    _uploadedFile = null;
    final image = await picker.getImage(source: ImageSource.camera);
    if(image != null){
      _uploadedFile = File(image.path);
      widget.imageList!.add(_uploadedFile);
      _textEditingControllerList.add(new TextEditingController());
      _carouselController.jumpToPage(widget.imageList!.length-1);
      setState(() {idxBottom = widget.imageList!.length-1;});
    }
    else print("couldn't upload file.");

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

      for (var num = 0; num < _attachedfiles.length; ++num) {
        File img = _attachedfiles[num];
        widget.imageList!.add(img);
        _textEditingControllerList.add(new TextEditingController());
      }
      _carouselController.jumpToPage(widget.imageList!.length-1);
      setState(() {idxBottom = widget.imageList!.length-1;});
    }
    else print("couldn't upload file.");
  }

  void onPageChanged(int index, CarouselPageChangedReason reason){
    setState(() {
      idxBottom = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _textEditingControllerList.clear();
    for(var i =0; i<widget.imageList!.length; ++i){
      _typingController = new TextEditingController();
      _textEditingControllerList.add(_typingController);
    }
  }

  @override
  void dispose() {
    super.dispose();
    for(var i =0; i<widget.imageList!.length; ++i){
      _textEditingControllerList[i]!.dispose();
    }
  }
}

