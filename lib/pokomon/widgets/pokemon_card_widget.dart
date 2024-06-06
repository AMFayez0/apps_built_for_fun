// ignore_for_file: must_be_immutable

import 'package:app_built_for_fun/pokomon/controllers/favourite_pokemon_controller.dart';
import 'package:app_built_for_fun/pokomon/models/pokemon_model.dart';
import 'package:app_built_for_fun/pokomon/providers/favourite_pokemon_provider.dart';
import 'package:app_built_for_fun/pokomon/providers/pokemon_data_provider.dart';
import 'package:app_built_for_fun/pokomon/widgets/stats_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonCard extends ConsumerWidget {
  final String pokemonURL;
  late FavouritePokemonController favouritePokemonController;

  PokemonCard({
    required this.pokemonURL,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonDataProvider(pokemonURL));
    final favouritePokemonController =
        ref.watch(favouritePokemonProvider.notifier);

    return pokemon.when(
      data: (pokemon) =>
          buildPokemonCard(context, pokemon, false, favouritePokemonController),
      error: ((error, stackTrace) {
        return Text('Error: $error');
      }),
      loading: () {
        return buildPokemonCard(
            context, null, true, favouritePokemonController);
      },
    );
  }

  Widget buildPokemonCard(
    BuildContext context,
    PokemonModel? pokemon,
    bool isloading,
    FavouritePokemonController favouritePokemonController,
  ) {
    return Skeletonizer(
      enabled: isloading,
      // ignoreContainers: true,
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
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.45,
          height: MediaQuery.sizeOf(context).height * 0.25,
          margin: EdgeInsets.only(
            left: MediaQuery.sizeOf(context).width * 0.02,
            top: MediaQuery.sizeOf(context).height * 0.01,
            bottom: MediaQuery.sizeOf(context).height * 0.01,
          ),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.lightBlue,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pokemon?.name?.toUpperCase() ?? 'Loading......',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    pokemon != null ? '#${pokemon.id}' : '.....',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
              CircleAvatar(
                radius: MediaQuery.sizeOf(context).width * 0.11,
                child: pokemon != null
                    ? Image.network(
                        pokemon.sprites!.frontDefault!,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox.shrink(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      pokemon != null
                          ? '${pokemon.moves?.length ?? 0} moves'
                          : 'no move',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  IconButton(
                    onPressed: pokemon != null
                        ? () {
                            favouritePokemonController
                                .removeFavouritePokemon(pokemonURL);
                          }
                        : null,
                    icon: Icon(
                      Icons.favorite,
                      color: pokemon != null
                          ? Colors.red
                          : Colors.grey, // Indicate loading or error state
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
