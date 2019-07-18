import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:io';

Future<File> takeScreenshot(FlutterDriver driver, String path) async {
  final List<int> pixels = await driver.screenshot();
  final File file = new File(path);
  return await file.writeAsBytes(pixels);
}

Future<File> recordRenderTree(FlutterDriver driver, String path) async {
  RenderTree renderTree = await driver.getRenderTree();
  File file = new File(path);
  return await file.writeAsString(renderTree.tree);
}

void main() {
  group('Default test', () {

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('check flutter driver health', () async {
      Health health = await driver.checkHealth();
      expect(health.status, HealthStatus.ok);
    });

    test('Flutter drive push route', () async {

      await takeScreenshot(driver, './screenshots/page-frame-start.png');
      await recordRenderTree(driver, './render_tree/render-tree-frame-start');

      // performance最好是在真机下测，否则没什么意义...
      final timeline = await driver.traceAction(() async {

        await driver.tap(find.byValueKey('homePush'));
        await driver.waitFor(find.byValueKey('otherPush'));

      });

      await takeScreenshot(driver, './screenshots/page-frame-end.png');
      await recordRenderTree(driver, './render_tree/render-tree-frame-end');

      final summary = new TimelineSummary.summarize(timeline);

      summary.writeSummaryToFile('route_summary', pretty: true, destinationDirectory: './timeline/');
      summary.writeTimelineToFile('route_timeline', pretty: true, destinationDirectory: './timeline/');

      print('Success!');
    });
  });
}