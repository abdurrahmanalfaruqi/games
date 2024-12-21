import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:games_app/providers/videogames_provider.dart';
import 'package:games_app/screens/favorites.dart';

import 'package:games_app/screens/home.dart';
import 'package:games_app/screens/search.dart';
import 'package:games_app/screens/videogames.dart';

class IndexScreen extends ConsumerStatefulWidget {
  const IndexScreen({super.key});

  @override
  ConsumerState<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends ConsumerState<IndexScreen> {
  int _selectedIndex = 0;

  final _pages = [
    const HomeScreen(),
    const VideogamesScreen(),
    const FavoritesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final videogames = ref.watch(videogamesProvider.notifier).allVideogames;

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.title),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchScreen(
                    videogames: videogames,
                  ),
                );
              },
              icon: Icon(
                  Platform.isAndroid ? Icons.search : CupertinoIcons.search),
            ),
          ],
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedFontSize: 12,
          unselectedFontSize: 10,
          unselectedItemColor: Theme.of(context).colorScheme.tertiary,
          selectedItemColor: Theme.of(context).appBarTheme.backgroundColor,
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          currentIndex: _selectedIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: AppLocalizations.of(context)!.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.videogame_asset),
              label: AppLocalizations.of(context)!.games,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_border),
              label: AppLocalizations.of(context)!.favorites,
            ),
          ],
        ));
  }
}
