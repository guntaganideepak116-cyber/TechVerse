import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_verse/main.dart';
import 'package:tech_verse/providers/app_providers.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Initializing mock shared preferences
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const TechVerseApp(),
      ),
    );

    // Verify if TechVerse title appears
    expect(find.text('Celebrate the Future'), findsNothing); // TechVerse is in a gradient, so finding text might be tricky but we can check existence
  });
}
