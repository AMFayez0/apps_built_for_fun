import 'package:app_built_for_fun/pokomon/models/abilities_model.dart';
import 'package:app_built_for_fun/pokomon/models/moves_model.dart';
import 'package:app_built_for_fun/pokomon/models/sprites_model.dart';
import 'package:app_built_for_fun/pokomon/models/stats_model.dart';

class PokemonModel {
  List<AbilitiesModel>? abilities;
  int? height;
  int? id;
  List<MovesModel>? moves;
  String? name;
  Ability? species;
  Sprites? sprites;
  List<Stats>? stats;
  int? weight;

  PokemonModel(
      {this.abilities,
      this.height,
      this.id,
      this.moves,
      this.name,
      this.species,
      this.sprites,
      this.stats,
      this.weight});

  PokemonModel.fromJson(Map<String, dynamic> json) {
    if (json['abilities'] != null) {
      abilities = <AbilitiesModel>[];
      json['abilities'].forEach((v) {
        abilities!.add(AbilitiesModel.fromJson(v));
      });
    }
    height = json['height'];
    id = json['id'];
    if (json['moves'] != null) {
      moves = <MovesModel>[];
      json['moves'].forEach((v) {
        moves!.add(MovesModel.fromJson(v));
      });
    }
    name = json['name'];
    species =
        json['species'] != null ? Ability.fromJson(json['species']) : null;
    sprites =
        json['sprites'] != null ? Sprites.fromJson(json['sprites']) : null;
    if (json['stats'] != null) {
      stats = <Stats>[];
      json['stats'].forEach((v) {
        stats!.add(Stats.fromJson(v));
      });
    }
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (abilities != null) {
      data['abilities'] = abilities!.map((v) => v.toJson()).toList();
    }

    data['height'] = height;

    data['id'] = id;

    if (moves != null) {
      data['moves'] = moves!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;

    if (species != null) {
      data['species'] = species!.toJson();
    }
    if (sprites != null) {
      data['sprites'] = sprites!.toJson();
    }
    if (stats != null) {
      data['stats'] = stats!.map((v) => v.toJson()).toList();
    }
    data['weight'] = weight;
    return data;
  }
}
