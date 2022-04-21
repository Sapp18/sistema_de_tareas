///Flutter --version
///Flutter 2.10.4 • channel stable • https://github.com/flutter/flutter.git
///Tools • Dart 2.16.2 • DevTools 2.9.2


import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sistema_de_tareas/pages/pages.dart';
import 'package:sistema_de_tareas/theme/app_themes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      theme: AppThemes.darkTheme,
      title: 'Sistema de Gestión de Tareas',
      localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate
    ],
    supportedLocales: const [
      Locale('es', 'ES'),
    ],
      routes: {
        'home':(_) => const HomePage(),
      },
    );
  }
}