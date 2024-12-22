import 'package:flutter/material.dart';

class RecipeDetailPage extends StatefulWidget {
  final String recipeName;
  final String imagePath;
  final int servings;
  final int time;
  final double calories;
  final List<Map<String, String>> ingredients;
  final List<String> steps;

  const RecipeDetailPage({
    super.key,
    required this.recipeName,
    required this.imagePath,
    required this.servings,
    required this.time,
    required this.calories,
    required this.ingredients,
    required this.steps,
  });

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool isFavorite = false; // Toggle favorite state

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xfffafada)),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        title: Text(
          widget.recipeName,
          style: const TextStyle(
            color: Color(0xfffafada), // Recipe name color
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF12372A),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite; // Toggle favorite
              });
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recipe Image
          Stack(
            children: [
              Image.asset(
                widget.imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image, size: 100),
                ),
              ),
            ],
          ),

          // Recipe Details
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xff9AA581),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoColumn("Servings", "${widget.servings}"),
                _buildInfoColumn("Time", "${widget.time} mins"),
                _buildInfoColumn("Calories", "${widget.calories}")
              ],
            ),
          ),

          // TabBar for Ingredients and Directions
          TabBar(
            controller: _tabController,
            labelColor: const Color(0xFF12372A),
            unselectedLabelColor: Colors.black,
            indicatorColor: const Color(0xff485935),
            tabs: const [
              Tab(text: "Ingredients"),
              Tab(text: "Directions"),
            ],
          ),

          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Ingredients Tab
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: widget.ingredients.map((ingredient) {
                    return ListTile(
                      leading: const Icon(Icons.check_box_outline_blank),
                      title: Text(
                        "${ingredient['name']} - ${ingredient['quantity']}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                ),

                // Directions Tab
                ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: widget.steps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xffADBC95),
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(color: Color(0xFFFAFADA)),
                          ),
                        ),
                        title: Text(
                          widget.steps[index],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      children: [
        Text(title,
            style: const TextStyle(fontSize: 14, color: Color(0xfffafada))),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
