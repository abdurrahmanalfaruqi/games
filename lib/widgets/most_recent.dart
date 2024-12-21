import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:transparent_image/transparent_image.dart';

import '../providers/videogames_provider.dart';
import '../screens/videogame_details.dart';

class MostRecentWidget extends ConsumerWidget {
  const MostRecentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String extractYear(String releaseDate) {
      final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$'); // 2021-10-08 for example
      final match = regex.firstMatch(releaseDate);
      if (match != null) {
        return match.group(0)!.split('-').first;
      }

      return releaseDate;
    }

    final mostRecentGames = ref.read(videogamesProvider.notifier).recentGames;
    return mostRecentGames.isEmpty
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppLocalizations.of(context)!.most_recent,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: mostRecentGames.length,
                  itemBuilder: (context, index) {
                    final game = mostRecentGames[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              VideogameDetails(videogame: game),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: game.imageUrl,
                                width: 150,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                color: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor,
                                child: Text(
                                  game.title,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Theme.of(context).colorScheme.background,
                                  child: Text(
                                    extractYear(game.releaseDate),
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
