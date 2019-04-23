library flutter_page_transition;

import 'package:flutter/material.dart';

enum PageSlideInType {
  slideInLeft, // 从左向右
  slideInRight, // 从右向左
  slideInUp, // 从下向上
  slideInDown, // 从上向下
}

enum PageTransitionType {
  slideInLeft, // 从左向右
  slideInRight, // 从右向左
  slideInUp, // 从下向上
  slideInDown, // 从上向下
}

class SlideTransitionEffect {
  static SlideTransition createSlideInLeft(Animation<double> animation, Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }
  static SlideTransition createSlideInRight(Animation<double> animation, Widget child) {
//    return new SlideTransition(
//      position: new Tween<Offset>(
//        begin: const Offset(-1.0, 0.0),
//        end: const Offset(0.0, 0.0),
//      ).animate(animation),
//      child: child,
//    );
  }
}

Map effectMap = {
  PageTransitionType.slideInLeft: SlideTransitionEffect.createSlideInLeft,
  PageTransitionType.slideInRight: SlideTransitionEffect.createSlideInRight
};

class PageTransition extends PageRouteBuilder {
  final Widget child;
  final PageSlideInType type;
  final Curve curve;
  final Alignment alignment;
  final Duration duration;

  PageTransition({
    Key key,
    @required this.child,
    @required this.type,
    this.curve = Curves.linear,
    this.alignment,
    this.duration = const Duration(milliseconds: 200),
  }) : super(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return child;
      },
      transitionDuration: duration,
      transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child
      ) {
        return effectMap[type](animation, child);
//        switch (type) {
//          case PageTransitionType.slideInRight:
//            return Transition.createTransition(animation, child);
//            break;
//          default:
//            return FadeTransition(opacity: animation, child: child);
//        }
      });
}
