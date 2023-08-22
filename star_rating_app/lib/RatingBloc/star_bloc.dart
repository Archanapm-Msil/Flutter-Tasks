import 'package:flutter_bloc/flutter_bloc.dart';

class StarRatingBloc extends Bloc<StarRatingEvent, StarRatingState> {
  double rating = 0;

  StarRatingBloc() : super(StarRatingUpdatedState(0)) {
    on<UpdateRatingEvent>((event, emit) {
      rating = event.newRating;
      emit(StarRatingUpdatedState(rating));
    });
  }
}

abstract class StarRatingEvent {}

class UpdateRatingEvent extends StarRatingEvent {
  final double newRating;

  UpdateRatingEvent(this.newRating);
}

abstract class StarRatingState {}

class StarRatingUpdatedState extends StarRatingState {
  final double rating;

  StarRatingUpdatedState(this.rating);
}