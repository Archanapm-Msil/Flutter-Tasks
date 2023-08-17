import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final double rating;
  final double size;

  const RatingStar({Key? key, required this.rating, this.size = 40.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> starList = [];

    int givenRating = rating.floor();
    int fractionalRating = ((rating - givenRating) * 10).ceil();

    for (int i = 0; i < 5; i++) {
      if (i < givenRating) {
        starList.add(
          Icon(Icons.star, color: Colors.amberAccent, size: size),
        );
      } else if (i == givenRating) {
        starList.add(
          SizedBox(
            height: size,
            width: size,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Icon(Icons.star, color: Colors.amberAccent, size: size),
                ClipRect(
                  clipper: _Clipper(part: fractionalRating),
                  child: Icon(Icons.star, color: Colors.grey, size: size),
                ),
              ],
            ),
          ),
        );
      } else {
        starList.add(Icon(Icons.star, color: Colors.grey, size: size));
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: starList,
    );
  }
}

class _Clipper extends CustomClipper<Rect> {
  final int part;

  _Clipper({required this.part});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
      (size.width / 10) * part,
      0.0,
      size.width,
      size.height,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}
