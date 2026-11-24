import 'package:flutter_test/flutter_test.dart';
import 'package:stride/main.dart';

void main() {
  testWidgets('shows the Stride landing screen', (tester) async {
    await tester.pumpWidget(const StrideApp(isSupabaseConfigured: true));

    expect(find.text('Stride'), findsWidgets);
    expect(find.text('Supabase configuration loaded.'), findsOneWidget);
  });
}
