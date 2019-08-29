import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Views/login.dart';
import 'Views/startingView.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'AE'),
      ],
      locale: Locale('ar', 'AE'),
      title: 'Shashty',
      theme: ThemeData.dark(),
      home: StartingView(),
      routes: {
        'login': (context) => Login(),
        'signup': (context) => Login(),
      },
    );
  }
}
