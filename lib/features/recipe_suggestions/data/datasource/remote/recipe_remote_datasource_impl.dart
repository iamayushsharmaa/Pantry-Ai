import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pantry_ai/core/constant/constants.dart';
import 'package:pantry_ai/features/recipe_suggestions/data/datasource/remote/recipe_remote_datasource.dart';

import '../../../domain/enities/taste_preference_entity.dart';
import '../../models/recipe_model.dart';
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
      Constants.GEMINI_API_URL,
      data: jsonEncode(body),
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    final text = response.data["candidates"][0]["content"]["parts"][0]["text"];
    final jsonData = jsonDecode(text);

    return (jsonData["recipe_suggestions"] as List)
        .map((e) => RecipeModel.fromJson(e))
        .toList();
  }
}
