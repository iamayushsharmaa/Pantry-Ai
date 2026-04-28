part of 'recipe_bloc.dart';

enum RecipeStatus { initial, loading, success, failure, noGroceries}

@immutable
class RecipeState {
  final RecipeStatus status;
  final List<Recipe> recipes;
  final String? imagePath;
  final TastePreferences? preferences;
  final String? error;
  final int fetchCount;
  final bool hasReachedMax;
  final int retryCount;

  static const int maxFetches = 2;
  static const int maxRecipes = 15;

  static const int maxRetries = 2;

  bool get canRetry => retryCount < maxRetries;

  bool get isLoading => status == RecipeStatus.loading;

  bool get canFetchMore =>
      !hasReachedMax && fetchCount < maxFetches && recipes.length < maxRecipes;

  const RecipeState({
    this.status = RecipeStatus.initial,
    this.recipes = const [],
    this.imagePath,
    this.preferences,
    this.error,
    this.retryCount = 0,
    this.fetchCount = 0,
    this.hasReachedMax = false,
  });

  static const Object _keep = Object();

  RecipeState copyWith({
    RecipeStatus? status,
    List<Recipe>? recipes,
    String? imagePath,
    TastePreferences? preferences,
    Object? error = _keep,
    int? fetchCount,
    bool? hasReachedMax,
    int? retryCount,
  }) {
    return RecipeState(
      status: status ?? this.status,
      recipes: recipes ?? this.recipes,
      imagePath: imagePath ?? this.imagePath,
      preferences: preferences ?? this.preferences,
      error: error == _keep ? this.error : error as String?,
      fetchCount: fetchCount ?? this.fetchCount,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      retryCount: retryCount ?? this.retryCount,
    );
  }
}
