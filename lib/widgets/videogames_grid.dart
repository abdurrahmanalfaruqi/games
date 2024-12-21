import 'package:flutter/material.dart';
import 'package:games_app/widgets/videogame_item.dart';

import '../models/videogame.dart';

class VideogameGrid extends StatelessWidget {
  final List<Videogame> videogames;
  final ScrollController? scrollController;

  const VideogameGrid({
    super.key,
    required this.videogames,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GridView.builder(
        key: const PageStorageKey('videogames_grid'),
        controller: scrollController,
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: width > 600 ? 4 : 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: videogames.length,
        itemBuilder: (context, index) {
          return VideogameItem(videogame: videogames[index]);
        });
  }
}
