import 'package:daily_activity_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows daily activity dashboard content', (tester) async {
    await tester.pumpWidget(const DailyActivityApp());

    expect(find.text('Daily Activity'), findsOneWidget);
    expect(find.text('Choose a day'), findsOneWidget);
    expect(find.text('Activity breakdown'), findsOneWidget);
    expect(find.text('Today · Mar 23'), findsOneWidget);
    expect(find.text('Screen time'), findsOneWidget);
  });
}
