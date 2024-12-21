import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:games_app/widgets/metascore.dart';
import 'package:games_app/widgets/stars_row.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/videogame.dart';
import '../screens/videogame_details.dart';

class VideogameItem extends StatelessWidget {
  final Videogame videogame;
  final bool isGrid;

  const VideogameItem({super.key, required this.videogame, this.isGrid = true});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    Widget image() {
      return Hero(
        tag: videogame.id,
        child: videogame.imageUrl.isNotEmpty
            ? FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: videogame.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: isGrid ? 200 : 100,
              )
            : Icon(
                Platform.isIOS ? CupertinoIcons.photo : Icons.photo,
                size: isGrid ? 200 : 100,
              ),
      );
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VideogameDetails(videogame: videogame)));
      },
      child: isGrid
          ? ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Stack(
                children: [
                  image(),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              videogame.rating.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 16,
                            ),
                          ],
                        ),
                      )),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        videogame.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      child: MetaScoreWidget(metascore: videogame.metacritic))
                ],
              ),
            )
          : Card(
              child: Row(
              children: <Widget>[
                SizedBox(
                  width: width > 600 ? 400 : 200,
                  height: width > 600 ? 300 : 200,
                  child: image(),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        videogame.title,
                        style: TextStyle(
                          fontSize: width > 600 ? 23 : 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        videogame.releaseDate,
                        style: TextStyle(
                          fontSize: width > 600 ? 18 : 12,
                        ),
                      ),
                      StarsRowWidget(rating: videogame.rating),
                    ],
                  ),
                ),
              ],
            )),
    );
  }
}
