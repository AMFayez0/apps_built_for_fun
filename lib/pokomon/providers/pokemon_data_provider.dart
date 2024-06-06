import 'package:app_built_for_fun/pokomon/models/pokemon_model.dart';
import 'package:app_built_for_fun/services/http_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

final pokemonDataProvider =
    FutureProvider.family<PokemonModel?, String>((ref, url) async {
  HTTPService httpService = GetIt.instance.get<HTTPService>();

  Response? res = await httpService.get(url);
  if (res != null && res.data != null) {
    PokemonModel pokemon = PokemonModel.fromJson(res.data);
    return pokemon;
  }
  return null;
});
