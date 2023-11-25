import 'package:flutter/cupertino.dart';

class AnimatedPageRouteDownSlide extends PageRouteBuilder{
  final Widget? page;
  AnimatedPageRouteDownSlide({this.page}):super(
    transitionDuration: Duration(milliseconds: 500),
    transitionsBuilder: (context,animation,animationTime, child){
      Animation<Offset> offsetAnimation = Tween<Offset>(begin: Offset(0.0,-1.0),end: Offset(0.0,0.0)).animate(animation);
      return SlideTransition(position: offsetAnimation, child: child);
    },
    pageBuilder: (context, animation, animationTime){
      return page!;
    },
  );
}