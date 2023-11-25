import 'package:flutter/material.dart';
import 'package:stugetow/views/separateClasses/Institution/UserInstitution.dart';

class ViewPhotoInstitution extends StatefulWidget {
  final UserInstitution? destination;
  ViewPhotoInstitution({this.destination});

  @override
  _ViewPhotoInstitution createState() => _ViewPhotoInstitution();
}

class _ViewPhotoInstitution extends State<ViewPhotoInstitution> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        titleSpacing: 0,
        brightness: Brightness.dark,
        backgroundColor: Colors.blueGrey[700],
        leading: IconButton(icon:
        Icon(Icons.arrow_back),
          color: Colors.white,
          iconSize: 25.0,
          onPressed: () => Navigator.pop(context,),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width*.75,
              child: Text(
                widget.destination!.name,
                style: TextStyle(
                  color:Colors.white,
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
          child: Hero(
            tag: widget.destination!.imageUrl,
            child: Container(
              width: double.infinity,
              child: Image.asset(widget.destination!.imageUrl),
            ),
          ),
        ),
      ),
    );
  }
}
