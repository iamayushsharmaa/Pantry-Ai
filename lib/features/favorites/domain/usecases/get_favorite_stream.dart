import '../entities/favorite_recipe_entity.dart';
import '../repository/favorite_repository.dart';

class GetFavoritesStream {
  final FavoriteRepository repo;

  GetFavoritesStream(this.repo);

  Stream<List<FavoriteRecipe>> call() =>
      repo.getFavoritesStream().map((e) => e.getOrElse(() => []));
}
