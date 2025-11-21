import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'taste_preference_event.dart';
part 'taste_preference_state.dart';

class TastePreferenceBloc
    extends Bloc<TastePreferenceEvent, TastePreferenceState> {
  TastePreferenceBloc() : super(TastePreferenceState()) {
    on<SelectTaste>((event, emit) {
      emit(state.copyWith(taste: event.taste));
    });

    on<SelectCuisine>((event, emit) {
      emit(state.copyWith(cuisine: event.cuisine));
    });

    on<SelectDiet>((event, emit) {
      emit(state.copyWith(diet: event.diet));
    });

    on<SelectMaxCookingTime>((event, emit) {
      emit(state.copyWith(maxCookingTime: event.minutes));
    });

    on<NextPreferencePage>((event, emit) {
      if (!state.isLastPage) {
        emit(state.copyWith(currentPage: state.currentPage + 1));
      }
    });

    on<PreviousPreferencePage>((event, emit) {
      if (state.currentPage > 0) {
        emit(state.copyWith(currentPage: state.currentPage - 1));
      }
    });
  }
}
