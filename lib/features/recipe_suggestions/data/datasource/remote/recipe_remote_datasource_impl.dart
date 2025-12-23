import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pantry_ai/core/constant/constants.dart';
import 'package:pantry_ai/features/recipe_suggestions/data/datasource/remote/recipe_remote_datasource.dart';

import '../../../../../shared/models/recipe/recipe_model.dart';
import '../../../../../shared/models/recipe/taste_preference.dart';
import '../../utils/prompt_builder.dart';

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final Dio dio;

  RecipeRemoteDataSourceImpl(this.dio);

  @override
  Future<List<RecipeModel>> generateRecipes(
    String imagePath,
    TastePreferences prefs,
    List<RecipeModel>? previouslySuggestedRecipes,
  ) async {
    final prompt = buildPrompt(prefs, oldRecipes: previouslySuggestedRecipes);

    final imageBytes = await File(imagePath).readAsBytes();

    final body = {
      "contents": [
        {
          "parts": [
            {"text": prompt},
            {
              "inline_data": {
                "mime_type": "image/jpeg",
                "data": base64Encode(imageBytes),
              },
            },
          ],
        },
      ],
    };

    final response = await dio.post(
      Constants.geminiApiUrl,
      data: body,
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    final candidates = response.data?['candidates'];
    if (candidates == null || candidates.isEmpty) {
      throw Exception('No candidates returned from Gemini');
    }

    final parts = candidates[0]['content']?['parts'] as List<dynamic>?;

    if (parts == null || parts.isEmpty) {
      throw Exception('No parts returned from Gemini');
    }

    final textPart = parts.cast<Map<String, dynamic>>().firstWhere(
      (p) => p.containsKey('text'),
      orElse: () => {},
    );

    final text = textPart['text'];
    if (text == null) {
      throw Exception('No text response from Gemini');
    }

    late final Map<String, dynamic> jsonData;
    try {
      jsonData = jsonDecode(text);
    } catch (_) {
      throw Exception('Invalid JSON returned from Gemini');
    }

    final recipes = jsonData['recipe_suggestions'];
    if (recipes is! List) {
      throw Exception('recipe_suggestions is not a list');
    }

    return recipes.map((e) => RecipeModel.fromJson(e)).toList();
  }
}
