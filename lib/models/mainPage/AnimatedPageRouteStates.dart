import 'package:flutter/cupertino.dart';

class AnimatedPageRouteStates extends PageRouteBuilder{
  final Widget? page;
  AnimatedPageRouteStates({this.page}):super(
    transitionDuration: Duration(milliseconds: 200),
    transitionsBuilder: (context,animation,animationTime, child){
      animation = CurvedAnimation(parent: animation, curve: Curves.linear);
      return ScaleTransition(
        alignment: Alignment.topCenter,
        scale: animation,
        child: child,
      );
    },
    pageBuilder: (context, animation, animationTime){
      return page!;
    },
  );
}