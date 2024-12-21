import 'package:flutter/material.dart';

class MetaScoreWidget extends StatelessWidget {
  final int metascore;

  const MetaScoreWidget({super.key, required this.metascore});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: metascore >= 60
            ? Colors.green
            : metascore <= 59 && metascore >= 40
                ? Colors.orange
                : Colors.red,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        textAlign: TextAlign.center,
        metascore.toString(),
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
