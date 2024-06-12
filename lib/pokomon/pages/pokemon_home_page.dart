import 'package:app_built_for_fun/pokomon/widgets/pokemon_card_widget.dart';
import 'package:app_built_for_fun/pokomon/widgets/pokemon_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_built_for_fun/pokomon/controllers/all_pokemon_controller.dart';
import 'package:app_built_for_fun/pokomon/data/home_page_data.dart';
import 'package:app_built_for_fun/pokomon/models/pokemon_list_result_model.dart';
import 'package:app_built_for_fun/pokomon/providers/all_pokenmon_provider.dart';
import 'package:app_built_for_fun/pokomon/providers/favourite_pokemon_provider.dart';

class PokemonHomePage extends ConsumerStatefulWidget {
  const PokemonHomePage({super.key});

  @override
  ConsumerState<PokemonHomePage> createState() => _PokemonHomePageState();
}

class _PokemonHomePageState extends ConsumerState<PokemonHomePage> {
  late HomePageData homePageData;
  late AllPokemonController allPokemonController;
  final ScrollController allPokemonScrollController = ScrollController();
  late List<String> favouritePokemonList;
  @override
  void initState() {
    super.initState();
    allPokemonScrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    allPokemonScrollController.removeListener(scrollListener);
    super.dispose();
  }

  void scrollListener() {
    if (allPokemonScrollController.offset >=
            allPokemonScrollController.position.maxScrollExtent * 1 &&
        !allPokemonScrollController.position.outOfRange) {
      allPokemonController.fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    favouritePokemonList = ref.watch(favouritePokemonProvider);
    homePageData = ref.watch(allPokemonProvider);
    allPokemonController = ref.watch(allPokemonProvider.notifier);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * 0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Favorite Pokemons',
                              style: TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * .50,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (favouritePokemonList.isNotEmpty)
                                    SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              .48,
                                      child: GridView.builder(
                                          scrollDirection: Axis.horizontal,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                          ),
                                          itemCount:
                                              favouritePokemonList.length,
                                          itemBuilder: (context, index) {
                                            String pokemonURL =
                                                favouritePokemonList[index];
                                            return PokemonCard(
                                              pokemonURL: pokemonURL,
                                            );
                                          }),
                                    ),
                                  if (favouritePokemonList.isEmpty)
                                    const Text('No pokemons added yet!'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'All Pokomons',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),),
                              color: Colors.white
                       
                        ),
                        height: MediaQuery.sizeOf(context).height * 0.6,
                        child: ListView.builder(
                          controller: allPokemonScrollController,
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.zero,
                          itemCount: homePageData.data?.results?.length ?? 0,
                          itemBuilder: (context, index) {
                            PokemonListResultModel pokemon =
                                homePageData.data!.results![index];
                            return PokemonListItem(
                              pokemonURL: pokemon.url!,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
