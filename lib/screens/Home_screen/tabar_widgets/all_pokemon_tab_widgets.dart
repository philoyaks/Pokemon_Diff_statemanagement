import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/pokemon_controller.dart';
import '../../../models/pokemon_model.dart';
import '../../../widgets/pokemon_cards.dart';

class AllPokemon extends StatefulWidget {
  const AllPokemon({Key? key}) : super(key: key);

  @override
  State<AllPokemon> createState() => _AllPokemonState();
}

class _AllPokemonState extends State<AllPokemon>
    with AutomaticKeepAliveClientMixin {
  final controller = Get.put(PokemonController());

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 17),
      child: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                controller: controller.scrollController,
                children: [
                  GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 12.0,
                              childAspectRatio: 4 / 3,
                              mainAxisExtent: 186),
                      itemCount: controller.pokemons.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, indx) {
                        Pokemon pok = controller.pokemons[indx];
                        return GestureDetector(
                            onTap: () => controller.goToDetailsScreen(pok),
                            child: pokemonCards(pokemon: pok));
                      }),
                  if (controller.continuationLoader.isTrue)
                    SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Fetching More Pokemons...'),
                          SizedBox(
                            width: 10,
                          ),
                          Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    )
                ],
              ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
