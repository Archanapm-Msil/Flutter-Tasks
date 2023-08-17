abstract class RatingState {}

class RatingInitial extends RatingState {}

class RatingAdded extends RatingState {
 final double rating;

 RatingAdded(this.rating);
}