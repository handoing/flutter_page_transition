library flutter_page_transition;

import 'package:flutter/material.dart';
import 'package:flutter_page_transition/page_transition_type.dart';
import 'package:flutter_page_transition/transition_effect.dart';
import 'package:flutter_page_transition/transition_tween.dart';

export 'package:flutter_page_transition/page_transition_type.dart';

TransitionEffect transitionEffect = TransitionEffect();

final Map effectMap = <PageTransitionType, void>{
  PageTransitionType.custom: transitionEffect.customEffect,

  PageTransitionType.fadeIn: TransitionEffect.createFadeIn(),

  PageTransitionType.transferRight: TransitionEffect.createTransfer(animationTween: t1 as Tween<Offset>, secondaryAnimationTween: t5 as Tween<Offset>, animationScaleTween: t14 as Tween<double>, secondaryAnimationScaleTween: t13 as Tween<double>),
  PageTransitionType.transferUp: TransitionEffect.createTransfer(animationTween: t3 as Tween<Offset>, secondaryAnimationTween: t7 as Tween<Offset>, animationScaleTween: t14 as Tween<double>, secondaryAnimationScaleTween: t13 as Tween<double>),

  PageTransitionType.slideInLeft: TransitionEffect.createSlideIn(t1 as Tween<Offset>),
  PageTransitionType.slideInRight: TransitionEffect.createSlideIn(t2 as Tween<Offset>),
  PageTransitionType.slideInUp: TransitionEffect.createSlideIn(t3 as Tween<Offset>),
  PageTransitionType.slideInDown: TransitionEffect.createSlideIn(t4 as Tween<Offset>),

  PageTransitionType.slideLeft: TransitionEffect.createSlide(animationTween: t1 as Tween<Offset>, secondaryAnimationTween: t5 as Tween<Offset>),
  PageTransitionType.slideRight: TransitionEffect.createSlide(animationTween: t2 as Tween<Offset>, secondaryAnimationTween: t6 as Tween<Offset>),
  PageTransitionType.slideUp: TransitionEffect.createSlide(animationTween: t3 as Tween<Offset>, secondaryAnimationTween: t7 as Tween<Offset>),
  PageTransitionType.slideDown: TransitionEffect.createSlide(animationTween: t4 as Tween<Offset>, secondaryAnimationTween: t8 as Tween<Offset>),

  PageTransitionType.slideParallaxLeft: TransitionEffect.createSlide(animationTween: t1 as Tween<Offset>, secondaryAnimationTween: t9 as Tween<Offset>),
  PageTransitionType.slideParallaxRight: TransitionEffect.createSlide(animationTween: t2 as Tween<Offset>, secondaryAnimationTween: t10 as Tween<Offset>),
  PageTransitionType.slideParallaxUp: TransitionEffect.createSlide(animationTween: t3 as Tween<Offset>, secondaryAnimationTween: t11 as Tween<Offset>),
  PageTransitionType.slideParallaxDown: TransitionEffect.createSlide(animationTween: t4 as Tween<Offset>, secondaryAnimationTween: t12 as Tween<Offset>),

  PageTransitionType.slideZoomLeft: TransitionEffect.createZoomSlide(positionAnimationTween: t1 as Tween<Offset>, scaleAnimationTween: t13 as Tween<double>),
  PageTransitionType.slideZoomRight: TransitionEffect.createZoomSlide(positionAnimationTween: t2 as Tween<Offset>, scaleAnimationTween: t13 as Tween<double>),
  PageTransitionType.slideZoomUp: TransitionEffect.createZoomSlide(positionAnimationTween: t3 as Tween<Offset>, scaleAnimationTween: t13 as Tween<double>),
  PageTransitionType.slideZoomDown: TransitionEffect.createZoomSlide(positionAnimationTween: t4 as Tween<Offset>, scaleAnimationTween: t13 as Tween<double>),

  PageTransitionType.rippleRightUp: TransitionEffect.createRipple(origin: 'Right'),
  PageTransitionType.rippleLeftUp: TransitionEffect.createRipple(origin: 'Left'),
  PageTransitionType.rippleLeftDown: TransitionEffect.createRipple(origin: 'LeftDown'),
  PageTransitionType.rippleRightDown: TransitionEffect.createRipple(origin: 'RightDown'),
  PageTransitionType.rippleMiddle: TransitionEffect.createRipple(origin: 'Middle'),
};

class PageTransition extends PageRouteBuilder {
  final Widget child;
  final PageTransitionType type;
  final Curve curve;
  final Alignment? alignment;
  final Duration duration;

  PageTransition({
    Key? key,
    required this.child,
    required this.type,
    this.curve = Curves.linear,
    this.alignment,
    this.duration = const Duration(milliseconds: 200),
  }) : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return child;
          },
          transitionDuration: duration,
          transitionsBuilder:
              (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
                  effectMap[type](curve, animation, secondaryAnimation, child),
        );
}
