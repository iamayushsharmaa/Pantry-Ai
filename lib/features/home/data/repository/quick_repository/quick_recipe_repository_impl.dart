import '../../../../../shared/models/recipe/recipe.dart';
import '../../../domain/repository/quick_repository/quick_recipe_repository.dart';
import '../../remote/user_remote_datasource.dart';

class QuickRecipesRepositoryImpl implements QuickRecipesRepository {
  final UserRecipesRemoteDataSource remote;

  QuickRecipesRepositoryImpl(this.remote);

  @override
  Future<List<Recipe>> getQuickRecipes({
    required String userId,
    required int maxCookingTime,
  }) {
    return remote.getQuickRecipes(
      userId: userId,
      maxCookingTime: maxCookingTime,
    );
  }
}
