import 'package:pantry_ai/features/cooking_session/domain/entities/cooking_step.dart';

class CookingStepModel extends CookingStep {
  CookingStepModel({
    required super.index,
    required super.title,
    required super.description,
    required super.estimatedMinutes,
    required super.imageUrl,
  });
}
