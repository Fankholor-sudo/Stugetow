import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stugetow/views/separateClasses/Company/UserCompany.dart';
import 'dart:ui' as ui;

class StatePostedDestinationScreen extends StatefulWidget {
  final UserCompany? destination;
  StatePostedDestinationScreen({this.destination});

  @override
  _StatePostedDestinationScreenState createState() => _StatePostedDestinationScreenState();
}

class _StatePostedDestinationScreenState extends State<StatePostedDestinationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(color: Colors.black),
                  child: Hero(
                    tag: widget.destination!.imageUrl,
                    child: ClipRRect(
                      child: Image(
                        image: AssetImage(widget.destination!.imageUrl),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                      iconSize: 30.0,
                      onPressed: () => Navigator.pop(context),
                    ),
                    IconButton(
                      icon: Icon(Icons.more_horiz),
                      color: Colors.white,
                      iconSize: 30.0,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 12.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        child: Icon(Icons.favorite_border),
                        shaderCallback: (Rect bounds) {
                          return ui.Gradient.linear(
                            Offset(4.0, 24.0),
                            Offset(24.0, 4.0),
                            [Colors.red, Colors.deepOrangeAccent],
                          );
                        },
                      ),
                      iconSize: 22.0,
                      onPressed: () {},
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
                              Color.fromRGBO(9, 86, 164, 1)
                            ],
                          );
                        },
                      ),
                      iconSize: 22.0,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          child: Icon(Icons.share),
                          shaderCallback: (Rect bounds) {
                            return ui.Gradient.linear(
                              Offset(4.0, 24),
                              Offset(24.0, 4.0),
                              [Color.fromRGBO(9, 86, 164, 1), Colors.black54],
                            );
                          }),
                      iconSize: 22.0,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
