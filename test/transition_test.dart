import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';

void main() {

  testWidgets('Create route and push other page', (WidgetTester tester) async {

    await tester.pumpWidget(MyApp());

    expect(find.text('Home'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));

    await tester.pumpAndSettle();

    expect(find.text('Other'), findsOneWidget);

  });
}

class HomePage extends StatelessWidget {
  static const String tag = 'home-page';

  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Title'),
      ),
      body: Center(
        child: Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('other-page');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class OtherPage extends StatelessWidget {
  static const String tag = 'other-page';

  OtherPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Title'),
      ),
      body: Center(
        child: Text('Other'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('home-page');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

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
