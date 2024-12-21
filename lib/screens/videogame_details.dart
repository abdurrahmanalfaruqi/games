import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:games_app/widgets/metascore.dart';

import 'package:games_app/widgets/stars_row.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/videogame.dart';
import '../providers/favorites_provider.dart';

class VideogameDetails extends ConsumerWidget {
  final Videogame videogame;

  const VideogameDetails({super.key, required this.videogame});

  void _showInfoMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2, milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteVideogame = ref.watch(favoritesVideogamesProvider);
    final isFavorite = favoriteVideogame.contains(videogame);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Hero(
                  tag: videogame.id,
                  child: Image.network(
                    videogame.imageUrl,
                    width: double.infinity,
                    height: 350,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              iconTheme:
                  IconThemeData(color: Theme.of(context).appBarTheme.backgroundColor),
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  icon: AnimatedSwitcher(
                    transitionBuilder: (child, animation) => ScaleTransition(
                      scale: Tween<double>(begin: 0.2, end: 1.0)
                          .animate(animation),
                      child: child,
                    ),
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      isFavorite
                          ? Platform.isIOS
                              ? CupertinoIcons.heart_fill
                              : Icons.favorite
                          : Platform.isIOS
                              ? CupertinoIcons.heart
                              : Icons.favorite_border,
                      key: ValueKey(isFavorite),
                    ),
                  ),
                  onPressed: () {
                    final wasAdded = ref
                        .read(favoritesVideogamesProvider.notifier)
                        .toggleMealFavoriteStatus(videogame);

                    if (wasAdded) {
                      _showInfoMessage(
                          AppLocalizations.of(context)!.added_to_favorites,
                          context);
                    } else {
                      _showInfoMessage(
                          AppLocalizations.of(context)!.removed_from_favorites,
                          context);
                    }
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: kToolbarHeight + MediaQuery.of(context).padding.top + 160,
            left: 0,
            right: 0,
            bottom: 5,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .background
                                  .withOpacity(0.75),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      videogame.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                  ),
                                  StarsRowWidget(rating: videogame.rating),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color:
                                Theme.of(context).appBarTheme.foregroundColor,
                            surfaceTintColor:
                                Theme.of(context).colorScheme.secondary,
                            margin: const EdgeInsets.all(8),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            textAlign: TextAlign.start,
                                            "${AppLocalizations.of(context)!.release_date}:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Platform.isIOS
                                                    ? CupertinoIcons.calendar
                                                    : Icons.calendar_today,
                                                color: Theme.of(context)
                                                    .appBarTheme
                                                    .backgroundColor,
                                                size: 36,
                                              ),
                                              const SizedBox(width: 12),
                                              Text(videogame.releaseDate),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            textAlign: TextAlign.start,
                                            "${AppLocalizations.of(context)!.metacritic}:",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          MetaScoreWidget(
                                              metascore: videogame.metacritic),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Card(
                            color:
                                Theme.of(context).appBarTheme.foregroundColor,
                            surfaceTintColor:
                                Theme.of(context).colorScheme.secondary,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context)!.rawg}:',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: () async {
                                      final Uri url =
                                          Uri.parse('https://rawg.io/');
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      }
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        width: 310,
                                        height: 150,
                                        fit: BoxFit.cover,
                                        "assets/images/rawg_logo.png",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
