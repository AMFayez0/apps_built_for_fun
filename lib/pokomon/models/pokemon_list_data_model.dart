import 'package:app_built_for_fun/pokomon/models/pokemon_list_result_model.dart';

class PokemonListDataModel {
  int? count;
  String? next;
  String? previous;
  List<PokemonListResultModel>? results;

  PokemonListDataModel({this.count, this.next, this.previous, this.results});

  PokemonListDataModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <PokemonListResultModel>[];
      json['results'].forEach((v) {
        results!.add(PokemonListResultModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  PokemonListDataModel copyWith({
    int? count,
    String? next,
    String? previous,
    List<PokemonListResultModel>? results,
  }) {
    return PokemonListDataModel(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}
