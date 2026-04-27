import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../shared/models/recipe/recipe.dart';
import '../repository/saved_repository.dart';

class ToggleSaved {
  final SavedRepository repository;

  ToggleSaved(this.repository);

  Future<Either<Failure, void>> call(Recipe recipe, {String? notes}) {
    return repository.toggleSaved(recipe, notes: notes);
  }
}
