import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../features/recipe_suggestions/domain/enities/ingredient_entity.dart';
import '../../features/recipe_suggestions/domain/enities/recipe_entity.dart';

class Constants {
  static final GEMINI_API_KEY = dotenv.env['GEMINI_API_KEY'];

  static final GEMINI_API_URL =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$GEMINI_API_KEY";

  static const prompt = ''' 
  You are PantryAI, an intelligent cooking assistant.

User will upload an image of groceries they currently have.  
You must:

1. Identify all visible ingredients in the image.  
2. Combine this with user preferences (below) to generate personalized recipe_suggestions.

User Taste Preferences:
- Taste: {{taste}}
- Cuisine: {{cuisine}}
- Diet type: {{diet}}
- Max cooking time: {{maxCookingTime}} minutes

Your Task:
- Generate 3–5 recipe_suggestions based on ingredients + user preferences.
- Respect dietary restrictions.
- Respect taste profile (spicy, mild, sweet, savory, etc.).
- Respect cuisine preference when possible.
- Do NOT use ingredients that violate diet type.
- Keep recipe simple and realistic.

For each recipe include:
- id (unique)
- title
- imageUrl (royalty-free image)
- cookingTime (minutes)
- difficulty (1–5)
- ingredients: 
    - name
    - quantity (optional)
    - unit (optional)
    - isAvailable: true/false
- missingIngredients: list of missing items only
- instructions: step-by-step

Return output **ONLY in strict JSON**, using this schema:

{
  "detectedIngredients": ["string"],
  "recipe_suggestions": [
    {
      "id": "string",
      "title": "string",
      "imageUrl": "string",
      "cookingTime": 0,
      "difficulty": 1,
      "ingredients": [
        {
          "name": "string",
          "quantity": 0,
          "unit": "string",
          "isAvailable": true
        }
      ],
      "missingIngredients": ["string"],
      "instructions": ["step 1", "step 2", "..."]
    }
  ]
}
''';

  static final recentRecipes = [
    {
      'title': 'Pasta Carbonara',
      'cookTime': '25 min',
      'difficulty': 'Medium',
      'imageUrl': null,
    },
    {
      'title': 'Chicken Stir Fry',
      'cookTime': '20 min',
      'difficulty': 'Easy',
      'imageUrl': null,
    },
    {
      'title': 'Beef Wellington',
      'cookTime': '90 min',
      'difficulty': 'Hard',
      'imageUrl': null,
    },
    {
      'title': 'Margherita Pizza',
      'cookTime': '30 min',
      'difficulty': 'Easy',
      'imageUrl': null,
    },
    {
      'title': 'Thai Green Curry',
      'cookTime': '35 min',
      'difficulty': 'Medium',
      'imageUrl': null,
    },
  ];

  static final dummyQuickRecipes = [
    {
      'title': 'Avocado Toast',
      'cookTime': '10 min',
      'difficulty': 'Easy',
      'imageUrl': null,
    },
    {
      'title': 'Egg Fried Rice',
      'cookTime': '15 min',
      'difficulty': 'Easy',
      'imageUrl': null,
    },
    {
      'title': 'Caprese Salad',
      'cookTime': '8 min',
      'difficulty': 'Easy',
      'imageUrl': null,
    },
    {
      'title': 'Grilled Cheese',
      'cookTime': '12 min',
      'difficulty': 'Easy',
      'imageUrl': null,
    },
    {
      'title': 'Veggie Wrap',
      'cookTime': '10 min',
      'difficulty': 'Easy',
      'imageUrl': null,
    },
  ];
}

final List<Recipe> dummyRecipes = [
  Recipe(
    title: "Classic Spaghetti Carbonara",
    imageUrl:
        "https://images.unsplash.com/photo-1612874742237-6526221588e3?w=800",
    cookingTime: 25,
    difficulty: 2,
    rating: 4.7,
    calories: 580,
    servings: 4,
    description:
        "A traditional Italian pasta dish made with eggs, cheese, pancetta, and black pepper. Creamy, comforting, and absolutely delicious.",
    cuisine: "Italian",
    dietaryInfo: null,
    ingredients: [
      Ingredient(
        name: "Spaghetti",
        quantity: 400,
        unit: "g",
        isAvailable: true,
      ),
      Ingredient(name: "Eggs", quantity: 4, unit: "pieces", isAvailable: true),
      Ingredient(
        name: "Parmesan cheese",
        quantity: 100,
        unit: "g",
        isAvailable: true,
      ),
      Ingredient(
        name: "Pancetta",
        quantity: 200,
        unit: "g",
        isAvailable: false,
      ),
      Ingredient(
        name: "Black pepper",
        quantity: 1,
        unit: "tsp",
        isAvailable: true,
      ),
      Ingredient(name: "Salt", quantity: 1, unit: "tsp", isAvailable: true),
      Ingredient(
        name: "Olive oil",
        quantity: 2,
        unit: "tbsp",
        isAvailable: true,
      ),
    ],
    missingIngredients: ["Pancetta"],
    instructions: [
      "Bring a large pot of salted water to boil and cook spaghetti according to package directions until al dente.",
      "While pasta cooks, dice the pancetta and fry in a large pan over medium heat until crispy, about 5-7 minutes.",
      "In a bowl, whisk together eggs, grated Parmesan cheese, and freshly ground black pepper.",
      "Reserve 1 cup of pasta water, then drain the spaghetti.",
      "Remove the pan from heat and add the hot pasta to the pancetta, tossing to combine.",
      "Pour the egg mixture over the pasta, tossing quickly to create a creamy sauce. Add pasta water as needed to achieve desired consistency.",
      "Serve immediately with extra Parmesan and black pepper on top.",
    ],
  ),
  Recipe(
    title: "Thai Green Curry",
    imageUrl:
        "https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=800",
    cookingTime: 35,
    difficulty: 3,
    rating: 4.9,
    calories: 420,
    servings: 4,
    description:
        "Aromatic and spicy Thai curry with vegetables and your choice of protein, simmered in creamy coconut milk.",
    cuisine: "Thai",
    dietaryInfo: ["Gluten-Free", "Can be Vegan"],
    ingredients: [
      Ingredient(
        name: "Green curry paste",
        quantity: 3,
        unit: "tbsp",
        isAvailable: true,
      ),
      Ingredient(
        name: "Coconut milk",
        quantity: 400,
        unit: "ml",
        isAvailable: true,
      ),
      Ingredient(
        name: "Chicken breast",
        quantity: 500,
        unit: "g",
        isAvailable: true,
      ),
      Ingredient(
        name: "Bell peppers",
        quantity: 2,
        unit: "pieces",
        isAvailable: true,
      ),
      Ingredient(
        name: "Thai basil",
        quantity: 1,
        unit: "cup",
        isAvailable: false,
      ),
      Ingredient(
        name: "Fish sauce",
        quantity: 2,
        unit: "tbsp",
        isAvailable: true,
      ),
      Ingredient(
        name: "Brown sugar",
        quantity: 1,
        unit: "tbsp",
        isAvailable: true,
      ),
      Ingredient(
        name: "Bamboo shoots",
        quantity: 200,
        unit: "g",
        isAvailable: false,
      ),
    ],
    missingIngredients: ["Thai basil", "Bamboo shoots"],
    instructions: [
      "Heat 2 tablespoons of coconut cream in a wok or large pan over medium-high heat.",
      "Add green curry paste and fry for 2-3 minutes until fragrant and oil separates.",
      "Add sliced chicken and stir-fry until it turns white on the outside.",
      "Pour in the remaining coconut milk and bring to a gentle simmer.",
      "Add bell peppers, bamboo shoots, fish sauce, and brown sugar. Simmer for 10-15 minutes.",
      "Taste and adjust seasoning as needed. The curry should be balanced between spicy, sweet, and salty.",
      "Stir in Thai basil leaves just before serving.",
      "Serve hot with steamed jasmine rice.",
    ],
  ),
  Recipe(
    title: "Avocado Toast Supreme",
    imageUrl:
        "https://images.unsplash.com/photo-1588137378633-dea1336ce1e2?w=800",
    cookingTime: 10,
    difficulty: 1,
    rating: 4.3,
    calories: 320,
    servings: 2,
    description:
        "A quick and nutritious breakfast featuring perfectly mashed avocado on crispy sourdough toast, topped with poached eggs and microgreens.",
    cuisine: "American",
    dietaryInfo: ["Vegetarian", "High Protein"],
    ingredients: [
      Ingredient(
        name: "Sourdough bread",
        quantity: 2,
        unit: "slices",
        isAvailable: true,
      ),
      Ingredient(
        name: "Ripe avocados",
        quantity: 2,
        unit: "pieces",
        isAvailable: true,
      ),
      Ingredient(name: "Eggs", quantity: 2, unit: "pieces", isAvailable: true),
      Ingredient(
        name: "Cherry tomatoes",
        quantity: 6,
        unit: "pieces",
        isAvailable: true,
      ),
      Ingredient(
        name: "Microgreens",
        quantity: 0.5,
        unit: "cup",
        isAvailable: false,
      ),
      Ingredient(
        name: "Lemon juice",
        quantity: 1,
        unit: "tbsp",
        isAvailable: true,
      ),
      Ingredient(
        name: "Red pepper flakes",
        quantity: 0.5,
        unit: "tsp",
        isAvailable: true,
      ),
      Ingredient(
        name: "Sea salt",
        quantity: 0.5,
        unit: "tsp",
        isAvailable: true,
      ),
    ],
    missingIngredients: ["Microgreens"],
    instructions: [
      "Toast the sourdough bread slices until golden and crispy.",
      "While bread toasts, bring a pot of water to a gentle simmer for poaching eggs.",
      "Mash avocados in a bowl with lemon juice, salt, and pepper until smooth but still chunky.",
      "Crack eggs into the simmering water and poach for 3-4 minutes for runny yolks.",
      "Spread the mashed avocado generously on the toasted bread.",
      "Top with poached eggs, halved cherry tomatoes, and microgreens.",
      "Sprinkle with red pepper flakes, sea salt, and a drizzle of olive oil.",
      "Serve immediately while toast is still warm.",
    ],
  ),
  Recipe(
    title: "Beef Tacos with Salsa Verde",
    imageUrl:
        "https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=800",
    cookingTime: 30,
    difficulty: 2,
    rating: 4.8,
    calories: 450,
    servings: 4,
    description:
        "Juicy seasoned beef in soft corn tortillas, topped with fresh salsa verde, cilantro, and lime.",
    cuisine: "Mexican",
    dietaryInfo: ["Gluten-Free"],
    ingredients: [
      Ingredient(
        name: "Ground beef",
        quantity: 500,
        unit: "g",
        isAvailable: true,
      ),
      Ingredient(
        name: "Corn tortillas",
        quantity: 12,
        unit: "pieces",
        isAvailable: true,
      ),
      Ingredient(name: "Onion", quantity: 1, unit: "piece", isAvailable: true),
      Ingredient(
        name: "Garlic",
        quantity: 3,
        unit: "cloves",
        isAvailable: true,
      ),
      Ingredient(name: "Cumin", quantity: 2, unit: "tsp", isAvailable: true),
      Ingredient(
        name: "Tomatillos",
        quantity: 500,
        unit: "g",
        isAvailable: false,
      ),
      Ingredient(
        name: "Fresh cilantro",
        quantity: 1,
        unit: "cup",
        isAvailable: true,
      ),
      Ingredient(name: "Lime", quantity: 2, unit: "pieces", isAvailable: true),
      Ingredient(
        name: "Jalapeño",
        quantity: 1,
        unit: "piece",
        isAvailable: false,
      ),
    ],
    missingIngredients: ["Tomatillos", "Jalapeño"],
    instructions: [
      "Dice onion and mince garlic. Sauté in a large pan until softened.",
      "Add ground beef and cook until browned, breaking it up as it cooks.",
      "Season with cumin, chili powder, salt, and pepper. Set aside.",
      "For salsa verde: blend tomatillos, jalapeño, garlic, cilantro, and lime juice until smooth.",
      "Warm corn tortillas in a dry pan or over an open flame.",
      "Fill each tortilla with beef mixture.",
      "Top with salsa verde, diced onions, cilantro, and a squeeze of lime.",
      "Serve with additional lime wedges and hot sauce on the side.",
    ],
  ),
  Recipe(
    title: "Mushroom Risotto",
    imageUrl:
        "https://images.unsplash.com/photo-1476124369491-b79d916b7f8c?w=800",
    cookingTime: 45,
    difficulty: 4,
    rating: 4.6,
    calories: 380,
    servings: 4,
    description:
        "Creamy Italian rice dish with sautéed mushrooms, white wine, and Parmesan cheese. Requires patience but worth every minute.",
    cuisine: "Italian",
    dietaryInfo: ["Vegetarian"],
    ingredients: [
      Ingredient(
        name: "Arborio rice",
        quantity: 300,
        unit: "g",
        isAvailable: true,
      ),
      Ingredient(
        name: "Mixed mushrooms",
        quantity: 400,
        unit: "g",
        isAvailable: true,
      ),
      Ingredient(
        name: "Vegetable stock",
        quantity: 1.5,
        unit: "L",
        isAvailable: true,
      ),
      Ingredient(
        name: "White wine",
        quantity: 150,
        unit: "ml",
        isAvailable: false,
      ),
      Ingredient(name: "Onion", quantity: 1, unit: "piece", isAvailable: true),
      Ingredient(
        name: "Parmesan cheese",
        quantity: 100,
        unit: "g",
        isAvailable: true,
      ),
      Ingredient(name: "Butter", quantity: 50, unit: "g", isAvailable: true),
      Ingredient(
        name: "Thyme",
        quantity: 3,
        unit: "sprigs",
        isAvailable: false,
      ),
    ],
    missingIngredients: ["White wine", "Fresh thyme"],
    instructions: [
      "Keep vegetable stock warm in a separate pot over low heat.",
      "Sauté sliced mushrooms in butter until golden, then set aside.",
      "In the same pan, cook diced onion until translucent.",
      "Add arborio rice and toast for 2 minutes, stirring constantly.",
      "Pour in white wine and stir until absorbed.",
      "Add stock one ladle at a time, stirring frequently. Wait until liquid is absorbed before adding more.",
      "Continue this process for 20-25 minutes until rice is creamy and al dente.",
      "Stir in mushrooms, butter, Parmesan, and thyme. Season with salt and pepper.",
      "Let rest for 2 minutes, then serve immediately with extra Parmesan on top.",
    ],
  ),
];
