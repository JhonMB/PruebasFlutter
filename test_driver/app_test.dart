// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Scrollable App', () {
    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('verifies the list contains a specific item', () async {
      // Create two SerializableFinders and use these to locate specific
      // widgets displayed by the app. The names provided to the byValueKey
      // method correspond to the Keys provided to the widgets in step 1.
      final listFinder = find.byValueKey('long_list');
      final itemFinder = find.byValueKey('item_100_text');
      ;

      final timeline = await driver.traceAction(() async {
        await driver.scrollUntilVisible(
          listFinder,
          itemFinder,
          dyScroll: -500.0,
        );
        expect(await driver.getText(itemFinder), 'Item 100');
      });
      final summary = new TimelineSummary.summarize(timeline);
      await summary.writeSummaryToFile('scrolling_summary', pretty: true);
      await summary.writeTimelineToFile('scrolling_timeline', pretty: true);
      /* await driver.scrollUntilVisible(
        listFinder,
        itemFinder,
        dyScroll: -300.0,
      ); */

      // Verify that the item contains the correct text.
      /* expect(
        await driver.getText(itemFinder),
        'Item 1000',
      ); */
    });
  });
}
