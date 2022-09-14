



import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../controller/pokemon_controller.dart';
import '../../../models/pokemon_model.dart';

class PokemonDetailsButton extends StatelessWidget {
  const PokemonDetailsButton({
    Key? key,
    required this.ctr,
    required this.pokemon,
  }) : super(key: key);

  final PokemonController ctr;
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () => ctr.addOrRemoveFavoritePokemon(pokemon),
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
            color: ctr.isFavorite.value
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
                ctr.isFavorite.value
                    ? 'Remove from favourites'
                    : "Mark as favourite",
                style: TextStyle(
                  color: ctr.isFavorite.value
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
      ),
    );
  }
}
