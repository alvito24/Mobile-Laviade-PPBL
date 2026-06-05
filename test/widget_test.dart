import 'package:flutter_test/flutter_test.dart';

import 'package:laviade_mobile/app.dart';

void main() {
  testWidgets('Laviade app shows splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const LaviadeApp());

    expect(find.text('Laviade\nStudio'), findsOneWidget);
    expect(find.text('Local Catalog & Cart'), findsOneWidget);
  });
}
