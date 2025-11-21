import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'taste_preference_event.dart';
part 'taste_preference_state.dart';

class TastePreferenceBloc extends Bloc<TastePreferenceEvent, TastePreferenceState> {
  TastePreferenceBloc() : super(TastePreferenceInitial()) {
    on<TastePreferenceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
