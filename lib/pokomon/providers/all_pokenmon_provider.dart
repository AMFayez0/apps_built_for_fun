import 'package:app_built_for_fun/pokomon/controllers/all_pokemon_controller.dart';
import 'package:app_built_for_fun/pokomon/data/home_page_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allPokemonProvider =
    StateNotifierProvider<AllPokemonController, HomePageData>((ref) {
  return AllPokemonController(
    HomePageData.initial(),
  );
});
