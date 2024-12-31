// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:asset_tree_app/main.dart' as app;

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   testWidgets('Test performance of assets screen and dropdowns',
//       (WidgetTester tester) async {
//     // Inicie o aplicativo
//     app.main();
//     await tester.pumpAndSettle();

//     // Navegue para a tela de assets
//     await tester.tap(find.text('Assets'));
//     await tester.pumpAndSettle();

//     // Meça o tempo de renderização inicial da tela de assets
//     final stopwatch = Stopwatch()..start();
//     await tester.pumpAndSettle();
//     stopwatch.stop();
//     print(
//         'Tempo de renderização inicial da tela de assets: ${stopwatch.elapsedMilliseconds} ms');

//     // Abra vários dropdowns e meça o tempo de renderização
//     final dropdowns = find.byType(ExpansionTile);
//     for (var i = 0; i < dropdowns.evaluate().length; i++) {
//       stopwatch.reset();
//       stopwatch.start();
//       await tester.tap(dropdowns.at(i));
//       await tester.pumpAndSettle();
//       stopwatch.stop();
//       print(
//           'Tempo de renderização ao abrir dropdown $i: ${stopwatch.elapsedMilliseconds} ms');
//     }
//   });
// }
