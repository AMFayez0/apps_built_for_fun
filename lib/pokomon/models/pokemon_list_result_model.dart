class PokemonListResultModel {
  String? name;
  String? url;

  PokemonListResultModel({this.name, this.url});

  PokemonListResultModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
