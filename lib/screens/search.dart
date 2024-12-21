import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:games_app/widgets/videogames_grid.dart';

import '../models/videogame.dart';

class SearchScreen extends SearchDelegate<Videogame?> {
  final List<Videogame> videogames;

  SearchScreen({required this.videogames});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Platform.isAndroid
            ? const Icon(Icons.clear)
            : const Icon(CupertinoIcons.clear_circled),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Platform.isAndroid
          ? const Icon(Icons.arrow_back)
          : const Icon(CupertinoIcons.back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = videogames
        .where((videogame) =>
            query.isNotEmpty &&
            videogame.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return VideogameGrid(videogames: results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Text('Suggestions');
  }
}
