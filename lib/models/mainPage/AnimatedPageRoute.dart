import 'package:flutter/cupertino.dart';

class AnimatedPageRoute extends PageRouteBuilder{
  final Widget? page;
  AnimatedPageRoute({this.page}):super(
    transitionDuration: Duration(milliseconds: 250),
    transitionsBuilder: (context,animation,animationTime, child){
      animation = CurvedAnimation(parent: animation, curve: Curves.easeIn,reverseCurve: Curves.linearToEaseOut);
      return ScaleTransition(
        alignment: Alignment.center,
        scale: animation,
        child: child,
      );
    },
    pageBuilder: (context, animation, animationTime){
      return page!;
    },
  );
}