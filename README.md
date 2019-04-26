# flutter_page_transition

A new Flutter Page Transition package.

[![Version](https://img.shields.io/badge/version-0.0.2-blue.svg)](https://github.com/handoing/flutter_page_transition)

![](./screenshots/fadeIn.gif)
![](./screenshots/slideInLeft.gif)
![](./screenshots/slideLeft.gif)
![](./screenshots/slideParallaxLeft.gif)
![](./screenshots/slideZoomLeft.gif)
![](./screenshots/transferRight.gif)

## Getting Started

添加git仓库依赖:
```yaml
flutter_page_transition:
  git:
    url: git://github.com/handoing/flutter_page_transition.git
```

## Example

使用PageRouteBuilder
```dart
onGenerateRoute: (RouteSettings routeSettings){
    return new PageRouteBuilder<dynamic>(
      settings: routeSettings,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        switch (routeSettings.name){
          case '/':
            return HomePage();
          case '/first':
            return FirstPage();
          case '/second':
            return SecondPage();
          default:
            return null;
        }
      },
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
          return effectMap[PageTransitionType.slideInLeft](Curves.linear, animation, secondaryAnimation, child);
      }
    );
}

Navigator.of(context).pushNamed('/first');

or

Navigator.of(context).push(PageTransition(type: PageTransitionType.slideInLeft, child: FirstPage()));


```

使用自定义效果
```dart
transitionEffect.createCustomEffect(
  handle: (Curve curve, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(CurvedAnimation(parent: animation, curve: curve)),
      child: child,
    );
  }
);

...

effectMap[PageTransitionType.custom](Curves.linear, animation, secondaryAnimation, child);
```
