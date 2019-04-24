library flutter_page_transition;

import 'package:flutter/material.dart';

enum PageTransitionType {

  custom, // 自定义过渡效果

  slideInLeft, // 从左向右
  slideInRight, // 从右向左
  slideInUp, // 从下向上
  slideInDown, // 从上向下

  slideLeft, // 从左向右
  slideRight, // 从右向左
  slideUp, // 从下向上
  slideDown, // 从上向下

  slideParallaxLeft, // 从左向右
  slideParallaxRight, // 从右向左
  slideParallaxUp, // 从下向上
  slideParallaxDown, // 从上向下

  slideZoomLeft, // 从左向右
  slideZoomRight, // 从右向左
  slideZoomUp, // 从下向上
  slideZoomDown, // 从上向下

}

class TransitionEffect {
  Function _customEffect;

  TransitionEffect() {
    _customEffect = (Curve curve, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      return child;
    };
  }

  get customEffect => _customEffect;

  createCustomEffect({Function handle}) {
    _customEffect = handle;
  }

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
  static createZoomSlide({Tween animationTween, Tween secondaryAnimationTween}) {
    return (Curve curve, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) => new SlideTransition(
      position: animationTween.animate(animation),
      child: new ScaleTransition(
        scale: secondaryAnimationTween.animate(secondaryAnimation),
        child: child,
      ),
    );
  }
}

TransitionEffect transitionEffect = TransitionEffect();

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

Tween t9 = new Tween<Offset>(
  begin: const Offset(0.0, 0.0),
  end: const Offset(-0.8, 0.0),
);
Tween t10 = new Tween<Offset>(
  begin: const Offset(0.0, 0.0),
  end: const Offset(0.8, 0.0),
);
Tween t11 = new Tween<Offset>(
  begin: const Offset(0.0, 0.0),
  end: const Offset(0.0, -0.8),
);
Tween t12 = new Tween<Offset>(
  begin: const Offset(0.0, 0.0),
  end: const Offset(0.0, 0.8),
);

Tween t13 = new Tween<double>(
  begin: 1.0,
  end: 0.9,
);

final Map effectMap = <PageTransitionType, void>{
  PageTransitionType.custom: transitionEffect.customEffect,

  PageTransitionType.slideInLeft: TransitionEffect.createSlideIn(t1),
  PageTransitionType.slideInRight: TransitionEffect.createSlideIn(t2),
  PageTransitionType.slideInUp: TransitionEffect.createSlideIn(t3),
  PageTransitionType.slideInDown: TransitionEffect.createSlideIn(t4),

  PageTransitionType.slideLeft: TransitionEffect.createSlide(animationTween: t1, secondaryAnimationTween: t5),
  PageTransitionType.slideRight: TransitionEffect.createSlide(animationTween: t2, secondaryAnimationTween: t6),
  PageTransitionType.slideUp: TransitionEffect.createSlide(animationTween: t3, secondaryAnimationTween: t7),
  PageTransitionType.slideDown: TransitionEffect.createSlide(animationTween: t4, secondaryAnimationTween: t8),

  PageTransitionType.slideParallaxLeft: TransitionEffect.createSlide(animationTween: t1, secondaryAnimationTween: t9),
  PageTransitionType.slideParallaxRight: TransitionEffect.createSlide(animationTween: t2, secondaryAnimationTween: t10),
  PageTransitionType.slideParallaxUp: TransitionEffect.createSlide(animationTween: t3, secondaryAnimationTween: t11),
  PageTransitionType.slideParallaxDown: TransitionEffect.createSlide(animationTween: t4, secondaryAnimationTween: t12),

  PageTransitionType.slideZoomLeft: TransitionEffect.createZoomSlide(animationTween: t1, secondaryAnimationTween: t13),
  PageTransitionType.slideZoomRight: TransitionEffect.createZoomSlide(animationTween: t2, secondaryAnimationTween: t13),
  PageTransitionType.slideZoomUp: TransitionEffect.createZoomSlide(animationTween: t3, secondaryAnimationTween: t13),
  PageTransitionType.slideZoomDown: TransitionEffect.createZoomSlide(animationTween: t4, secondaryAnimationTween: t13),
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
