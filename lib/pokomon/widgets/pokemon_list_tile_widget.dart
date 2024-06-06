// ignore_for_file: must_be_immutable

import 'package:app_built_for_fun/pokomon/controllers/favourite_pokemon_controller.dart';
import 'package:app_built_for_fun/pokomon/models/pokemon_model.dart';
import 'package:app_built_for_fun/pokomon/providers/favourite_pokemon_provider.dart';
import 'package:app_built_for_fun/pokomon/providers/pokemon_data_provider.dart';
import 'package:app_built_for_fun/pokomon/widgets/stats_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonListItem extends ConsumerWidget {
  final String pokemonURL;
  late FavouritePokemonController favouritePokemonController;
  late List<String> favouritePokemonList;
  PokemonListItem({
    super.key,
    required this.pokemonURL,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    favouritePokemonController = ref.watch(favouritePokemonProvider.notifier);
    favouritePokemonList = ref.watch(favouritePokemonProvider);
    final pokemon = ref.watch(pokemonDataProvider(pokemonURL));

    return pokemon.when(data: (pokemon) {
      return pokemonListTile(
        context,
        pokemon,
        false,
      );
    }, loading: () {
      return pokemonListTile(
        context,
        null,
        true,
      );
    }, error: ((error, stackTrace) {
      return Text('Error: $error');
    }));
  }

  Widget pokemonListTile(
    BuildContext context,
    PokemonModel? pokemon,
    bool isloading,
  ) {
    return Skeletonizer(
      enabled: isloading,
      child: GestureDetector(
        onTap: () {
          if (!isloading) {
            showDialog(
              context: context,
              builder: (_) {
                return PokemonStatsDialog(pokemonURL: pokemonURL);
              },
            );
          }
        },
        child: ListTile(
          title: Text(
              pokemon != null
                  ? pokemon.name!.toUpperCase()
                  : "Currently loading name for Pokemon.",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              )),
          subtitle: Text("Has ${pokemon?.moves?.length ?? 0} moves."),
          trailing: IconButton(
            onPressed: pokemon != null
                ? () {
                    if (favouritePokemonList.contains(pokemonURL)) {
                      favouritePokemonController
                          .removeFavouritePokemon(pokemonURL);
                    } else {
                      favouritePokemonController
                          .addFavouritePokemon(pokemonURL);
                    }
                  }
                : null,
            icon: Icon(
              pokemon != null && favouritePokemonList.contains(pokemonURL)
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
              color: Colors.red,
            ),
          ),
          leading: pokemon != null
              ? CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Image.network(
                      pokemon.sprites!.frontDefault!,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : const CircleAvatar(),
        ),
      ),
    );
  }
}
