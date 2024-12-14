import 'package:cook_book/mainpage.dart';
import 'package:flutter/material.dart';
import 'mainpage.dart';

void main() {
  runApp(const CookPalApp());
}

class CookPalApp extends StatelessWidget {
  const CookPalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CookPal',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Montserrat',
      ),
      // Pass mock data to the RecipeDetailPage
      home: const MainPage(),
    );
  }
}
