import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:games_app/widgets/videogames_grid.dart';
import 'package:games_app/widgets/videogames_list.dart';
import '../providers/videogames_provider.dart';

class VideogamesScreen extends ConsumerStatefulWidget {
  const VideogamesScreen({super.key});

  @override
  ConsumerState<VideogamesScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<VideogamesScreen> {
  final _scrollController = ScrollController();
  bool _isGrid = true;
  bool _isAscending = true;
  bool _isMetaAscending = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref.read(videogamesProvider.notifier).loadVideogames();
    }
  }

  @override
  Widget build(BuildContext context) {
    final videogames = ref.watch(videogamesProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _isMetaAscending = !_isMetaAscending;
                        ref
                            .read(videogamesProvider.notifier)
                            .filterByMetacritic(_isMetaAscending);
                      });
                    },
                    icon: Icon(
                      Platform.isAndroid
                          ? _isMetaAscending
                              ? Icons.arrow_downward
                              : Icons.arrow_upward
                          : _isMetaAscending
                              ? CupertinoIcons.chevron_down
                              : CupertinoIcons.chevron_up,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: Text(AppLocalizations.of(context)!.metacritic)),
                TextButton.icon(
                    label: Text(AppLocalizations.of(context)!.filter_by_rating),
                    onPressed: () {
                      setState(() {
                        _isAscending = !_isAscending;
                        ref
                            .read(videogamesProvider.notifier)
                            .filterByRating(_isAscending);
                      });
                    },
                    icon: Icon(Platform.isAndroid
                        ? _isAscending
                            ? Icons.arrow_downward
                            : Icons.arrow_upward
                        : _isAscending
                            ? CupertinoIcons.chevron_down
                            : CupertinoIcons.chevron_up)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isGrid = !_isGrid;
                    });
                  },
                  icon: Icon(
                    _isGrid
                        ? Platform.isIOS
                            ? CupertinoIcons.square_list
                            : Icons.list
                        : Platform.isIOS
                            ? CupertinoIcons.square_grid_2x2
                            : Icons.grid_view,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
          SliverFillRemaining(
              child: _isGrid
                  ? VideogameGrid(
                      videogames: videogames,
                      scrollController: _scrollController,
                    )
                  : VideogameList(
                      videogames: videogames,
                      scrollController: _scrollController)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
