import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/pokemon_controller.dart';
import '../../../models/pokemon_model.dart';
import '../../../widgets/pokemon_cards.dart';

class FavoritePokemon extends StatelessWidget {
  FavoritePokemon({Key? key}) : super(key: key);
  final PokemonController _controller = Get.find<PokemonController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 17),
        child: Obx(
          () => GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 12.0,
                  childAspectRatio: 4 / 3,
                  mainAxisExtent: 186),
              itemCount: _controller.favoritePokemons.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, indx) {
                Pokemon pok =
                    _controller.favoritePokemons.reversed.toList()[indx];
                return GestureDetector(
                    onTap: () => _controller.goToDetailsScreen(pok),
                    child: pokemonCards(pokemon: pok));
              }),
        ));
  }
}
