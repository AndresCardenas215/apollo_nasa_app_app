import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final double rating;
  final ValueChanged<double> onRatingChanged;

  const StarRating({required this.rating, required this.onRatingChanged});

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  double _rating = 0.0;

  @override
  void initState() {
    super.initState();
    _rating = widget.rating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
            (index) => IconButton(
          icon: Icon(
            _rating >= index + 1 ? Icons.star : Icons.star_border,
            size: 30.0,
          ),
          onPressed: () {
            setState(() {
              _rating = index + 1.0;
              widget.onRatingChanged(_rating);
            });
          },
        ),
      ),
    );
  }
}
