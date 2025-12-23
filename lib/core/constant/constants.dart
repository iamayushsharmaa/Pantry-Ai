import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../shared/models/recipe/recipe.dart';

class Constants {
  static String get geminiApiKey {
    final key = dotenv.env['GEMINI_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('GEMINI_API_KEY not found in .env');
    }
    return key;
  }

  static String get geminiApiUrl =>
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$geminiApiKey";

  static final List<Recipe> dummyRecipeList = [
    Recipe(
      id: "r1",
      title: "Creamy Garlic Chicken Pasta",
      description:
          "A rich and creamy garlic parmesan chicken pasta perfect for dinner.",
      imageUrl: "https://images.unsplash.com/photo-1607116342924-80b005a4f3c3",
      cookingTime: 20,
      prepTime: 10,
      difficulty: 2,
      servings: 2,
      cuisine: "Italian",
      dietaryInfo: ["High-Protein"],
      rating: 4.6,
      calories: 620,
      nutrition: NutritionInfo(protein: 32, carbs: 55, fat: 28, fiber: 3),
      ingredients: [
        Ingredient(
          id: "i1",
          name: "Chicken Breast",
          quantity: 200,
          unit: "g",
          isAvailable: true,
        ),
        Ingredient(
          id: "i2",
          name: "Pasta",
          quantity: 150,
          unit: "g",
          isAvailable: true,
        ),
        Ingredient(
          id: "i3",
          name: "Garlic",
          quantity: 3,
          unit: "cloves",
          isAvailable: true,
        ),
        Ingredient(
          id: "i4",
          name: "Parmesan",
          quantity: 50,
          unit: "g",
          isAvailable: false,
        ),
      ],
      missingIngredients: ["Parmesan"],
      instructions: [
        "Boil pasta until al dente.",
        "Cook chicken in butter.",
        "Add garlic and cream.",
        "Mix pasta with sauce.",
        "Top with parmesan.",
      ],
      tags: ["Dinner", "Pasta"],
    ),

    // -------------------------------------------------------------
    // 2. Veggie Avocado Salad Bowl
    // -------------------------------------------------------------
    Recipe(
      id: "r2",
      title: "Veggie Avocado Salad Bowl",
      description:
          "Fresh and healthy salad filled with greens, avocado, and tomatoes.",
      imageUrl: "https://images.unsplash.com/photo-1550304943-4f24f54ddde9",
      cookingTime: 0,
      prepTime: 15,
      difficulty: 1,
      servings: 1,
      cuisine: "American",
      dietaryInfo: ["Vegan", "Gluten-Free"],
      rating: 4.8,
      calories: 350,
      nutrition: NutritionInfo(protein: 8, carbs: 28, fat: 22, fiber: 7),
      ingredients: [
        Ingredient(
          id: "i5",
          name: "Lettuce",
          quantity: 2,
          unit: "cups",
          isAvailable: true,
        ),
        Ingredient(
          id: "i6",
          name: "Avocado",
          quantity: 1,
          unit: "whole",
          isAvailable: false,
        ),
        Ingredient(
          id: "i7",
          name: "Cherry Tomatoes",
          quantity: 1,
          unit: "cup",
          isAvailable: true,
        ),
        Ingredient(
          id: "i8",
          name: "Cucumber",
          quantity: 0.5,
          unit: "piece",
          isAvailable: true,
        ),
      ],
      missingIngredients: ["Avocado"],
      instructions: [
        "Chop all vegetables.",
        "Mix in a bowl.",
        "Drizzle olive oil.",
        "Add salt & pepper.",
      ],
      tags: ["Healthy", "Salad", "Vegan"],
    ),

    // -------------------------------------------------------------
    // 3. Classic Margherita Pizza
    // -------------------------------------------------------------
    Recipe(
      id: "r3",
      title: "Classic Margherita Pizza",
      description: "A simple Italian pizza with tomato, mozzarella & basil.",
      imageUrl: "https://images.unsplash.com/photo-1548365328-76bc3997d9ea",
      cookingTime: 15,
      prepTime: 20,
      difficulty: 2,
      servings: 2,
      cuisine: "Italian",
      dietaryInfo: ["Vegetarian"],
      rating: 4.7,
      calories: 680,
      nutrition: NutritionInfo(protein: 25, carbs: 70, fat: 30, fiber: 4),
      ingredients: [
        Ingredient(
          id: "i9",
          name: "Pizza Dough",
          quantity: 1,
          unit: "base",
          isAvailable: true,
        ),
        Ingredient(
          id: "i10",
          name: "Mozzarella",
          quantity: 150,
          unit: "g",
          isAvailable: false,
        ),
        Ingredient(
          id: "i11",
          name: "Tomato Sauce",
          quantity: 0.5,
          unit: "cup",
          isAvailable: true,
        ),
        Ingredient(
          id: "i12",
          name: "Basil",
          quantity: 10,
          unit: "leaves",
          isAvailable: true,
        ),
      ],
      missingIngredients: ["Mozzarella"],
      instructions: [
        "Spread tomato sauce on dough.",
        "Add mozzarella slices.",
        "Bake at 240°C for 12–15 minutes.",
        "Add basil before serving.",
      ],
      tags: ["Pizza", "Vegetarian"],
    ),

    // -------------------------------------------------------------
    // 4. Spicy Ramen Bowl
    // -------------------------------------------------------------
    Recipe(
      id: "r4",
      title: "Spicy Ramen Bowl",
      description:
          "A comforting spicy ramen with noodles, eggs & flavorful broth.",
      imageUrl: "https://images.unsplash.com/photo-1604908176941-436a2b0a8c24",
      cookingTime: 15,
      prepTime: 10,
      difficulty: 3,
      servings: 1,
      cuisine: "Japanese",
      dietaryInfo: ["High-Protein"],
      rating: 4.5,
      calories: 540,
      nutrition: NutritionInfo(protein: 18, carbs: 65, fat: 20, fiber: 3),
      ingredients: [
        Ingredient(
          id: "i13",
          name: "Ramen Noodles",
          quantity: 1,
          unit: "pack",
          isAvailable: true,
        ),
        Ingredient(
          id: "i14",
          name: "Egg",
          quantity: 1,
          unit: "whole",
          isAvailable: true,
        ),
        Ingredient(
          id: "i15",
          name: "Chili Paste",
          quantity: 1,
          unit: "tbsp",
          isAvailable: false,
        ),
        Ingredient(
          id: "i16",
          name: "Broth",
          quantity: 2,
          unit: "cups",
          isAvailable: true,
        ),
      ],
      missingIngredients: ["Chili Paste"],
      instructions: [
        "Boil the noodles.",
        "Prepare broth with chili paste.",
        "Add noodles to broth.",
        "Top with boiled egg.",
        "Garnish with spring onion.",
      ],
      tags: ["Ramen", "Spicy", "Comfort Food"],
    ),

    // -------------------------------------------------------------
    // 5. Chocolate Chip Pancakes
    // -------------------------------------------------------------
    Recipe(
      id: "r5",
      title: "Chocolate Chip Pancakes",
      description: "Fluffy breakfast pancakes filled with chocolate chips.",
      imageUrl: "https://images.unsplash.com/photo-1554104707-8237e0a1f1a4",
      cookingTime: 10,
      prepTime: 10,
      difficulty: 1,
      servings: 2,
      cuisine: "American",
      dietaryInfo: ["Vegetarian"],
      rating: 4.9,
      calories: 520,
      nutrition: NutritionInfo(protein: 10, carbs: 75, fat: 18, fiber: 2),
      ingredients: [
        Ingredient(
          id: "i17",
          name: "Flour",
          quantity: 1,
          unit: "cup",
          isAvailable: true,
        ),
        Ingredient(
          id: "i18",
          name: "Milk",
          quantity: 1,
          unit: "cup",
          isAvailable: true,
        ),
        Ingredient(
          id: "i19",
          name: "Chocolate Chips",
          quantity: 0.5,
          unit: "cup",
          isAvailable: false,
        ),
        Ingredient(
          id: "i20",
          name: "Egg",
          quantity: 1,
          unit: "whole",
          isAvailable: true,
        ),
      ],
      missingIngredients: ["Chocolate Chips"],
      instructions: [
        "Mix flour, milk, and egg.",
        "Add chocolate chips.",
        "Cook on medium heat.",
        "Serve with maple syrup.",
      ],
      tags: ["Breakfast", "Sweet"],
    ),

    // -------------------------------------------------------------
    // 6. Grilled Lemon Herb Salmon
    // -------------------------------------------------------------
    Recipe(
      id: "r6",
      title: "Grilled Lemon Herb Salmon",
      description: "A light and flavorful salmon served with herbs & lemon.",
      imageUrl: "https://images.unsplash.com/photo-1617196034692-0f9c2c783fa5",
      cookingTime: 12,
      prepTime: 8,
      difficulty: 2,
      servings: 2,
      cuisine: "Mediterranean",
      dietaryInfo: ["Keto", "High-Protein", "Gluten-Free"],
      rating: 4.7,
      calories: 430,
      nutrition: NutritionInfo(protein: 34, carbs: 3, fat: 28, fiber: 1),
      ingredients: [
        Ingredient(
          id: "i21",
          name: "Salmon Fillet",
          quantity: 2,
          unit: "pieces",
          isAvailable: true,
        ),
        Ingredient(
          id: "i22",
          name: "Lemon",
          quantity: 1,
          unit: "whole",
          isAvailable: true,
        ),
        Ingredient(
          id: "i23",
          name: "Olive Oil",
          quantity: 2,
          unit: "tbsp",
          isAvailable: true,
        ),
        Ingredient(
          id: "i24",
          name: "Garlic",
          quantity: 2,
          unit: "cloves",
          isAvailable: false,
        ),
      ],
      missingIngredients: ["Garlic"],
      instructions: [
        "Marinate salmon with lemon, garlic & herbs.",
        "Grill for 5–6 minutes per side.",
        "Serve hot.",
      ],
      tags: ["Seafood", "Healthy"],
    ),
  ];
}
