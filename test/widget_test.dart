import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz/main.dart';

void main() {
  testWidgets('Quiz app starts with Home Page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Vérifiez que le titre de la page d'accueil est affiché.
    expect(find.text('Quiz Home'), findsOneWidget);

    // Vérifiez que le bouton pour commencer le quiz est affiché.
    expect(find.text('Start Quiz'), findsOneWidget);
  });

  testWidgets('Quiz progresses to questions', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Appuyez sur le bouton pour commencer le quiz.
    await tester.tap(find.text('Start Quiz'));
    await tester.pumpAndSettle(); // Attendez que la transition soit terminée.

    // Vérifiez que la première question est affichée.
    expect(find.text('Quel est le plus grand océan de la Terre ?'),
        findsOneWidget);
  });

  testWidgets('Selecting correct answer updates score',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Appuyez sur le bouton pour commencer le quiz.
    await tester.tap(find.text('Start Quiz'));
    await tester.pumpAndSettle(); // Attendez que la transition soit terminée.

    // Appuyez sur la réponse correcte.
    await tester.tap(find.text('Océan Pacifique'));
    await tester.pumpAndSettle(); // Attendez que la transition soit terminée.

    // Vérifiez que le résultat affiche le score.
    expect(find.text('Votre score: 1/3'), findsOneWidget);
  });

  testWidgets('Selecting incorrect answer does not update score',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Appuyez sur le bouton pour commencer le quiz.
    await tester.tap(find.text('Start Quiz'));
    await tester.pumpAndSettle(); // Attendez que la transition soit terminée.

    // Appuyez sur une réponse incorrecte.
    await tester.tap(find.text('Océan Atlantique'));
    await tester.pumpAndSettle(); // Attendez que la transition soit terminée.

    // Vérifiez que le résultat affiche le score.
    expect(find.text('Votre score: 0/3'), findsOneWidget);
  });
}
