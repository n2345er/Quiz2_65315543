import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const RepairApp());
}

class RepairApp extends StatelessWidget {
  const RepairApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Repair App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        scaffoldBackgroundColor: Colors.grey[50], 
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black, fontSize: 16), 
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blueAccent, 
        ),
      ),
      home: const HomePage(),
    );
  }
}
