library flutter_page_transition;

import 'package:flutter/material.dart';
import 'package:flutter_page_transition/page_transition_type.dart';
import 'package:flutter_page_transition/transition_tween.dart';
import 'package:flutter_page_transition/transition_effect.dart';

export 'package:flutter_page_transition/page_transition_type.dart';

TransitionEffect transitionEffect = TransitionEffect();

final Map effectMap = <PageTransitionType, void>{
  PageTransitionType.custom: transitionEffect.customEffect,

  PageTransitionType.fadeIn: TransitionEffect.createFadeIn(),

  PageTransitionType.transferRight: TransitionEffect.createTransfer(animationTween: t1, secondaryAnimationTween: t5, animationScaleTween: t14, secondaryAnimationScaleTween: t13),
  PageTransitionType.transferUp: TransitionEffect.createTransfer(animationTween: t3, secondaryAnimationTween: t7, animationScaleTween: t14, secondaryAnimationScaleTween: t13),

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

  PageTransitionType.rippleRightUp: TransitionEffect.createRipple(origin: 'Right'),
  PageTransitionType.rippleLeftUp: TransitionEffect.createRipple(origin: 'Left'),
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

        return effectMap[type](curve, animation, secondaryAnimation, child);
      });
}
