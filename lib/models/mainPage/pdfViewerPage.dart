import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class PdfViewerPage extends StatefulWidget {
  final PDFDocument document;
  final String? name;
  PdfViewerPage({Key? key, required this.document, this.name}) : super(key: key);

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: Container(
          width: MediaQuery.of(context).size.width*.7,
            child: Text('${widget.name}'),
        ),
      ),
      body: Center(
        child: PDFViewer(
          document: widget.document,
          zoomSteps: 1,
          //uncomment below line to preload all pages
          lazyLoad: false,
          // uncomment below line to scroll vertically
          scrollDirection: Axis.horizontal,

          //uncomment below code to replace bottom navigation with your own
          navigationBuilder: (context, page, totalPages, jumpToPage, animateToPage) {
            return ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.first_page),
                  onPressed: () {
                    jumpToPage(page: 0);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    animateToPage(page: page! - 2);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    animateToPage(page: page);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.last_page),
                  onPressed: () {
                    jumpToPage(page: totalPages! - 1);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
