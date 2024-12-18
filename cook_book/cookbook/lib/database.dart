import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cookpal.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE recipes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            imageUrl TEXT NOT NULL,
            category TEXT NOT NULL,
            time INTEGER NOT NULL,
            serving INTEGER NOT NULL,
            ingredients TEXT NOT NULL,
            directions TEXT NOT NULL
          )
        ''');
        await _insertRecipes(db);
      },
    );
  }

  Future<void> _insertRecipes(Database db) async {
    final recipes = [
      //Lunch recipe
      //1
      {
        'name': 'Chicken Biryani',
        'imageUrl': 'https://example.com/images/pancakes.jpg',
        'category': 'Lunch',
        'time': 90,
        'serving': 4,
        'ingredients':
            '[{"name": "Chicken", "quantity": "1 kg"}, {"name": "biryani masala", "quantity": "1 Pack"}, {"name": " yogurt", "quantity": "1 Cup"},{"name": "tomatoes", "quantity": "1 kg"},{"name": "Fried onions", "quantity": "2 large"},{"name": "Salt", "quantity": "4 tsp"}]',
        'directions':
            '["Prepare chicken curry with spices, yogurt, and tomatoes", "Parboil the rice with whole spices.", "Layer curry and rice in a pot, steam for 20 minutes."]',
      },
      //2
      {
        'name': 'Aloo Gosht ',
        'imageUrl': 'https://example.com/images/pancakes.jpg',
        'category': 'Lunch',
        'time': 60,
        'serving': 4,
        'ingredients':
            '[{"name": " Beef/mutton", "quantity": "1 kg"}, {"name": "potatoes", "quantity": "1 kg"}, {"name": "tomatoes", "quantity": "1 kg"},{"name": "onions", "quantity": "3 medium"},{"name": "ginger", "quantity": "1 medium"},{"name": "spices", "quantity": "1/2 tsp"},{"name": "Garam Masala", "quantity": "1/2 tsp"},{"name": "Coriander leaves (chopped)", "quantity": "2 tbsp"}]',
        'directions':
            '["Heat oil in a pot, sauté onions until golden.", "Add ginger-garlic paste, turmeric, and red chili powder. Stir well.", "Add meat and cook until it changes color. Add tomatoes and cook until soft.","Pour water, cover, and simmer until meat is tender.","Add potatoes and cook until soft. Sprinkle garam masala before serving."]',
      },
      //3
      {
        'name': 'Chicken Karahi',
        'imageUrl': 'https://example.com/images/omelette.jpg',
        'category': 'Lunch',
        'time': 30,
        'serving': 4,
        'ingredients':
            '[{"name": "chicken", "quantity": "1 kg"}, {"name": " tomatoes (chopped)", "quantity": "4 medium"}, {"name": "Green Chili (Finely chopped)", "quantity": "1"},{"name": "ginger-garlic paste", "quantity": "2 tbsp"},{"name": "red chili powder", "quantity": "1 tbsp"},{"name": "cumin seeds", "quantity": "1 tsp"},{"name": "Oil ", "quantity": "3 tsp"}]',
        'directions':
            '["Heat oil in a wok, add ginger-garlic paste and sauté for a minute.", "Add chicken and cook until it turns white.", "Add tomatoes, spices, and cook until chicken is tender.","Garnish with green chilies and julienned ginger."]',
      },
      //4
      {
        'name': 'Daal Chawal ',
        'imageUrl': 'https://example.com/images/omelette.jpg',
        'category': 'Lunch',
        'time': 40,
        'serving': 2,
        'ingredients':
            '[{"name": "red lentils", "quantity": "1 cup"}, {"name": " onion (sliced)", "quantity": "1 medium "}, {"name": " Green chilies", "quantity": "2"},{"name": "tumeric powder", "quantity": "1 tsp"},{"name": "red chilli powder", "quantity": "1 tsp"},{"name": "Butter/Oil", "quantity": "As needed"},{"name": "water", "quantity": "2 cups"]',
        'directions':
            '["Wash lentils and boil them with turmeric and red chili powder.", "Heat oil in a pan, fry onions until golden, and add to lentils.", "Simmer until the mixture thickens. Serve with steamed white rice."]',
      },
      //5
      {
        'name': 'Bhindi Masala',
        'imageUrl': 'https://example.com/images/smoothie_bowl.jpg',
        'category': 'Lunch',
        'time': 30,
        'serving': 3,
        'ingredients':
            '[{"name": "okra (sliced)", "quantity": "500 g"}, {"name": " onions (chopped)", "quantity": "2 medium"}, {"name": "tomatoes (chopped)", "quantity": "2 medium"}, {"name": " turmeric powder", "quantity": "1 tsp"}, {"name": " red chili powder", "quantity": "2 tbsp"},{"name": "Oil", "quantity": "2 tbsp"}]',
        'directions':
            '["Heat oil in a pan, fry okra until slightly crispy, and set aside.", "In the same pan, cook onions and tomatoes with spices until soft.", "Add fried okra, mix well, and cook for 5 minutes."]',
      },
      //6
      {
        'name': 'Keema Matar',
        'imageUrl': 'https://example.com/images/smoothie_bowl.jpg',
        'category': 'Lunch',
        'time': 60,
        'serving': 3,
        'ingredients':
            '[{"name": "Minced beef/mutton", "quantity": "500 g"}, {"name": "green peas", "quantity": "1 cup"}, {"name": "onions (chopped)", "quantity": "2 medium"}, {"name": "tomatoes (chopped)", "quantity": "2 medium"},{"name": "ginger-garlic paste", "quantity": "2 tsp"},{"name": "turmeric powder", "quantity": "1 tsp"},{"name": "red chili powder", "quantity": "1 tsp"},{"name": " garam masala", "quantity": "1 tsp"},{"name": "Oil", "quantity": "4 tsp"}]',
        'directions':
            '["Heat oil in a pot and sauté onions until golden", "Add ginger-garlic paste, minced meat, and spices. Cook for 10 minutes.", "Add tomatoes and cook until they soften.","Add green peas, cover, and cook on low heat until peas are tender.","Sprinkle garam masala and serve hot."]',
      },
      //7
      {
        'name': 'Palak Paneer',
        'imageUrl': 'https://example.com/images/smoothie_bowl.jpg',
        'category': 'Lunch',
        'time': 50,
        'serving': 5,
        'ingredients':
            '[{"name": "spinach", "quantity": "500g"}, {"name": "paneer", "quantity": "200 g"}, {"name": "onion (chopped)", "quantity": "1 medium"}, {"name": "Tomatoes (Sliced)", "quantity": "2 medium"}, {"name": "Ginger-Garlic Paste", "quantity": "2 tbsp"}, {"name": "cream", "quantity": "2 tbsp"}, {"name": "Turmeric Powder", "quantity": "1/2 tsp"}, {"name": "Chili Powder", "quantity": "1 tsp"}, {"name": "Oil", "quantity": "3 tsp"}, {"name": "Salt", "quantity": "To Taste"},]',
        'directions':
            '["Heat oil in a pan and fry paneer cubes until golden. Set aside.", "In the same pan, sauté onions and cumin seeds. Add ginger-garlic paste.", "Add tomato puree, spices, and cook until oil separates.", "Stir in spinach puree and simmer for 5 minutes.", "Add fried paneer and cream. Mix well and serve."]',
      },
      //8
       {
        'name': 'Chana Pulao',
        'imageUrl': 'https://example.com/images/smoothie_bowl.jpg',
        'category': 'Lunch',
        'time': 90,
        'serving': 3,
        'ingredients':
            '[{"name": " rice", "quantity": "2 Cups"}, {"name": " boiled chickpeas", "quantity": "1 cup"}, {"name": "Onion (Chopped)", "quantity": "2 Medium"}, {"name": "Tomatoes (Chopped)", "quantity": "2 Medium"}, {"name": "Cumin Seeds", "quantity": "1 tsp"}, {"name": "Red Chili Powder", "quantity": "1 tsp"}, {"name": "Garam Masala", "quantity": "1/2 tsp"}, {"name": "Oil", "quantity": "3 tbsp"}, {"name": "Salt", "quantity": "To Taste"},]',
        'directions':
            '["Heat oil in a pot, add cumin seeds, and fry onions until golden.", "Add ginger-garlic paste, chickpeas, and spices. Cook for 5 minutes", "Add water and bring to a boil. Add rice and cook until water evaporates.", "Cover and steam on low heat for 15 minutes.", "Serve with Yogurt."]',
      },
      //9
      {
        'name': ' Karahi Fish',
        'imageUrl': 'https://example.com/images/smoothie_bowl.jpg',
        'category': 'Lunch',
        'time': 120,
        'serving': 4,
        'ingredients':
            '[{"name": "boneless fish fillets", "quantity": "500 g"}, {"name": "tomatoes (chopped)", "quantity": "3 medium"}, {"name": "green chilies (sliced)", "quantity": "3"}, {"name": " ginger-garlic paste", "quantity": "2 tsp"}, {"name": "red chili powder", "quantity": "1 tsp"}, {"name": "turmeric powder", "quantity": "1 tsp"},{"name": "oil", "quantity": "3 tsp"},{"name": "Garam Masala", "quantity": "1 tsp"}]',
        'directions':
            '["Heat oil in a wok and sauté ginger-garlic paste for a minute.", "Add tomatoes, spices, and cook until oil separates", "Add fish pieces and gently mix to coat with masala.", "Cover and cook for 10 minutes. Garnish with green chilies."]',
      },
      //10
      {
        'name': 'Murgh Cholay',
        'imageUrl': 'https://example.com/images/smoothie_bowl.jpg',
        'category': 'Lunch',
        'time': 140,
        'serving': 6,
        'ingredients':
            '[{"name": "chicken", "quantity": "1 kg"}, {"name": "boiled chickpeas", "quantity": "1 Cup"}, {"name": " onions (chopped)", "quantity": "2 medium"}, {"name": " tomatoes (chopped)", "quantity": "3 medium"}, {"name": "ginger-garlic paste", "quantity": "2 tsp"}, {"name": " turmeric powder", "quantity": "1 tsp"}, {"name": "Oil", "quantity": "4 tbsp"}, {"name": "Salt", "quantity": "1 tsp"}, {"name": "1 tsp garam masala", "quantity": "1 tsp"}]',
        'directions':
            '["Heat oil in a pot and sauté onions until golden. Add ginger-garlic paste.", "Add chicken and cook until it changes color. Add tomatoes and spices.", "Add water and cook until chicken is tender.", "Add boiled chickpeas, cook for another 5 minutes.", "Sprinkle garam masala and serve."]',
      },
      //Dinner Recipes
      //1
      {
        'name': 'Vegetable Biryani',
        'imageUrl': 'https://example.com/images/vegetable_biryani.jpg',
        'category': 'Dinner',
        'time': 60,
        'serving': 4,
        'ingredients': '[{"name": "Basmati Rice", "quantity": "1 1/2 Cups"}, {"name": "Mixed Vegetables", "quantity": "2 Cups"}, {"name": "Onion", "quantity": "1 large, sliced"}, {"name": "Ginger-Garlic Paste", "quantity": "1 tbsp"}, {"name": "Biryani Masala", "quantity": "2 tbsp"}, {"name": "Yogurt", "quantity": "1/4 Cup"}, {"name": "Coriander Leaves", "quantity": "1/4 Cup, chopped"}, {"name": "Mint Leaves", "quantity": "1/4 Cup, chopped"}, {"name": "Cinnamon Stick", "quantity": "1 inch"}, {"name": "Oil", "quantity": "2 tbsp"}]',
        'directions': '["Heat oil in a pan and sauté onions until golden brown.", "Add ginger-garlic paste and mixed vegetables, cook for 5 minutes.", "Add biryani masala and yogurt, and cook until vegetables are tender.", "Meanwhile, cook basmati rice separately in boiling water with a cinnamon stick.", "Layer the cooked rice and vegetable mixture in a pot, add coriander and mint leaves, and simmer for 15 minutes."]'
    },
    //2
    {
        'name': 'Chicken Curry',
        'imageUrl': 'https://example.com/images/chicken_curry.jpg',
        "category": 'Dinner',
        'time': 45,
        'serving': 4,
        'ingredients': '[{"name": "Chicken", "quantity": "500g, chopped"}, {"name": "Onion", "quantity": "1 large, finely chopped"}, {"name": "Tomato", "quantity": "1, chopped"}, {"name": "Ginger-Garlic Paste", "quantity": "1 tbsp"}, {"name": "Curry Powder", "quantity": "1 1/2 tbsp"}, {"name": "Turmeric Powder", "quantity": "1/2 tsp"}, {"name": "Coriander Powder", "quantity": "1 tsp"}, {"name": "Oil", "quantity": "2 tbsp"}, {"name": "Salt", "quantity": "to taste"}, {"name": "Water", "quantity": "1 Cup"}]',
        'directions': '["Heat oil in a pan and sauté onions until golden brown.", "Add ginger-garlic paste and cook for a minute.", "Add chicken pieces and cook until browned.", "Add tomatoes, curry powder, turmeric, coriander powder, and salt. Cook until tomatoes soften.", "Add water and simmer until chicken is cooked through, about 20 minutes."]'
    },
    //3
    {
        'name': "Paneer Butter Masala",
        'imageUrl': 'https://example.com/images/paneer_butter_masala.jpg',
        'category': 'Dinner',
        'time': 40,
        'serving': 4,
        'ingredients': '[{"name": "Paneer", "quantity": "250g, cubed"}, {"name": "Onion", "quantity": "1 medium, finely chopped"}, {"name": "Tomato", "quantity": "2, pureed"}, {"name": "Ginger-Garlic Paste", "quantity": "1 tbsp"}, {"name": "Butter", "quantity": "2 tbsp"}, {"name": "Heavy Cream", "quantity": "1/4 Cup"}, {"name": "Cumin Powder", "quantity": "1/2 tsp"}, {"name": "Coriander Powder", "quantity": "1 tsp"}, {"name": "Kasuri Methi", "quantity": "1 tsp"}, {"name": "Salt", "quantity": "to taste"}]',
        'directions': '["Heat butter in a pan and sauté onions until golden.", "Add ginger-garlic paste and cook for a minute.", "Add pureed tomatoes, cumin, coriander powder, and salt. Cook until the oil separates.", "Add paneer cubes and cook for 5 minutes.", "Add cream and kasuri methi, simmer for 5 minutes, and serve hot."]'
    },
    //4
    {
        'name': "Chole Bhature",
        'imageUrl': 'https://example.com/images/chole_bhature.jpg',
        'category': 'Dinner',
        'time': 90,
        'serving': 4,
        'ingredients': '[{"name": "Chickpeas", "quantity": "1 Cup, soaked overnight"}, {"name": "Onion", "quantity": "1 large, finely chopped"}, {"name": "Tomato", "quantity": "1, chopped"}, {"name": "Ginger-Garlic Paste", "quantity": "1 tbsp"}, {"name": "Chole Masala", "quantity": "1 1/2 tbsp"}, {"name": "Oil", "quantity": "2 tbsp"}, {"name": "Coriander Leaves", "quantity": "for garnish"}, {"name": "Flour", "quantity": "2 Cups for Bhature"}, {"name": "Baking Powder", "quantity": "1/2 tsp for Bhature"}]',
        'directions': '["Pressure cook chickpeas with water until soft.", "In a pan, heat oil and sauté onions and ginger-garlic paste.", "Add tomatoes, chole masala, and cooked chickpeas. Cook for 15 minutes.", "For Bhature, knead flour, baking powder, and water into a dough. Let it rest.", "Roll out dough and fry into puffy Bhature. Serve with chole."]'
    },
    //5
    {
        'name': "Lamb Rogan Josh",
        'imageUrl': 'https://example.com/images/lamb_rogan_josh.jpg',
        'category': 'Dinner',
        'time': 70,
        'serving': 4,
        'ingredients': '[{"name": "Lamb", "quantity": "500g, chopped"}, {"name": "Yogurt", "quantity": "1/2 Cup"}, {"name": "Onion", "quantity": "1 large, finely chopped"}, {"name": "Ginger-Garlic Paste", "quantity": "1 tbsp"}, {"name": "Garam Masala", "quantity": "1 tbsp"}, {"name": "Red Chili Powder", "quantity": "1 tsp"}, {"name": "Cinnamon Stick", "quantity": "1 inch"}, {"name": "Cloves", "quantity": "3"}, {"name": "Salt", "quantity": "to taste"}, {"name": "Oil", "quantity": "2 tbsp"}]',
        'directions': '["Heat oil in a pan and sauté onions until golden brown.", "Add ginger-garlic paste and lamb pieces. Cook until lamb is browned.", "Add yogurt, garam masala, red chili powder, cinnamon, and cloves. Cook for 5 minutes.", "Add water, cover, and simmer until lamb is tender, about 40 minutes."]'
    },
    //6
    {
        'name': "Fish Curry",
        'imageUrl': 'https://example.com/images/fish_curry.jpg',
        'category': 'Dinner',
        'time': 40,
        'serving': 4,
        'ingredients': '[{"name": "Fish Fillets", "quantity": "500g, cubed"}, {"name": "Onion", "quantity": "1 medium, chopped"}, {"name": "Tomato", "quantity": "1, chopped"}, {"name": "Ginger-Garlic Paste", "quantity": "1 tbsp"}, {"name": "Coriander Powder", "quantity": "1 tsp"}, {"name": "Turmeric Powder", "quantity": "1/2 tsp"}, {"name": "Coconut Milk", "quantity": "1/2 Cup"}, {"name": "Oil", "quantity": "2 tbsp"}, {"name": "Salt", "quantity": "to taste"}]',
        'directions': '["Heat oil in a pan and sauté onions and ginger-garlic paste.", "Add tomatoes, coriander powder, turmeric powder, and salt. Cook until tomatoes soften.", "Add fish cubes and cook for 5 minutes.", "Add coconut milk and simmer for 15 minutes, until fish is cooked."]'
    },
    //7
    {
        'name': "Dal Tadka",
        'imageUrl': 'https://example.com/images/dal_tadka.jpg',
        'category': 'Dinner',
        'time': 30,
        'serving': 4,
        'ingredients': '[{"name": "Toor Dal", "quantity": "1 Cup"}, {"name": "Onion", "quantity": "1 small, chopped"}, {"name": "Tomato", "quantity": "1, chopped"}, {"name": "Ginger-Garlic Paste", "quantity": "1 tsp"}, {"name": "Cumin Seeds", "quantity": "1 tsp"}, {"name": "Ghee", "quantity": "2 tbsp"}, {"name": "Coriander Leaves", "quantity": "for garnish"}, {"name": "Salt", "quantity": "to taste"}]',
        'directions': '["Cook toor dal in water until soft.", "Heat ghee in a pan, add cumin seeds, and sauté onions and ginger-garlic paste.", "Add tomatoes, salt, and cook until soft.", "Add cooked dal, simmer for 10 minutes, and garnish with coriander leaves."]'
    },
    //8
    {
        'name': "Aloo Gobi",
        'imageUrl': 'https://example.com/images/aloo_gobi.jpg',
        'category': 'Dinner',
        'time': 30,
        'serving': 4,
        'ingredients': '[{"name": "Potatoes", "quantity": "2, diced"}, {"name": "Cauliflower", "quantity": "1 small, chopped"}, {"name": "Onion", "quantity": "1 medium, chopped"}, {"name": "Ginger-Garlic Paste", "quantity": "1 tbsp"}, {"name": "Turmeric Powder", "quantity": "1/2 tsp"}, {"name": "Cumin Seeds", "quantity": "1 tsp"}, {"name": "Coriander Powder", "quantity": "1 tsp"}, {"name": "Coriander Leaves", "quantity": "for garnish"}]',
        'directions': '["Heat oil in a pan and sauté cumin seeds and onions.", "Add ginger-garlic paste, potatoes, cauliflower, turmeric, coriander powder, and salt.", "Cook until vegetables are tender. Garnish with coriander leaves."]'
    },
    //9
     {
        "name": "Butter Chicken",
        "imageUrl": "https://example.com/images/butter_chicken.jpg",
        "category": "Main Course",
        "time": 50,
        "serving": 4,
        "ingredients": '[{"name": "Chicken", "quantity": "500g, boneless, chopped"}, {"name": "Onion", "quantity": "1 large, finely chopped"}, {"name": "Tomato Puree", "quantity": "1/2 Cup"}, {"name": "Ginger-Garlic Paste", "quantity": "1 tbsp"}, {"name": "Butter", "quantity": "3 tbsp"}, {"name": "Cream", "quantity": "1/4 Cup"}, {"name": "Kasuri Methi", "quantity": "1 tsp"}, {"name": "Garam Masala", "quantity": "1 tsp"}, {"name": "Coriander Powder", "quantity": "1 tsp"}, {"name": "Salt", "quantity": "to taste"}]',
        "directions": '["Heat butter in a pan, sauté onions until golden.", "Add ginger-garlic paste, cook for a minute, then add chicken pieces.", "Cook chicken until browned, then add tomato puree, garam masala, coriander powder, and salt. Cook for 10 minutes.", "Add cream and kasuri methi, simmer for 5 minutes, and serve hot."]'
    },
    //10
    {
        "name": "Shahi Paneer",
        "imageUrl": "https://example.com/images/shahi_paneer.jpg",
        "category": "Main Course",
        "time": 40,
        "serving": 4,
        "ingredients": '[{"name": "Paneer", "quantity": "250g, cubed"}, {"name": "Onion", "quantity": "1 medium, finely chopped"}, {"name": "Tomato Puree", "quantity": "1/4 Cup"}, {"name": "Cashew Nuts", "quantity": "10-12, soaked"}, {"name": "Cream", "quantity": "1/4 Cup"}, {"name": "Cinnamon Stick", "quantity": "1 inch"}, {"name": "Cloves", "quantity": "2"}, {"name": "Cardamom Pods", "quantity": "2"}, {"name": "Turmeric Powder", "quantity": "1/2 tsp"}, {"name": "Salt", "quantity": "to taste"}]',
        "directions": '["Blend cashews into a smooth paste.", "Heat oil, sauté onions until golden, then add cinnamon, cloves, and cardamom.", "Add tomato puree, turmeric, and salt. Cook for 5 minutes.", "Add cashew paste and cream, cook for another 5 minutes.", "Add paneer cubes, simmer for 5 minutes, and serve."]'
    },
   // Drinks
   //1
      {
        'name': "Mango Juice",
        'imageUrl': 'https://example.com/images/mango_lassi.jpg',
        'category': 'Drink',
        'time': 5,
        'serving': 2,
        'ingredients': '[{"name": "Mango", "quantity": "1 large, peeled and chopped"}, {"name": "Yogurt", "quantity": "1/2 Cup"}, {"name": "Milk", "quantity": "1/2 Cup"}, {"name": "Sugar", "quantity": "2 tbsp"}, {"name": "Cardamom Powder", "quantity": "1/4 tsp"}]',
        'directions': '["Blend mango, yogurt, milk, sugar, and cardamom powder until smooth.", "Serve chilled in glasses."]'
    },
    //2
    {
        'name': "Masala Chai",
        'imageUrl': 'https://example.com/images/masala_chai.jpg',
        'category': 'Drink',
        'time': 15,
        'serving': 2,
        'ingredients': '[{"name": "Black Tea Leaves", "quantity": "2 tsp"}, {"name": "Water", "quantity": "1 Cup"}, {"name": "Milk", "quantity": "1 Cup"}, {"name": "Sugar", "quantity": "2 tsp"}, {"name": "Cardamom Pods", "quantity": "3"}, {"name": "Cloves", "quantity": "2"}, {"name": "Cinnamon Stick", "quantity": "1 inch"}]',
        'directions': '["Boil water with cardamom, cloves, and cinnamon.", "Add tea leaves and simmer for 2-3 minutes.", "Add milk and sugar, simmer for another 3-4 minutes.", "Strain and serve hot."]'
    },
    //3
    {
        'name': "Fresh Lemonade",
        'imageUrl': 'https://example.com/images/fresh_lemonade.jpg',
        'category': 'Drink',
        'time': 5,
        'serving': 2,
        'ingredients': '[{"name": "Lemon", "quantity": "2, juiced"}, {"name": "Sugar", "quantity": "2 tbsp"}, {"name": "Water", "quantity": "1 1/2 Cups"}, {"name": "Mint Leaves", "quantity": "a few for garnish"}]',
        'directions': '["Mix lemon juice, sugar, and water until sugar dissolves.", "Serve over ice and garnish with mint leaves."]'
    },
    //4
    {
        'name': "Cold Coffee",
        'imageUrl': 'https://example.com/images/cold_coffee.jpg',
        'category': 'Drink',
        'time': 10,
        'serving': 2,
        'ingredients': '[{"name": "Instant Coffee Powder", "quantity": "1 tbsp"}, {"name": "Milk", "quantity": "1 Cup"}, {"name": "Sugar", "quantity": "2 tbsp"}, {"name": "Ice Cubes", "quantity": "a handful"}]',
        'directions': '["Dissolve coffee powder and sugar in warm milk.", "Let it cool, then blend with ice cubes.", "Serve chilled."]'
    },
    //5
    {
        'name': "Pineapple Juice",
        'imageUrl': 'https://example.com/images/pineapple_juice.jpg',
        'category': 'Drink',
        'time': 5,
        'serving': 2,
        'ingredients': '[{"name": "Pineapple", "quantity": "1 Cup, chopped"}, {"name": "Water", "quantity": "1/2 Cup"}, {"name": "Sugar", "quantity": "1 tbsp"}]',
        'directions': '["Blend pineapple, water, and sugar until smooth.", "Strain and serve chilled."]'
    },
    //6
    {
        'name': "Coconut Water Smoothie",
        'imageUrl': 'https://example.com/images/coconut_water_smoothie.jpg',
        'category': 'Drink',
        'time': 5,
        'serving': 2,
        'ingredients': '[{"name": "Coconut Water", "quantity": "1 Cup"}, {"name": "Banana", "quantity": "1, chopped"}, {"name": "Honey", "quantity": "1 tbsp"}]',
        'directions': '["Blend coconut water, banana, and honey until smooth.", "Serve immediately."]'
    },
    //7
    {
        'name': "Watermelon Juice",
        'imageUrl': "https://example.com/images/watermelon_juice.jpg",
        'category': "Drink",
        'time': 5,
        'serving': 2,
        'ingredients': '[{"name": "Watermelon", "quantity": "2 Cups, chopped"}, {"name": "Lemon Juice", "quantity": "1 tbsp"}, {"name": "Mint Leaves", "quantity": "a few"}]',
        'directions': '["Blend watermelon and lemon juice until smooth.", "Serve over ice and garnish with mint leaves."]'
    },

     //8
    {
        'name': "Iced Tea",
        'imageUrl': 'https://example.com/images/iced_tea.jpg',
        'category': 'Drink',
        'time': 10,
        'serving': 2,
        'ingredients': '[{"name": "Black Tea Bags", "quantity": "2"}, {"name": "Water", "quantity": "1 Cup, boiled"}, {"name": "Lemon", "quantity": "1, sliced"}, {"name": "Sugar", "quantity": "2 tbsp"}, {"name": "Ice Cubes", "quantity": "a handful"}]',
        'directions': '["Steep tea bags in hot water for 5 minutes.", "Add sugar and stir to dissolve.", "Let it cool, then pour over ice and garnish with lemon slices."]'
    },
    //9
    {
        'name': 'Apple Cider Vinegar Drink',
        'imageUrl': 'https://example.com/images/apple_cider_vinegar_drink.jpg',
        'category': 'Drink',
        'time': 5,
        'serving': 1,
        'ingredients': '[{"name": "Apple Cider Vinegar", "quantity": "1 tbsp"}, {"name": "Honey", "quantity": "1 tbsp"}, {"name": "Water", "quantity": "1 Cup"}]',
        'directions': '["Mix apple cider vinegar, honey, and water.", "Serve chilled or at room temperature."]'
    },
    //10
    {
        'name': "Carrot Juice",
        'imageUrl': 'https://example.com/images/carrot_juice.jpg',
        'category': 'Drink',
        'time': 10,
        'serving': 2,
        'ingredients': '[{"name": "Carrot", "quantity": "2, peeled and chopped"}, {"name": "Orange Juice", "quantity": "1/2 Cup"}, {"name": "Ginger", "quantity": "1 tsp, grated"}]',
        'directions': '["Blend carrots, orange juice, and ginger until smooth.", "Strain and serve chilled."]'
    }

    ];

    for (var recipe in recipes) {
      await db.insert('recipes', recipe);
    }
  }

  // Fetch all recipes from the database
  Future<List<Map<String, dynamic>>> getRecipes() async {
    final db = await database;
    return await db.query('recipes');
  }

  // Fetch recipes by category
  Future<List<Map<String, dynamic>>> getRecipesByCategory(
      String category) async {
    final db = await database;
    return await db
        .query('recipes', where: 'category = ?', whereArgs: [category]);
  }
}