import 'package:flutter/material.dart';
import 'package:stugetow/views/separateClasses/Company/UserCompany.dart';

class ViewPhotoCompanyServer extends StatefulWidget {
  final dynamic destination;

  ViewPhotoCompanyServer({this.destination});

  @override
  _ViewPhotoCompanyServer createState() => _ViewPhotoCompanyServer();
}

class _ViewPhotoCompanyServer extends State<ViewPhotoCompanyServer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.blueGrey[700],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          iconSize: 25.0,
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Text(
                widget.destination.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.destination.profileImg),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
