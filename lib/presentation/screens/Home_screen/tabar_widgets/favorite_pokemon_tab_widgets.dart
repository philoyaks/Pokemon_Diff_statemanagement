import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/models/pokemon_model.dart';
import '../../../bloc/pokemon_bloc.dart';
import '../../../bloc/pokemon_event.dart';
import '../../../bloc/pokemon_state.dart';
import '../../../widgets/pokemon_cards.dart';

class FavoritePokemon extends StatelessWidget {
  const FavoritePokemon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 17),
      child: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoaded) {
            return GridView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 4 / 3,
                    mainAxisExtent: 186),
                itemCount: state.favoritePokemon!.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, indx) {
                  Pokemon pok = state.favoritePokemon!.reversed.toList()[indx];
                  return GestureDetector(
                      onTap: () => context.read<PokemonBloc>().add(
                          GotoDetailsScreen(context: context, pokemon: pok)),
                      child: pokemonCards(pokemon: pok));
                });
          } else if (state is PokemonLoading) {
            return const CircularProgressIndicator();
          } else if (state is PokemonError) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
