import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import '/l10n/app_localizations.dart';
import 'utils/locator.dart';

void main() async {
  // Assicurati che i binding di Flutter siano inizializzati se chiami codice nativo prima di runApp
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator(); // Configura il service locator
  runApp(QuitSmokingApp());
}

class QuitSmokingApp extends StatelessWidget {
  const QuitSmokingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExHale',

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Correctly refers to the HomeScreen in canvas
    );
  }
}
