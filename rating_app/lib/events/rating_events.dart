

abstract class RatingEvent {}

class AddRating extends RatingEvent {
 final double rating;

 AddRating(this.rating);
}