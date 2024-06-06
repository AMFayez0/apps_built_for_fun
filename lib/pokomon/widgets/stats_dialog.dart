import 'package:app_built_for_fun/pokomon/providers/pokemon_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PokemonStatsDialog extends ConsumerWidget {
  final String pokemonURL;
  const PokemonStatsDialog({
    super.key,
    required this.pokemonURL,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonDataProvider(pokemonURL));
    return AlertDialog(
      title: const Center(child: Text('Statistics')),
      content: pokemon.when(data: (pokemon) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: pokemon?.stats?.map(
                (s) {
                  return Text(
                    "${s.stat?.name?.toUpperCase()} : ${s.baseStat}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  );
                },
              ).toList() ??
              [],
        );
      }, error: (error, stackTrace) {
        return Text(error.toString());
      }, loading: () {
        return const CircularProgressIndicator();
      }),
    );
  }
}
