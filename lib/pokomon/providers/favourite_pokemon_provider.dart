import 'package:app_built_for_fun/pokomon/controllers/favourite_pokemon_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favouritePokemonProvider =
    StateNotifierProvider<FavouritePokemonController, List<String>>((ref) {
  return FavouritePokemonController([]);
});
