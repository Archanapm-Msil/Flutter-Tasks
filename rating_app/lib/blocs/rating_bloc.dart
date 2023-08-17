import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rating_app/events/rating_events.dart';
import 'package:rating_app/states/rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
RatingBloc() : super(RatingInitial()) {
 on<AddRating>((event, emit) {
 emit(RatingAdded(event.rating)); });
 }
}