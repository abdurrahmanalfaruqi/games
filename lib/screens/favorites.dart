import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:games_app/providers/favorites_provider.dart';
import 'package:games_app/widgets/videogames_grid.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesVideogamesProvider);

    Widget content = Center(
      child: Text(AppLocalizations.of(context)!.no_favorites,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              )),
    );

    if (favorites.isNotEmpty) {
      content = Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Text(AppLocalizations.of(context)!.my_favorites,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        )),
              ),
              SliverFillRemaining(
                child: VideogameGrid(videogames: favorites),
              ),
            ],
          ),
        ),
      );
    }

    return content;
  }
}
