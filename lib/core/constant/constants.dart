import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../shared/models/recipe/recipe.dart';

class Constants {
  static final GEMINI_API_KEY = dotenv.env['GEMINI_API_KEY'];

  static final GEMINI_API_URL =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$GEMINI_API_KEY";


  static final dummyRecipeList = [



  ];
}
