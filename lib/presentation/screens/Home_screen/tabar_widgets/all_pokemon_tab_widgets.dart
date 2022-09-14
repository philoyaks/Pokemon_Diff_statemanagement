import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/pokemon_model.dart';
import '../../../bloc/pokemon_bloc.dart';
import '../../../bloc/pokemon_event.dart';
import '../../../bloc/pokemon_state.dart';
import '../../../widgets/pokemon_cards.dart';

class AllPokemon extends StatefulWidget {
  const AllPokemon({Key? key}) : super(key: key);

  @override
  State<AllPokemon> createState() => _AllPokemonState();
}

class _AllPokemonState extends State<AllPokemon>
    with AutomaticKeepAliveClientMixin {
  // ignore: must_call_super
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        Future.delayed(Duration.zero, () {
          BlocProvider.of<PokemonBloc>(context).add(LoadMorePokemon(context));
        });
        // if (continuationLoader.isFalse) {
        //   continuationLoader.value = true;
        //   await loadPokemonResults();
        //   continuationLoader.value = false;
        // }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    PokemonBloc bloc = BlocProvider.of<PokemonBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 17),
      child: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PokemonError) {
            return Text(state.message);
          } else if (state is PokemonLoaded) {
            return ListView(
              controller: scrollController,
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
                    itemCount: state.allPokemons!.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, indx) {
                      Pokemon pok = state.allPokemons![indx];
                      return GestureDetector(
                          onTap: () => bloc.add(GotoDetailsScreen(
                              context: context, pokemon: pok)),
                          child: pokemonCards(pokemon: pok));
                    }),
                if (state.showPaginationLoader)
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
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
