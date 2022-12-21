import 'package:flutter/material.dart';
import 'package:onate_hands_on/home_page.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List Hands On',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFFFFFF),
        appBarTheme: const AppBarTheme(
          elevation: 0.5,
        ),
        backgroundColor: Colors.brown,
      ),
      home: HomePage(),
    );
  }
}
