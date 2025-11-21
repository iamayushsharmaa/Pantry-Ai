part of 'taste_preference_bloc.dart';

class TastePreferenceState extends Equatable {
  final String taste;
  final String cuisine;
  final String diet;
  final int maxCookingTime;
  final int currentPage;

  const TastePreferenceState({
    this.taste = '',
    this.cuisine = '',
    this.diet = '',
    this.maxCookingTime = 0,
    this.currentPage = 0,
  });

  bool get isCurrentStepValid {
    switch (currentPage) {
      case 0:
        return taste.isNotEmpty;
      case 1:
        return cuisine.isNotEmpty;
      case 2:
        return diet.isNotEmpty;
      case 3:
        return maxCookingTime > 0;
      default:
        return false;
    }
  }

  bool get isLastPage => currentPage == 3;

  TastePreferenceState copyWith({
    String? taste,
    String? cuisine,
    String? diet,
    int? maxCookingTime,
    int? currentPage,
  }) {
    return TastePreferenceState(
      taste: taste ?? this.taste,
      cuisine: cuisine ?? this.cuisine,
      diet: diet ?? this.diet,
      maxCookingTime: maxCookingTime ?? this.maxCookingTime,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [
    taste,
    cuisine,
    diet,
    maxCookingTime,
    currentPage,
  ];
}
