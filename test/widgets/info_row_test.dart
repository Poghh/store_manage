import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:store_manage/feature/product/presentation/widgets/info_row.dart';

void main() {
  testWidgets('InfoRow renders label and value', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: InfoRow(label: 'Code', value: 'SP-001'),
        ),
      ),
    );

    expect(find.text('Code'), findsOneWidget);
    expect(find.text('SP-001'), findsOneWidget);
  });
}
