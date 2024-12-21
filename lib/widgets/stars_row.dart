import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarsRowWidget extends StatelessWidget {
  final double rating;

  const StarsRowWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    int totalStars = 5;
    List<Widget> stars = List.generate(
        totalStars,
        (index) => Icon(
              Platform.isIOS ? CupertinoIcons.star : Icons.star,
              color: Colors.amber,
              size: 16,
            ));

    int fullStars = rating.floor();
    for (int i = 0; i < fullStars; i++) {
      stars[i] = Icon(
        Platform.isIOS ? CupertinoIcons.star_fill : Icons.star,
        color: Colors.amber,
        size: 16,
      );
    }

    double decimalPart = rating - fullStars;
    if (decimalPart >= 0.75) {
      if (fullStars < totalStars) {
        stars[fullStars] = Icon(
          Platform.isIOS ? CupertinoIcons.star_lefthalf_fill : Icons.star_half,
          color: Colors.amber,
          size: 16,
        );
      }
    } else if (decimalPart >= 0.25) {
      if (fullStars < totalStars) {
        stars[fullStars] = Icon(
          Platform.isIOS ? CupertinoIcons.star_lefthalf_fill : Icons.star_half,
          color: Colors.amber,
          size: 16,
        );
      }
    }

    return Row(mainAxisSize: MainAxisSize.min, children: stars);
  }
}
