import 'package:flutter/material.dart';
import 'package:star_rating_app/utils/star_painter.dart';

class StarRatingIndicator extends StatelessWidget {
  final double rating;
  final Color color;

  const StarRatingIndicator({Key? key, required this.rating, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        double starRating = (rating - index).clamp(0.0, 1.0);
        bool isFilled = starRating >= 0.9;
        bool isHalfFilled = starRating > 0.00 && starRating < 0.9;
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: CustomPaint(
            painter: StarPainter(color: isFilled ? color : (isHalfFilled ? color.withOpacity(starRating) : Colors.grey)),
            size: const Size(30, 30),
          ),
        );
      }),
    );
  }
}

