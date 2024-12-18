import 'package:flutter/material.dart';
import 'menupage.dart';
import 'favorite_page.dart' as custom;
import 'about_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  final List<Map<String, String>> _favoriteRecipes = [];

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      MenuPage(
        onFavoriteToggle: (recipe) {
          setState(() {
            if (_favoriteRecipes.contains(recipe)) {
              _favoriteRecipes.remove(recipe);
            } else {
              _favoriteRecipes.add(recipe);
            }
          });
        },
      ),
      custom.FavoritePage(
        favoriteRecipes: _favoriteRecipes,
        onBackToHome: () {
          setState(() {
            _selectedIndex = 0; 
          });
        },
      ),
      const Center(child: Text('Categories')),
    ]);
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutPage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xff12372a),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        ],
      ),
    );
  }
}
