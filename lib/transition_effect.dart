import 'package:flutter/material.dart';
import 'dart:math';

class RippleClipper extends CustomClipper<Path> {
  RippleClipper({this.origin, this.progress});
  final String origin;
  final double progress;

  @override
  Path getClip(Size size) {
    Map center = <String, Offset>{
      'Left': Offset(0, size.height),
      'Right': Offset(size.width, size.height),
      'LeftDown': Offset(0, 0),
      'RightDown': Offset(size.width, 0),
      'Middle': Offset(size.width * .5, size.height * .5),
    };
    Path path = Path();
    double radius = sqrt(pow(size.width, 2) + pow(size.height, 2));
    path.addOval(new Rect.fromCircle(center: center[origin], radius: radius * progress));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
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

  static createFadeIn() {
    return (Curve curve, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) => new FadeTransition(opacity: animation, child: child);
  }

  static createTransfer({Tween animationTween, Tween secondaryAnimationTween, Tween animationScaleTween, Tween secondaryAnimationScaleTween}) {
    return (Curve curve, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      // 进入动效
      Widget secondaryPage = new SlideTransition(
        position: secondaryAnimationTween.animate(CurvedAnimation(parent: secondaryAnimation, curve: Interval(0.3, 0.7, curve: curve))),
        child: new ScaleTransition(
          scale: secondaryAnimationScaleTween.animate(CurvedAnimation(parent: secondaryAnimation, curve: Interval(0.0, 0.3, curve: curve))),
          child: new ScaleTransition(
            scale: secondaryAnimationScaleTween.animate(CurvedAnimation(parent: secondaryAnimation, curve: Interval(0.7, 1.0, curve: curve))),
            child: child,
          ),
        ),
      );

      // 离开动效
      return new SlideTransition(
        position: animationTween.animate(CurvedAnimation(parent: animation, curve: Interval(0.3, 0.7, curve: curve))),
        child: new ScaleTransition(
          scale: animationScaleTween.animate(CurvedAnimation(parent: animation, curve: Interval(0.0, 0.3, curve: curve))),
          child: new ScaleTransition(
            scale: animationScaleTween.animate(CurvedAnimation(parent: animation, curve: Interval(0.7, 1.0, curve: curve))),
            child: secondaryPage,
          ),
        ),
      );
    };
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

  static createRipple({String origin}) {
    return (Curve curve, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) => new ClipPath(
      clipper: RippleClipper(origin: origin, progress: animation.value),
      child: child,
    );
  }

}