import 'package:app_built_for_fun/pokomon/models/abilities_model.dart';

class MovesModel {
  Ability? move;

  MovesModel({this.move});

  MovesModel.fromJson(Map<String, dynamic> json) {
    move = json['move'] != null ? Ability.fromJson(json['move']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (move != null) {
      data['move'] = move!.toJson();
    }
    return data;
  }
}
