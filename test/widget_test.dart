import 'package:flutter_test/flutter_test.dart';

import 'package:engmohamedkhedrcv/cv_pdf/cv_ats_pdf.dart';
import 'package:engmohamedkhedrcv/data/cv_data.dart';
import 'package:engmohamedkhedrcv/main.dart';

void main() {
  testWidgets('CV screen shows name', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text(CvData.name), findsOneWidget);
  });

  test('ATS PDF builds non-empty document', () async {
    final bytes = await CvAtsPdf.build();
    expect(bytes.length, greaterThan(2000));
  });
}
