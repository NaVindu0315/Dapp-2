import 'package:dapp2/starrating.dart';
import 'package:flutter/material.dart';

class Ratingclz extends StatefulWidget {
  const Ratingclz({Key? key}) : super(key: key);

  @override
  State<Ratingclz> createState() => _RatingclzState();
}

class _RatingclzState extends State<Ratingclz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Star Rating Example'),
      ),
      body: Center(
        child: InteractiveRatingWidget(
          maxRating: 5,
          filledStar: Icons.star,
          unfilledStar: Icons.star_border,
          onChanged: (rating) {
            print('Rating changed to $rating');
          },
        ),
      ),
    );
  }
}
