import 'package:flutter_test/flutter_test.dart';
import 'package:personal_finance_companion_mobile_app/app.dart';

void main() {
  testWidgets('App builds successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const PersonalFinanceApp());
    expect(find.text('Personal Finance App'), findsOneWidget);
  });
}
