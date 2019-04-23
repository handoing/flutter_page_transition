library flutter_page_transition;

import 'package:flutter/material.dart';

enum PageTransitionType {

  slideInLeft, // 从左向右
  slideInRight, // 从右向左
  slideInUp, // 从下向上
  slideInDown, // 从上向下

  slideLeft, // 从左向右
  slideRight, // 从右向左
  slideUp, // 从下向上
  slideDown, // 从上向下

}

class SlideTransitionEffect {
  static createSlideIn(Tween tween) {
    return (Curve curve, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) => new SlideTransition(
      position: tween.animate(CurvedAnimation(parent: animation, curve: curve)),
      child: child,
    );
  }
  static createSlide({Tween animationTween, Tween secondaryAnimationTween}) {
    return (Curve curve, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) => new SlideTransition(
      position: animationTween.animate(animation),
      child: new SlideTransition(
        position: secondaryAnimationTween.animate(secondaryAnimation),
        child: child,
      ),
    );
  }
}

Tween t1 = new Tween<Offset>(
  begin: const Offset(1.0, 0.0),
  end: const Offset(0.0, 0.0),
);
Tween t2 = new Tween<Offset>(
  begin: const Offset(-1.0, 0.0),
  end: const Offset(0.0, 0.0),
);
Tween t3 = new Tween<Offset>(
  begin: const Offset(0.0, 1.0),
  end: const Offset(0.0, 0.0),
);
Tween t4 = new Tween<Offset>(
  begin: const Offset(0.0, -1.0),
  end: const Offset(0.0, 0.0),
);
Tween t5 = new Tween<Offset>(
  begin: const Offset(0.0, 0.0),
  end: const Offset(-1.0, 0.0),
);
Tween t6 = new Tween<Offset>(
  begin: const Offset(0.0, 0.0),
  end: const Offset(1.0, 0.0),
);
Tween t7 = new Tween<Offset>(
  begin: const Offset(0.0, 0.0),
  end: const Offset(0.0, -1.0),
);
Tween t8 = new Tween<Offset>(
  begin: const Offset(0.0, 0.0),
  end: const Offset(0.0, 1.0),
);

Map effectMap = <PageTransitionType, void>{
  PageTransitionType.slideInLeft: SlideTransitionEffect.createSlideIn(t1),
  PageTransitionType.slideInRight: SlideTransitionEffect.createSlideIn(t2),
  PageTransitionType.slideInUp: SlideTransitionEffect.createSlideIn(t3),
  PageTransitionType.slideInDown: SlideTransitionEffect.createSlideIn(t4),
  PageTransitionType.slideLeft: SlideTransitionEffect.createSlide(animationTween: t1, secondaryAnimationTween: t5),
  PageTransitionType.slideRight: SlideTransitionEffect.createSlide(animationTween: t2, secondaryAnimationTween: t6),
  PageTransitionType.slideUp: SlideTransitionEffect.createSlide(animationTween: t3, secondaryAnimationTween: t7),
  PageTransitionType.slideDown: SlideTransitionEffect.createSlide(animationTween: t4, secondaryAnimationTween: t8),
};

class PageTransition extends PageRouteBuilder {
  final Widget child;
  final PageTransitionType type;
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

        if (effectMap[type] == null) {
          return FadeTransition(opacity: animation, child: child);
        }
        return effectMap[type](curve, animation, secondaryAnimation, child);
      });
}
