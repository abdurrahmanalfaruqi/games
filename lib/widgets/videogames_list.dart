import 'package:flutter/material.dart';
import 'package:games_app/widgets/videogame_item.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/videogame.dart';

class VideogameList extends StatelessWidget {
  final List<Videogame> videogames;
  final ScrollController scrollController;

  const VideogameList(
      {super.key, required this.videogames, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ListView.builder(
      controller: scrollController,
      key: const PageStorageKey('videogames_list'),
      itemBuilder: (context, index) {
        return VideogameItem(videogame: videogames[index], isGrid: false);
      },
      itemCount: videogames.length,
    );
  }
}
