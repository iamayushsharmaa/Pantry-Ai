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
}

final fakeRecipes = [
  Recipe(
    title: "Creamy Garlic Pasta",
    imageUrl:
        "https://images.unsplash.com/photo-1603133872878-684f88c52b2b?w=800",
    cookingTime: 20,
    difficulty: 2,
    ingredients: [
      Ingredient(name: "Pasta", quantity: 200, unit: "g", isAvailable: true),
      Ingredient(
        name: "Garlic",
        quantity: 3,
        unit: "cloves",
        isAvailable: true,
      ),
      Ingredient(name: "Cream", quantity: 100, unit: "ml", isAvailable: false),
    ],
    missingIngredients: ["Cream"],
    instructions: ["Boil pasta", "Sauté garlic", "Add cream and mix"],
  ),

  Recipe(
    title: "Veg Loaded Sandwich",
    imageUrl: "https://images.unsplash.com/photo-1552332386-f8dd00dc2f85?w=800",
    cookingTime: 10,
    difficulty: 1,
    ingredients: [
      Ingredient(name: "Bread", quantity: 2, unit: "slices", isAvailable: true),
      Ingredient(name: "Tomato", quantity: 1, unit: "pc", isAvailable: true),
      Ingredient(
        name: "Cheese",
        quantity: 1,
        unit: "slice",
        isAvailable: false,
      ),
    ],
    missingIngredients: ["Cheese"],
    instructions: ["Toast bread", "Layer veggies", "Add cheese"],
  ),

  Recipe(
    title: "Spicy Paneer Stir-Fry",
    imageUrl:
        "https://images.unsplash.com/photo-1603898037225-1c03b189d96d?w=800",
    cookingTime: 15,
    difficulty: 3,
    ingredients: [
      Ingredient(name: "Paneer", quantity: 150, unit: "g", isAvailable: true),
      Ingredient(name: "Capsicum", quantity: 1, unit: "pc", isAvailable: false),
      Ingredient(
        name: "Chili Sauce",
        quantity: 2,
        unit: "tbsp",
        isAvailable: true,
      ),
    ],
    missingIngredients: ["Capsicum"],
    instructions: ["Cut paneer", "Stir fry with veggies", "Add sauces"],
  ),

  Recipe(
    title: "Chocolate Banana Smoothie",
    imageUrl:
        "https://images.unsplash.com/photo-1587731284031-90178659b097?w=800",
    cookingTime: 5,
    difficulty: 1,
    ingredients: [
      Ingredient(name: "Banana", quantity: 1, unit: "pc", isAvailable: true),
      Ingredient(name: "Milk", quantity: 200, unit: "ml", isAvailable: true),
      Ingredient(
        name: "Cocoa Powder",
        quantity: 1,
        unit: "tbsp",
        isAvailable: false,
      ),
    ],
    missingIngredients: ["Cocoa Powder"],
    instructions: ["Peel banana", "Blend with milk", "Add cocoa"],
  ),

  Recipe(
    title: "Crispy Aloo Tikki",
    imageUrl:
        "https://images.unsplash.com/photo-1622227922681-7dd70da09b9d?w=800",
    cookingTime: 25,
    difficulty: 2,
    ingredients: [
      Ingredient(name: "Potato", quantity: 2, unit: "pcs", isAvailable: true),
      Ingredient(
        name: "Bread Crumbs",
        quantity: 50,
        unit: "g",
        isAvailable: false,
      ),
      Ingredient(name: "Spices", quantity: 2, unit: "tsp", isAvailable: true),
    ],
    missingIngredients: ["Bread Crumbs"],
    instructions: ["Boil potatoes", "Mix spices", "Shallow fry"],
  ),
];
