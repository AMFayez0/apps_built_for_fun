import 'package:app_built_for_fun/services/loacl_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class FavouritePokemonController extends StateNotifier<List<String>> {
  // ignore: constant_identifier_names
  static const String FAVOURITE_POKEMON_LIST = 'FAVOURITE_POKEMON_LIST';
  final LocalStorage localStorage = GetIt.instance.get<LocalStorage>();

  FavouritePokemonController(super.state) {
    _setup();
  }
  Future<void> _setup() async {
    state = await localStorage.getList(FAVOURITE_POKEMON_LIST) ?? [];
  }

  void addFavouritePokemon(String url) async {
    state = [...state, url];
    localStorage.saveList(FAVOURITE_POKEMON_LIST, state);
  }

  void removeFavouritePokemon(String url) async {
    state = state.where((element) => element != url).toList();
    localStorage.saveList(FAVOURITE_POKEMON_LIST, state);
  }
}
