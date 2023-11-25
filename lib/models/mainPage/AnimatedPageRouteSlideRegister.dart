import 'package:flutter/cupertino.dart';

class AnimatedPageRouteSlideRegister extends PageRouteBuilder{
  final Widget? page;
  AnimatedPageRouteSlideRegister({this.page}):super(
    transitionDuration: Duration(milliseconds: 700),
    transitionsBuilder: (context,animation,animationTime, child){
      Animation<Offset> offsetAnimation = Tween<Offset>(begin: Offset(1.0, 0.0),end: Offset(0.0,0.0)).animate(animation);
      return SlideTransition(position: offsetAnimation, child: child);
    },
    pageBuilder: (context, animation, animationTime){
      return page!;
    },
  );
}