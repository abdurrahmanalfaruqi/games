import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:games_app/models/videogame.dart';

class FavoritesNotifier extends StateNotifier<List<Videogame>> {
  FavoritesNotifier() : super([]);

  bool toggleMealFavoriteStatus(Videogame videogame) {
    final existingIndex =
        state.indexWhere((element) => element.id == videogame.id);
    if (existingIndex >= 0) {
      state = [...state]..removeAt(existingIndex);
      return false;
    } else {
      state = [...state, videogame];
      return true;
    }
  }
}

final favoritesVideogamesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Videogame>>((ref) {
  return FavoritesNotifier();
});
