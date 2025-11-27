import '../../../../shared/models/recipe/saved_recipe_model.dart';
import '../repository/saved_repository.dart';

class GetSavedStream {
  final SavedRepository repo;

  GetSavedStream(this.repo);

  Stream<List<SavedRecipe>> call() {
    return repo.getSavedStream().map(
      (either) => either.fold((_) => <SavedRecipe>[], (list) => list),
    );
  }
}