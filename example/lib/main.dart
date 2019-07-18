import 'package:flutter/material.dart';

import 'package:flutter_page_transition/flutter_page_transition.dart';
import './page/home_page.dart';
import './page/other_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Page Transition Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomePage.tag,
        onGenerateRoute: (RouteSettings routeSettings){
          return new PageRouteBuilder<dynamic>(
              settings: routeSettings,
              pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                switch (routeSettings.name){
                  case HomePage.tag:
                    return HomePage();
                  case OtherPage.tag:
                    return OtherPage();
                  default:
                    return null;
                }
              },
              transitionDuration: const Duration(milliseconds: 600),
              transitionsBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation, Widget child) {
                return effectMap[PageTransitionType.slideInLeft](Curves.linear, animation, secondaryAnimation, child);
              }
          );
        }
    );
  }
}
