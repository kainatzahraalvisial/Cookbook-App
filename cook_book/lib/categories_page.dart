import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {'name': 'BreakFast', 'image': 'assets/images/breakfast.png'},
      {'name': 'Lunch', 'image': 'assets/images/lunch.png'},
      {'name': 'Dinner', 'image': 'assets/images/dinner.png'},
      {'name': 'Desserts', 'image': 'assets/images/dessert.png'},
      {'name': 'Drinks', 'image': 'assets/images/drink.png'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF12372A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFAFADA)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Color(0xFFFAFADA),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.8,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RecipeListPage(category: category['name']),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xfffafada),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6.0,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 4,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16.0),
                        ),
                        child: Image.asset(
                          category['image']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          category['name']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF38422B),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class RecipeListPage extends StatelessWidget {
  final String? category;

  const RecipeListPage({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF12372A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xfffafada)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '$category Recipes',
          style: const TextStyle(
            color: Color(0XFFFAFADA),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'List of $category recipes will appear here.',
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}
