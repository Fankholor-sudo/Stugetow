import 'package:flutter/material.dart';
import 'package:stugetow/views/separateClasses/Chats/Users.dart';

class ViewPhotoChat extends StatefulWidget {
  final User? destination;
  ViewPhotoChat({this.destination});

  @override
  _ViewPhotoChat createState() => _ViewPhotoChat();
}

class _ViewPhotoChat extends State<ViewPhotoChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.blueGrey[700],
        leading: IconButton(icon:
        Icon(Icons.arrow_back),
          color: Colors.white,
          iconSize: 25.0,
          onPressed: () => Navigator.pop(context),
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
