import 'package:app_built_for_fun/pokomon/data/home_page_data.dart';
import 'package:app_built_for_fun/pokomon/models/pokemon_list_data_model.dart';
import 'package:app_built_for_fun/services/http_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class AllPokemonController extends StateNotifier<HomePageData> {
  final GetIt getIt = GetIt.instance;
  late HTTPService httpService;
  AllPokemonController(super.state) {
    httpService = getIt.get<HTTPService>();
    _setup();
  }
  Future<void> _setup() async {
    fetchData();
  }

  Future<void> fetchData() async {
    if (state.data == null) {
      Response? res = await httpService.get(
        'https://pokeapi.co/api/v2/pokemon?limit=20&offset=0',
      );

      if (res != null && res.data != null) {
        PokemonListDataModel pokemonListData =
            PokemonListDataModel.fromJson(res.data);
        state = state.copyWith(data: pokemonListData);
      }
    } else {
      if (state.data?.next != null) {
        Response? res = await httpService.get(state.data!.next!);
        if (res != null && res.data != null) {
          PokemonListDataModel pokemonListData =
              PokemonListDataModel.fromJson(res.data);
          state = state.copyWith(
              data: pokemonListData.copyWith(results: [
            ...state.data!.results!,
            ...pokemonListData.results!
          ]));
        }
      }
    }
  }
}
