import 'package:buddy/features/dog/presentation/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SearchWidget displays search icon and text field',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: SearchWidget(
      onSearch: () {},
    )));

    // Verify that the text field is displayed
    expect(find.byType(Text), findsOneWidget);
  });

  testWidgets('SearchWidget open textField by clicking',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SearchWidget(
        onSearch: () {},
      ),
    ));
    await tester.tap(find.byType(Text));
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('SearchWidget calls callback function on submit',
      (WidgetTester tester) async {
    bool submitted = false;

    await tester.pumpWidget(MaterialApp(
      home: SearchWidget(
        onSearch: (value) {
          submitted = true;
        },
      ),
    ));
    await tester.tap(find.byType(Text));
    await tester.pumpAndSettle();

    // Enter text in the text field
    await tester.enterText(find.byType(TextField), 'e');

    // Verify that the callback function is called
    expect(submitted, true);
  });
}
