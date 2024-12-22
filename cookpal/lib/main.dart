import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'categories_page.dart';
import 'recipe_listpage.dart';
import 'recipe_detailpage.dart';

void main() {
  if (!kIsWeb) {
    // Initialize for desktop or mobile
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFFFFFFF), // Background color
        appBarTheme: const AppBarTheme(
          color: Color(0xFF12372A), // App bar color
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: '/', // Default route
      routes: {
        '/': (context) => const CategoryPage(), // Home route
        '/recipeList': (context) =>
            const RecipeListPage(category: ''), // Recipe list route
        '/recipeDetail': (context) => const RecipeDetailPage(
              recipeName: '',
              imagePath: '',
              servings: 0,
              time: 0,
              calories: 0.0,
              ingredients: [],
              steps: [],
            ), // Recipe detail route
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/recipeList') {
          final category = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => RecipeListPage(category: category),
          );
        } else if (settings.name == '/recipeDetail') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => RecipeDetailPage(
              recipeName: args['recipeName'],
              imagePath: args['imagePath'],
              servings: args['servings'],
              time: args['time'],
              calories: args['calories'],
              ingredients: args['ingredients'],
              steps: args['steps'],
            ),
          );
        }
        return null; // Default fallback
      },
    );
  }
}
