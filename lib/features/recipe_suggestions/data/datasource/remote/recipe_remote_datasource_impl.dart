import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
    try {
      debugPrint('📡 Calling Gemini API...');
      debugPrint('   URL: ${Constants.geminiApiUrl}');

      final response = await dio.post(
        Constants.geminiApiUrl,
        data: body,
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      debugPrint('📬 Response status: ${response.statusCode}');
      debugPrint('📬 Response data: ${response.data}');

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

      String? rawText = textPart['text'] as String?;
      if (rawText == null) throw Exception('No text response from Gemini');

      rawText = rawText
          .replaceAll(RegExp(r'```json\s*'), '')
          .replaceAll(RegExp(r'```\s*'), '')
          .trim();

      late final Map<String, dynamic> jsonData;

      try {
        jsonData = jsonDecode(rawText);
      } catch (_) {
        throw Exception('Invalid JSON returned from Gemini $rawText');
      }

      final recipes = jsonData['recipes'];
      if (recipes is! List) {
        throw Exception('recipe_suggestions is not a list');
      }

      return recipes
          .map((e) => RecipeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;

      if (statusCode == 429) {
        throw Exception(
          'Too many requests. Please wait a moment and try again.',
        );
      } else if (statusCode == 401 || statusCode == 403) {
        throw Exception('API access denied. Please check your configuration.');
      } else if (statusCode == 404) {
        throw Exception('AI model not found. Please try again later.');
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Request timed out. Check your connection and retry.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('No internet connection. Please check your network.');
      } else {
        throw Exception('Something went wrong. Please try again.');
      }
    }
  }
}
