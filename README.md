# flutter_page_transition

A rich flutter page transition package.

[![Version](https://img.shields.io/badge/version-0.1.1-blue.svg)](https://github.com/handoing/flutter_page_transition)

## Some Demos

![](./screenshots/fadeIn.gif)
![](./screenshots/slideInLeft.gif)
![](./screenshots/slideLeft.gif)
![](./screenshots/slideParallaxLeft.gif)
![](./screenshots/slideZoomLeft.gif)
![](./screenshots/transferRight.gif)
![](./screenshots/rippleRightUp.gif)

## Getting Started

You can depend on this package stored in my repository:
```yaml
flutter_page_transition:
  git:
    url: git://github.com/handoing/flutter_page_transition.git
```
You should then run `flutter packages upgrade`.

## Transition Type

| Page Transition Type  | Direction |
| :- | :-|
| slideInLeft | ⬅️  |
| slideInLeft | ➡️  |
| slideInUp | ⬆️  |
| slideInDown | ⬇️  |
| slideLeft | ⬅️  |
| slideRight | ➡️  |
| slideUp | ⬆️  |
| slideDown | ⬇️  |
| slideParallaxLeft | ⬅️  |
| slideParallaxRight | ➡️  |
| slideParallaxUp | ⬆️  |
| slideParallaxDown | ⬇️  |
| slideZoomLeft | ⬅️  |
| slideZoomRight | ➡️  |
| slideZoomUp | ⬆️  |
| slideZoomDown | ⬇️  |
| rippleRightUp | ↖️ |
| rippleLeftUp | ↗️  |
| transferRight | ⬅️  |
| transferUp | ⬆️  |
| fadeIn | ❌  |
| custom | ❌  |

## Example

Use PageRouteBuilder Widget
```dart
initialRoute: 'Home',
onGenerateRoute: (RouteSettings routeSettings){
    return new PageRouteBuilder<dynamic>(
      settings: routeSettings,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        switch (routeSettings.name){
          case 'Home':
            return HomePage();
          case 'Other':
            return OtherPage();
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

// use Navigator
Navigator.of(context).pushNamed('Other');
// or
Navigator.of(context).push(PageTransition(type: PageTransitionType.slideInLeft, child: FirstPage()));


```

Create custom methods:
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

// use custom
effectMap[PageTransitionType.custom](Curves.linear, animation, secondaryAnimation, child);
```

## Test

run test
```bash
flutter test
```

## Test Driver

run driver test
```bash
ce example/
flutter drive --target=test_driver/app.dart
```

## License

[MIT](LICENSE)
