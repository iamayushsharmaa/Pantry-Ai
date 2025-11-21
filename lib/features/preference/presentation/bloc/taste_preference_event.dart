part of 'taste_preference_bloc.dart';

abstract class TastePreferenceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// User selections
class SelectTaste extends TastePreferenceEvent {
  final String taste;
  SelectTaste(this.taste);

  @override
  List<Object?> get props => [taste];
}

class SelectCuisine extends TastePreferenceEvent {
  final String cuisine;
  SelectCuisine(this.cuisine);

  @override
  List<Object?> get props => [cuisine];
}

class SelectDiet extends TastePreferenceEvent {
  final String diet;
  SelectDiet(this.diet);

  @override
  List<Object?> get props => [diet];
}

class SelectMaxCookingTime extends TastePreferenceEvent {
  final int minutes;
  SelectMaxCookingTime(this.minutes);

  @override
  List<Object?> get props => [minutes];
}

class NextPreferencePage extends TastePreferenceEvent {}

class PreviousPreferencePage extends TastePreferenceEvent {}
