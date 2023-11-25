import 'package:flutter/cupertino.dart';

class AnimatedPageRouteSlide extends PageRouteBuilder{
  final Widget? page;
  AnimatedPageRouteSlide({this.page}):super(
    transitionDuration: Duration(milliseconds: 400),
    transitionsBuilder: (context,animation,animationTime, child){
      Animation<Offset> offsetAnimation = Tween<Offset>(begin: Offset(1.0, 0.0),end: Offset(0.0,0.0)).animate(animation);
      return SlideTransition(position: offsetAnimation, child: child);
    },
    pageBuilder: (context, animation, animationTime){
      return page!;
    },
  );
}