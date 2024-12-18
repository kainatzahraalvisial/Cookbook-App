import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  final List<Map<String, String>> favoriteRecipes;
  final VoidCallback onBackToHome; // Callback function to go back to the home page

  const FavoritePage({super.key, required this.favoriteRecipes, required this.onBackToHome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes',
        style: TextStyle(
          color: Color(0xFFFAFADA)
          ),
        ),
        backgroundColor: const Color(0xff12372a),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFAFADA)),
          onPressed: onBackToHome, // Use the callback to go back to home
        ),
      ),
      body: favoriteRecipes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_border, size: 48, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No favorite recipes added!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                final recipe = favoriteRecipes[index];
                return ListTile(
                  leading: Image.asset(recipe['imageUrl']!, fit: BoxFit.cover, width: 50, height: 50),
                  title: Text(recipe['recipeName']!),
                  subtitle: Row(
                    children: [
                      const Icon(Icons.timer, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(recipe['timeTaken']!),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
