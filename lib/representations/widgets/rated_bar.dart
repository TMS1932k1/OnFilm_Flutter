import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatedBar extends StatelessWidget {
  final double point;
  final double size;

  const RatedBar(this.point, this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: point,
      itemSize: size,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      ignoreGestures: true,
      unratedColor: Colors.grey,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.yellow,
      ),
      onRatingUpdate: (rating) {},
    );
  }
}
