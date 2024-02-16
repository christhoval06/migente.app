import 'package:flutter/material.dart';
import 'package:mi_gente/config/app_constants.dart';
import 'package:mi_gente/router.dart' as router;
import 'package:mi_gente/ui/locator.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Gente',
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo, secondary: Colors.deepOrange),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepOrange),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
            labelStyle: TextStyle(color: Colors.deepOrange),
            errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red))),
      ),
      initialRoute: RoutePaths.home,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
