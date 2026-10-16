import 'package:flutter/material.dart';
import 'package:flutter_month3/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List', //хотел другое название но сойдет
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF007AFF),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}
