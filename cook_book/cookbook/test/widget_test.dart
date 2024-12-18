import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('RecipeApp widget test', (WidgetTester tester) async {
    // Build the RecipeApp widget
    
    // Verify if the AppBar title is present
    expect(find.text('LETS EMBARK ON YOUR COOKING JOURNEY!'), findsOneWidget);

    // Check for the presence of the "Recommendations" text
    expect(find.text('Recommendations'), findsOneWidget);
  });
}
