import 'package:flutter/material.dart';
import 'database.dart';
import 'recipe_detailpage.dart';

class RecipeListPage extends StatefulWidget {
  final String category;

  const RecipeListPage({super.key, required this.category});

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  Set<int> savedRecipes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.category} Recipes',
          style: const TextStyle(
            color: Color(0xFFFAFADA),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF12372A),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFAFADA)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper().getRecipesByCategory(widget.category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No recipes found for this category.',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            );
          }

          final recipes = snapshot.data!;

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              final recipeId = recipe['id'];

              return Card(
                margin: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      recipe['imagePath'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    ),
                  ),
                  title: Text(
                    recipe['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${recipe['calories']} Calories',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      savedRecipes.contains(recipeId)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: savedRecipes.contains(recipeId)
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        if (savedRecipes.contains(recipeId)) {
                          savedRecipes.remove(recipeId);
                        } else {
                          savedRecipes.add(recipeId);
                        }
                      });
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailPage(
                          recipeName: recipe['name'],
                          imagePath: recipe['imagePath'],
                          servings: recipe['servings'],
                          time: recipe['time'],
                          calories: recipe['calories']?.toDouble() ?? 0,
                          ingredients: List<Map<String, String>>.from(
                              recipe['ingredients']),
                          steps: List<String>.from(recipe['directions']),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
