import 'package:flutter_test/flutter_test.dart';
import 'package:eddamore/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const EdamoreApp());
    expect(find.text('EDAMORE'), findsWidgets);
  });
}
