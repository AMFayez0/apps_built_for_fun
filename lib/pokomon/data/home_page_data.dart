import 'package:app_built_for_fun/pokomon/models/pokemon_list_data_model.dart';

class HomePageData {
  PokemonListDataModel? data;

  HomePageData({
    required this.data,
  });

  HomePageData.initial() : data = null;

  HomePageData copyWith({PokemonListDataModel? data}) {
    return HomePageData(
      data: data ?? this.data,
    );
  }
}
