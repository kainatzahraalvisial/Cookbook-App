import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final Function(Map<String, String>) onFavoriteToggle;

  const MenuPage({super.key, required this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    final recipes = [
      {'recipeName': 'Zinger Burger', 'imageUrl': 'Asset/images/Burger.jpg', 'timeTaken': '20 min'},
      {'recipeName': 'Pasta', 'imageUrl': 'Asset/images/pasta.jpg', 'timeTaken': '45 min'},
      {'recipeName': 'Breakfast', 'imageUrl': 'Asset/images/breakfast.jpg', 'timeTaken': '10 min'},
      {'recipeName': 'Steaks', 'imageUrl': 'Asset/images/food.jpg', 'timeTaken': '15 min'},
      {'recipeName': 'Blue Lagoon', 'imageUrl': 'Asset/images/drink.png', 'timeTaken': '30 min'},
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff12372a),
          title: const Text(
            'LETS EMBARK ON YOUR COOKING JOURNEY!',
            style: TextStyle(
              color: Color(0xFFFAFADA)
              ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Recommended Recipes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 220, // Fix the height of the recipe list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return RecipeCard(
                      recipe: recipe,
                      onFavoriteToggle: onFavoriteToggle,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeCard extends StatefulWidget {
  final Map<String, String> recipe;
  final Function(Map<String, String>) onFavoriteToggle;

  const RecipeCard({super.key, required this.recipe, required this.onFavoriteToggle});

  @override
  RecipeCardState createState() => RecipeCardState();
}

class RecipeCardState extends State<RecipeCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, // Fixed width for the card
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.asset(
                widget.recipe['imageUrl']!,
                height: 100, // Fixed height for the image
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.recipe['recipeName']!,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                          widget.onFavoriteToggle(widget.recipe);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.timer, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        widget.recipe['timeTaken']!,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Favorite Page
class FavoritePage extends StatelessWidget {
  final List<Map<String, String>> favoriteRecipes;

  const FavoritePage({super.key, required this.favoriteRecipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff12372a),
        title: const Text(
          'Favorites',
          style: TextStyle(color: Color(0xFFFAFADA)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFAFADA)),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: ListView.builder(
        itemCount: favoriteRecipes.length,
        itemBuilder: (context, index) {
          final recipe = favoriteRecipes[index];
          return ListTile(
            leading: Image.asset(recipe['imageUrl']!, width: 50, height: 50, fit: BoxFit.cover),
            title: Text(recipe['recipeName']!),
            subtitle: Text('Time: ${recipe['timeTaken']}'),
          );
        },
      ),
    );
  }
}
