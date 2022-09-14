import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/pokemon_model.dart';
import '../../../bloc/pokemon_bloc.dart';
import '../../../bloc/pokemon_event.dart';
import '../../../bloc/pokemon_state.dart';

class PokemonDetailsButton extends StatelessWidget {
  const PokemonDetailsButton({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoaded) {
          return InkWell(
            onTap: () => context
                .read<PokemonBloc>()
                .add(AddOrRemovePokemon(pokemon: pokemon)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 8,
                    offset: Offset(0, 7),
                  ),
                  BoxShadow(
                    color: Color(0x11000000),
                    blurRadius: 17,
                    offset: Offset(0, 12),
                  ),
                  BoxShadow(
                    color: Color(0x0f000000),
                    blurRadius: 22,
                    offset: Offset(0, 5),
                  ),
                ],
                color: state.isfavoritePokemon
                    ? const Color(0xffD5DEFF)
                    : const Color(0xff3558cd),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.isfavoritePokemon
                        ? 'Remove from favourites'
                        : "Mark as favourite",
                    style: TextStyle(
                      color: state.isfavoritePokemon
                          ? const Color(0xFF3558CD)
                          : Colors.white,
                      fontSize: 14,
                      fontFamily: "Noto Sans",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
