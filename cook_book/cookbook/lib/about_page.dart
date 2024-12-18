import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(color: Color(0xFFFAFADA)),
        ),
        backgroundColor: const Color(0xff12372a),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFAFADA)),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Welcome to Cookbook!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'cookbook is your ultimate cooking companion. Discover new recipes, save your favorites, and embark on your cooking journey with us.',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'Features:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('- Explore a wide range of recipes.'),
            Text('- Save your favorite recipes.'),
            Text('- Get step-by-step cooking instructions.'),
            Text('- Search recipes by category or name.'),
          ],
        ),
      ),
    );
  }
}
