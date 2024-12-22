import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('recipes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE recipes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        category TEXT NOT NULL,
        time INTEGER NOT NULL,
        serving INTEGER NOT NULL,
        calories INTEGER NOT NULL,
        ingredients TEXT NOT NULL,
        directions TEXT NOT NULL
      )
    ''');
  }

  Future<void> initializeDatabase() async {
    final db = await database;

    // Sample recipes for Breakfast and Desserts categories
    final recipes = [
      //breakfast recipe
      //1
      {
        'name': 'Pancakes',
        'imageUrl': 'assets/images/pancake.png',
        'category': 'Breakfast',
        'time': 25,
        'serving': 4,
        'calories': 200,
        'ingredients':
            '[{"name": "All-purpose flour", "quantity": "1 cup"}, {"name": "Milk", "quantity": "3/4 cup"}, {"name": "Egg", "quantity": "1 large"},{"name": "Sugar", "quantity": "2 tbsp"},{"name": "Baking Powder", "quantity": "2 tsp"},{"name": "Salt", "quantity": "1/4 tsp"},{"name": "Melted Butter", "quantity": "2 tbsp"},{"name": "Mapple/Chocolate Syrup", "quantity": "-"}]',
        'directions':
            '["In a bowl, whisk flour, sugar, baking powder, and salt.", "In another bowl, whisk milk, egg, and melted butter.", "Gradually combine the wet ingredients with the dry mixture until smooth. Avoid overmixing.","Heat a non-stick skillet and grease it lightly with butter.","Pour 1/4 cup batter onto the skillet for each pancake. Cook until bubbles form on the surface, then flip and cook the other side until golden.","Serve with Mapple, chocolate or anyother syrup, butter, or fruit."]',
      },
//2
      {
        'name': 'Aloo Paratha',
        'imageUrl': 'assets/images/aloo paratha.jpg',
        'category': 'Breakfast',
        'time': 30,
        'serving': 2,
        'calories': 350,
        'ingredients':
            '[{"name": "Whole Wheat flour", "quantity": "2 cup"}, {"name": "Water", "quantity": "1/2 cup (As needed)"}, {"name": "Salt", "quantity": "1/2 tsp"},{"name": "Boiled Potatos (mashed)", "quantity": "3 medium"},{"name": "Red Chili Powder", "quantity": "1/2 tsp"},{"name": "Cumin Powder", "quantity": "1/2 tsp"},{"name": "Garam Masala", "quantity": "1/2 tsp"},{"name": "Coriander leaves (chopped)", "quantity": "2 tbsp"}]',
        'directions':
            '["In a mixing bowl, knead the dough by mixing whole wheat flour, salt, and water until smooth. Cover and let rest for 10 minutes.", "In another bowl, combine mashed potatoes, red chili powder, cumin powder, garam masala, chopped coriander, and salt. Mix well.", "Divide the dough and filling into 4 equal portions.","Roll out one dough ball into a small circle. Place a portion of the filling in the center, then seal it by bringing the edges together.","Roll the stuffed dough gently into a flat paratha.","Heat a tawa or skillet and cook the paratha on both sides, applying oil/ghee, until golden brown.","Serve hot with yogurt or pickle."]',
      },
      //3
      {
        'name': 'Masala Omelette',
        'imageUrl': 'assets/images/omlette.jpg',
        'category': 'Breakfast',
        'time': 10,
        'serving': 1,
        'calories': 250,
        'ingredients':
            '[{"name": "Eggs", "quantity": "2"}, {"name": "Onion (Finely chopped)", "quantity": "1 Small"}, {"name": "Green Chili (Finely chopped)", "quantity": "1"},{"name": "Tomatoes (Chopped)", "quantity": "2 tbsp"},{"name": "Coriander Leaves (Finely chopped)", "quantity": "1 tbsp"},{"name": "Turmeric Powder", "quantity": "1/4 tsp"},{"name": "Red Chili ", "quantity": "1/4 tsp"},{"name": "Salt", "quantity": "To taste"},{"name": "Oil", "quantity": "1 tbsp"}]',
        'directions':
            '["Beat eggs in a bowl and add onion, chili, tomatoes, coriander, turmeric, red chili powder, and salt. Mix well.", "Heat oil in a pan over medium heat.", "Pour the egg mixture and spread evenly.","Cook until the edges lift slightly, then flip and cook the other side for 1-2 minutes.","Serve with toast or paratha."]',
      },
//4
      {
        'name': 'French Toast',
        'imageUrl': 'assets/images/french.jpg',
        'category': 'Breakfast',
        'time': 15,
        'serving': 2,
        'calories': 200,
        'ingredients':
            '[{"name": "Eggs", "quantity": "2"}, {"name": "Milk", "quantity": "1/2 Cup"}, {"name": "Sugar", "quantity": "1 tbsp"},{"name": "Vanilla Extract", "quantity": "1/2 tsp"},{"name": "Bread", "quantity": "4 Slices"},{"name": "Butter/Oil", "quantity": "As needed"}]',
        'directions':
            '["In a bowl, whisk eggs, milk, sugar, and vanilla.", "Heat oil or butter in a pan over medium heat.", "In a bowl, whisk eggs, milk, sugar, and vanilla.","Fry the bread slices on both sides until golden brown.","Serve with honey, syrup, or powdered sugar."]',
      },
      //5
      {
        'name': 'Smoothie Bowl',
        'imageUrl': 'assets/images/smoothie.jpg',
        'category': 'Breakfast',
        'time': 5,
        'serving': 1,
        'calories': 100,
        'ingredients':
            '[{"name": "Frozen Banana", "quantity": "1"}, {"name": "Frozen Berries", "quantity": "1/2 cup"}, {"name": "Yogurt", "quantity": "1/2 cup"}, {"name": "Granola", "quantity": "1/4 cup"}, {"name": "Fresh fruits", "quantity": "As needed"}]',
        'directions':
            '["Blend banana, berries, and yogurt until smooth.", "Pour into a bowl and top with granola, fruits, and nuts.", "Serve immediately."]',
      },
      //6
      {
        'name': 'Avocado Toast',
        'imageUrl': 'assets/images/avocado.png',
        'category': 'Breakfast',
        'time': 5,
        'serving': 1,
        'calories': 100,
        'ingredients':
            '[{"name": "Bread", "quantity": "1 Slice"}, {"name": "Ripe Avocado", "quantity": "1/2"}, {"name": "Salt", "quantity": "To Taste"}, {"name": "Pepper", "quantity": "To Taste"}]',
        'directions':
            '["Toast the bread.", "Mash the avocado and spread it onto the toast.", "Season with salt, pepper, and chili flakes. Add a poached egg if desired."]',
      },
      //7
      {
        'name': 'Nihari With Paratha',
        'imageUrl': 'assets/images/nihari.jpg',
        'category': 'Breakfast',
        'time': 255,
        'serving': 4,
        'calories': 600,
        'ingredients':
            '[{"name": "Beef or Mutton", "quantity": "500g"}, {"name": "Ghee", "quantity": "1/2 Cup"}, {"name": "Wheat Flour", "quantity": "1/4 Cup"}, {"name": "Onion (Sliced)", "quantity": "1"}, {"name": "Ginger-Garlic Paste", "quantity": "1 tbsp"}, {"name": "Nihari Masala", "quantity": "2 tbsp"}, {"name": "Turmeric Powder", "quantity": "1/2 tsp"}, {"name": "Chili Powder", "quantity": "1/2 tsp"}, {"name": "Water", "quantity": "6 Cups"}, {"name": "Salt", "quantity": "To Taste"},]',
        'directions':
            '["Heat ghee in a large pot, fry onions until golden. Add ginger-garlic paste and sauté.", "Add meat, nihari masala, turmeric, and chili powder. Cook until the meat is browned.", "Pour water, cover, and slow-cook for 3-4 hours until the meat is tender.", "Mix flour with water to form a slurry and add it to the pot to thicken the gravy. Simmer for 10 minutes.", "Serve hot with parathas, lemon wedges, and julienned ginger."]',
      },
      //8
      {
        'name': 'Anda Chana',
        'imageUrl': 'assets/images/channa.jpg',
        'category': 'Breakfast',
        'time': 30,
        'serving': 4,
        'calories': 250,
        'ingredients':
            '[{"name": "Boiled Cickpeas", "quantity": "2 Cups"}, {"name": "Boiled Eggs (sliced)", "quantity": "2 Medium"}, {"name": "Onion (Chopped)", "quantity": "2 Medium"}, {"name": "Tomatoes (Chopped)", "quantity": "2 Medium"}, {"name": "Cumin Seeds", "quantity": "1 tsp"}, {"name": "Red Chili Powder", "quantity": "1 tsp"}, {"name": "Turmeric Powder", "quantity": "1/2 tsp"}, {"name": "Oil", "quantity": "1 tbsp"}, {"name": "Salt", "quantity": "To Taste"},]',
        'directions':
            '["Heat oil, add cumin seeds and sauté onions until golden.", "Add tomatoes, red chili powder, turmeric, and salt. Cook until the tomatoes are soft.", "Add boiled chickpeas and cook for 5-7 minutes. Adjust consistency with water if needed.", "Top with sliced boiled eggs and garnish with fresh coriander.", "Serve with parathas or naan."]',
      },
      //9
      {
        'name': 'Halwa',
        'imageUrl': 'assets/images/halwa.png',
        'category': 'Breakfast',
        'time': 30,
        'serving': 4,
        'calories': 350,
        'ingredients':
            '[{"name": "Semolina", "quantity": "1 Cup"}, {"name": "Sugar", "quantity": "3/4 Cup"}, {"name": "Water", "quantity": "4 Cups"}, {"name": "Cardamom Powder", "quantity": "1/4 tsp"}, {"name": "Ghee", "quantity": "2 tbsp"}, {"name": "Nuts & Raisins", "quantity": "As Needed"}]',
        'directions':
            '["Heat ghee in a pan, roast semolina until aromatic.", "Separately, boil water with sugar and cardamom powder. Slowly add this syrup to the roasted semolina, stirring continuously.", "Cook until thickened. Garnish with nuts and raisins.", "Serve hot halwa with puris, parathas or naan."]',
      },
      //10
      {
        'name': 'Naan',
        'imageUrl': 'assets/images/naan.jpg',
        'category': 'Breakfast',
        'time': 140,
        'serving': 6,
        'calories': 232,
        'ingredients':
            '[{"name": "All-Purpose Flour", "quantity": "2 Cups"}, {"name": "Plain Yogurt", "quantity": "1/2 Cup"}, {"name": "Warm Milk", "quantity": "1/2 Cup"}, {"name": "Sugar", "quantity": "1 tsp"}, {"name": "Baking Powder", "quantity": "1 tsp"}, {"name": "Baking Soda", "quantity": "1/2 tsp"}, {"name": "Oil", "quantity": "2 tbsp"}, {"name": "Salt", "quantity": "1 tsp"}, {"name": "Kalonji/Sesame Seeds", "quantity": "As Needed"}]',
        'directions':
            '["In a large bowl, mix the dry ingredients: flour, sugar, salt, baking powder, and baking soda.", "Add yogurt and oil to the flour mixture.", "Gradually pour warm milk while kneading to form a soft dough. The dough should be slightly sticky but manageable.", "Cover the dough with a damp cloth and let it rest in a warm place for 1.5 to 2 hours until it doubles in size.", "After the dough has risen, punch it down and knead briefly to remove air bubbles.", "Divide the dough into 6 equal portions and roll each piece into a ball.", "Lightly flour your surface and roll each ball into an oval or round shape, about 1/4-inch thick.", "Preheat the oven to 250°C (475°F) with a baking tray or pizza stone inside.", "Place the naan on the hot tray and bake for 2-3 minutes until puffed and golden. Broil for 30 seconds for a slight char.", "Brush with butter or ghee before serving."]',
      },
      // Dessert recipes
      //1
      {
        'name': 'Gulab Jamun',
        'imageUrl': 'assets/images/GhulabJamun.jpg',
        'category': 'Dessert',
        'time': 40,
        'serving': 12,
        'calories': 150,
        'ingredients':
            '[{"name": "Milk Powder", "quantity": "1 Cup"}, {"name": "All-Purpose Flour", "quantity": "1/4 Cup"}, {"name": "Ghee", "quantity": "2 tbsp"}, {"name": "Milk (Warm)", "quantity": "2-3 tbsp"}, {"name": "Baking Powder", "quantity": "1/2 tsp"}, {"name": "Oil", "quantity": "For Frying"}, {"name": "Sugar", "quantity": "2 Cups"}, {"name": "Water (Warm)", "quantity": "2 Cups"}, {"name": "Cardamom Pods", "quantity": "4"}, {"name": "Rose Water", "quantity": "3-4 Drops"}]',
        'directions':
            '["Make syrup: Boil sugar, water, and cardamom until slightly thickened. Add rose water and keep warm.", "Mix milk powder, flour, ghee, and baking powder. Add milk gradually to form a soft dough. Let rest for 10 minutes.", "Roll into small balls and fry on low-medium heat until golden brown.", "Soak in warm syrup for 45 minutes before serving."]',
      },
      //2
      {
        'name': 'Tiramisu',
        'imageUrl': 'assets/images/Tiramisu.jpg',
        'category': 'Dessert',
        'time': 20,
        'serving': 6,
        'calories': 300,
        'ingredients':
            '[{"name": "Mascarpone Cheese", "quantity": "1 Cup"}, {"name": "Heavy Cream", "quantity": "1 Cup"}, {"name": "Sugar", "quantity": "1/3 Cup"}, {"name": "Brewed Coffee (Cooled)", "quantity": "2 Cups"}, {"name": "Ladyfinger Biscuits", "quantity": "24 pcs"}, {"name": "Cocoa Powder", "quantity": "2 tbsp"}]',
        'directions':
            '["Whisk heavy cream and sugar until stiff peaks form. Fold in mascarpone cheese.", "Dip ladyfingers in coffee briefly. Arrange a layer in a dish.", "Spread half the cream mixture on top. Repeat layers.", "Dust cocoa powder on top and chill for 4 hours before serving."]',
      },
      //3
      {
        'name': 'Kheer',
        'imageUrl': 'assets/images/kheer.jpg',
        'category': 'Dessert',
        'time': 50,
        'serving': 4,
        'calories': 250,
        'ingredients':
            '[{"name": "Rice (Soaked)", "quantity": "1/2 Cup"}, {"name": "Milk", "quantity": "4 Cups"}, {"name": "Sugar", "quantity": "1/2 Cup"}, {"name": "Cardamom Powder", "quantity": "1/4 tsp"}, {"name": "Nuts and Raisins", "quantity": "For Garnish"}]',
        'directions':
            '["Boil milk, add soaked rice, and simmer on low heat until rice is soft and the mixture thickens.", "Add sugar and cardamom powder. Cook for another 5 minutes.", "Garnish with nuts and serve warm or chilled."]',
      },
      //4
      {
        'name': 'Cheesecake',
        'imageUrl': 'assets/images/cheesecake.jpg',
        'category': 'Dessert',
        'time': 80,
        'serving': 8,
        'calories': 400,
        'ingredients':
            '[{"name": "Cream Cheese", "quantity": "2 Cups"}, {"name": "Eggs", "quantity": "3 Large"}, {"name": "Sugar", "quantity": "1 Cup"}, {"name": "Vanilla Extract", "quantity": "1 tsp"}, {"name": "Biscuit Crumbs", "quantity": "1.5 Cups"},{"name": "Melted Butter", "quantity": "1/4 Cup"}]',
        'directions':
            '["Mix biscuit crumbs and butter. Press into a springform pan and chill.", "Beat cream cheese, sugar, eggs, and vanilla until smooth. Pour over crust.", "Bake at 160°C (325°F) for 1 hour. Chill before serving."]',
      },
      //5
      {
        'name': 'Brownies',
        'imageUrl': 'assets/images/brownie.jpg',
        'category': 'Dessert',
        'time': 35,
        'serving': 8,
        'calories': 200,
        'ingredients':
            '[{"name": "All-Purpose Flour", "quantity": "1/4 Cup"}, {"name": "Eggs", "quantity": "2 Large"}, {"name": "Sugar", "quantity": "1/2 Cup"}, {"name": "Cocoa Powder", "quantity": "1/2 Cup"}, {"name": "  Salt", "quantity": "1/3 tsp"},{"name": "Melted Butter", "quantity": "1/2 Cup"}]',
        'directions':
            '["Mix melted butter and sugar. Add eggs and whisk well.", "Fold in cocoa powder, flour, and salt.", "Pour batter into a greased pan and bake at 180°C (350°F) for 20 minutes.", "Cool, slice, and serve."]',
      },
      //6
      {
        'name': 'Shahi Tukray',
        'imageUrl': 'assets/images/shahitukray.jpg',
        'category': 'Dessert',
        'time': 35,
        'serving': 4,
        'calories': 300,
        'ingredients':
            '[{"name": "Bread", "quantity": "4 Slices"}, {"name": "Milk", "quantity": "2 Cups"}, {"name": "Sugar", "quantity": "1/2 Cup"}, {"name": "Cardamom Powder", "quantity": "1/4 tsp"}, {"name": "Ghee", "quantity": "2 tsp"},{"name": "Nuts and Raisins", "quantity": "As Required"}]',
        'directions':
            '["Fry bread slices in ghee until golden.", "Boil milk, add sugar, and cardamom powder. Cook until slightly thickened.", "Pour warm milk mixture over fried bread. Garnish with nuts and serve chilled or warm."]',
      },
      //7
      {
        'name': 'Sponge Cake',
        'imageUrl': 'assets/images/teacake.jpg',
        'category': 'Dessert',
        'time': 55,
        'serving': 8,
        'calories': 180,
        'ingredients':
            '[{"name": "All-Purpose Flour", "quantity": "1 Cup"}, {"name": "Baking Powder", "quantity": "1 tsp"}, {"name": "Sugar", "quantity": "3/4 Cup"}, {"name": "Vanilla Extract", "quantity": "1/4 tsp"}, {"name": "Eggs (On Room Temperature)", "quantity": "4 Large"},{"name": "Salt", "quantity": "1/4 tsp"}]',
        'directions':
            '["Preheat your oven to 180°C (350°F). Grease and line an 8-inch round cake pan.", "Sift flour, baking powder, and salt into a bowl.", "In a separate bowl, beat eggs and sugar using a hand or stand mixer for 8-10 minutes until the mixture is pale and fluffy.", "Add vanilla extract to the egg mixture.", "Gradually fold in the dry ingredients using a spatula, ensuring the batter stays light.", "Pour the batter into the prepared pan. Bake for 25-30 minutes, or until a toothpick inserted in the center comes out clean.", "Let the cake cool for 10 minutes before removing it from the pan.",]',
      },
      //8
      {
        'name': 'Macarons',
        'imageUrl': 'assets/images/macrons.jpg',
        'category': 'Dessert',
        'time': 45,
        'serving': 15,
        'calories': 80,
        'ingredients':
            '[{"name": "Almond Flour", "quantity": "3/4 Cup"}, {"name": "Powdered Sugar", "quantity": "1 Cup"}, {"name": "Granulated Sugar", "quantity": "1/4 Cup"}, {"name": "Food Colouring", "quantity": "Optional"}, {"name": "Egg Whites (Room Temperature)", "quantity": "2 Large"},{"name": "Butter Cream", "quantity": "For Filling"}]',
        'directions':
            '["Sift almond flour and powdered sugar together.", "In a clean bowl, whisk egg whites until foamy, then gradually add granulated sugar. Beat until stiff peaks form. Add food coloring if desired.", "Fold the almond flour mixture into the meringue in three parts. The batter should flow like lava.", "Pipe small circles onto a baking sheet lined with parchment paper. Tap the tray to release air bubbles.", "Let the macarons rest for 30-40 minutes until they form a skin.", "Bake at 150°C (300°F) for 12-15 minutes. Let cool completely before filling with buttercream or ganache."]',
      },
      //9
      {
        'name': 'Trifle',
        'imageUrl': 'assets/images/Trifle.jpg',
        'category': 'Dessert',
        'time': 25,
        'serving': 6,
        'calories': 300,
        'ingredients':
            '[{"name": "Sponge Cake (Cut into Cubes)", "quantity": "1 Medium"}, {"name": "Custard", "quantity": "2 Cups"}, {"name": "Fruits (Strawberries, Bananas, Mangoes)", "quantity": "1 Cup"}, {"name": "Jelly (Prepared and cut into cubes)", "quantity": "1/4 Cup"}, {"name": "Nuts or Sprinkles", "quantity": "For Garnish"},{"name": "Whipped Cream", "quantity": "1 Cup"}]',
        'directions':
            '["Layer the sponge cake cubes at the bottom of a large trifle dish or individual glasses.", "Pour a layer of custard over the cake.", "Add a layer of fruits, followed by jelly cubes.", "Top with whipped cream and repeat layers if needed.", "Garnish with nuts or sprinkles. Chill for at least 2 hours before serving."]',
      },
      //10
      {
        'name': 'Chocolate Chip Cookies',
        'imageUrl': 'assets/images/chocochip.jpg',
        'category': 'Dessert',
        'time': 30,
        'serving': 12,
        'calories': 150,
        'ingredients':
            '[{"name": "Butter (Softened)", "quantity": "1/2 Cup"}, {"name": "Granulated Sugar", "quantity": "1/2 Cup"}, {"name": "Brown Sugar", "quantity": "1/4 Cup"}, {"name": "Egg", "quantity": "1 Large"}, {"name": "Vanilla Extract", "quantity": "1 tsp"},{"name": "All-Purpose Flour", "quantity": "1 & 1/4 Cup"},{"name": "Chocolate Chips", "quantity": "3/4 Cup"},{"name": "Baking Soda", "quantity": "1/2 tsp"},{"name": "Salt", "quantity": "1/4 tsp"}]',
        'directions':
            '["Preheat your oven to 180°C (350°F). Line a baking sheet with parchment paper.", "Cream butter, granulated sugar, and brown sugar until fluffy. Add egg and vanilla, mixing well.", "In a separate bowl, whisk flour, baking soda, and salt. Gradually add to the wet ingredients.", "Fold in chocolate chips.", "Scoop dough onto the baking sheet, leaving space between cookies.", "Bake for 12-15 minutes, or until edges are golden. Let cool on the sheet for 5 minutes before transferring to a wire rack."]',
      },
    ];
    for (var recipe in recipes) {
      try {
        await db.insert('recipes', recipe,
            conflictAlgorithm: ConflictAlgorithm.replace);
      } catch (e) {
        log('Error inserting recipe: $e');
      }
    }
  }

  Future<int> insertUser(String name, String email, String password) async {
    final db = await database;
    return await db.insert(
      'users',
      {'name': name, 'email': email, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    final db = await database;
    try {
      final result = await db.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );
      return result.isNotEmpty ? result.first : null;
    } catch (e) {
      log('Error fetching user: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getRecipes() async {
    final db = await database;
    try {
      return await db.query('recipes');
    } catch (e) {
      log('Error fetching recipes: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getRecipesByCategory(
      String category) async {
    final db = await database;
    try {
      final results = await db.query(
        'recipes',
        where: 'LOWER(category) = LOWER(?)',
        whereArgs: [category],
      );
      if (results.isEmpty) {
        log('No recipes found for category: $category', name: 'DatabaseHelper');
      } else {
        log('Found ${results.length} recipes for category: $category',
            name: 'DatabaseHelper');
      }
      return results;
    } catch (e) {
      log('Error fetching recipes by category: $category',
          error: e, name: 'DatabaseHelper');
      return [];
    }
  }
}
