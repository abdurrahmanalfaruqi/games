import 'package:flutter/material.dart';
import 'package:games_app/widgets/most_recent.dart';
import 'package:games_app/widgets/top_metacritic.dart';
import 'package:games_app/widgets/top_rated.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TopRatedWidget(),
            SizedBox(height: 16),
            MostRecentWidget(),
            SizedBox(height: 16),
            TopMetacriticWidget(),
          ],
        ),
      ),
    );
  }
}
