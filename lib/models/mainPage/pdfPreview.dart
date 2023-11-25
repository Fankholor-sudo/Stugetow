import 'dart:io';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:stugetow/models/mainPage/pdfViewerPage.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteSlide.dart';

// ignore: must_be_immutable
class SelectedPdfPreview extends StatefulWidget {
  final dynamic user;
  List<String>? pdfNames;
  List<PDFDocument>? pdfdocumentList;
  SelectedPdfPreview({Key? key, this.pdfNames, this.pdfdocumentList, this.user}) : super(key: key);

  @override
  _SelectedPdfPreviewState createState() => _SelectedPdfPreviewState();
}

class _SelectedPdfPreviewState extends State<SelectedPdfPreview> {
  List<File> _pdfdocfiles = [];
  ScrollController? _scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey[800],
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        elevation: 1,
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
                      backgroundImage: NetworkImage(widget.user.profileImg),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    width: MediaQuery.of(context).size.width * .4,
                    child: Text(
                      widget.user.name,
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
        actions: [
          IconButton(
            icon: Icon(Icons.send, color: Colors.grey[300]),
            iconSize: 25.0,
            onPressed: () {Navigator.pop(context);},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _uploadPdfFile().then((value) => loading()).then(
                (value) => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=> SelectedPdfPreview(
                    pdfNames: widget.pdfNames,
                    pdfdocumentList: widget.pdfdocumentList,
                    user: widget.user,
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        color: Color.fromRGBO(161, 202, 241, .15),
        child: ListView(
          controller: _scrollController,
          children: [
            SizedBox(height:15),
            for (var pdfNum = 0; pdfNum < widget.pdfdocumentList!.length; pdfNum++)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .07,
                    width: MediaQuery.of(context).size.width * .95,
                    margin: EdgeInsets.only(left: 10, top: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(
                          width: 1.0, color: Color.fromRGBO(0, 0, 0, .4)),
                    ),
                    child: Material(
                      child: InkWell(
                        splashColor: Colors.blueGrey[500],
                        onTap: () {
                          Navigator.push(
                            context,
                            AnimatedPageRouteSlide(
                              page: PdfViewerPage(
                                document: widget.pdfdocumentList![pdfNum],
                                name: widget.pdfNames![pdfNum],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.insert_drive_file,
                                    color: Color.fromRGBO(150, 10, 20, 1),
                                    size: 30,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .55,
                                    child: Text(
                                      '${widget.pdfNames![pdfNum]}',
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 20),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                padding: EdgeInsets.all(2.0),
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.white,
                                    child: InkWell(
                                      splashColor: Colors.blueGrey[300],
                                      onTap: () {
                                        setState(() {
                                          widget.pdfdocumentList!.removeAt(pdfNum);
                                          widget.pdfNames!.removeAt(pdfNum);
                                        });
                                        if(widget.pdfNames!.isEmpty)Navigator.pop(context);
                                      },
                                      child: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.blueAccent,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget loading(){
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }
  Future _uploadPdfFile() async {
    _pdfdocfiles.clear();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf','zip','txt','rar','ppt','doc'],
    );
    if (result != null) {
      _pdfdocfiles = result.paths.map((path) => File(path!)).toList();

      for (var num = 0; num < _pdfdocfiles.length; ++num) {
        PDFDocument doc = await PDFDocument.fromFile(_pdfdocfiles[num]);
        widget.pdfNames!.add(basename(_pdfdocfiles[num].path));
        widget.pdfdocumentList!.add(doc);
      }
      print('length: ${widget.pdfdocumentList!.length}');
    }
    else print('not uploaded');
  }

  @override
  void initState(){
    super.initState();
    _scrollController = new ScrollController();
  }
}
