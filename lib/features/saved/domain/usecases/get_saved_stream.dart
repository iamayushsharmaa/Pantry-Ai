import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../shared/models/saved_recipe/save_recipe.dart';
import '../repository/saved_repository.dart';

class GetSavedStream {
  final SavedRepository repo;

  GetSavedStream(this.repo);

  Stream<Either<Failure, List<SavedRecipe>>> call() {
    return repo.getSavedStream();
  }
}
