import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/app_utils.dart';
import '../models/pokemon_model.dart';

Container pokemonCards({Pokemon? pokemon}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              color: pokemon!.bgColor[100]),
          height: 104,
          child: CachedNetworkImage(
            imageUrl: pokemon.imageUrl.toString(),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress)),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding:
                const EdgeInsets.only(left: 9, top: 8, bottom: 10, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "# ${addZerosToId(pokemon.id ?? 0)}",
                  style: const TextStyle(
                    color: Color(0xff6b6b6b),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  pokemon.name ?? "Bulbasaur",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: const TextStyle(
                    color: Color(0xdd000000),
                    fontSize: 14,
                    fontFamily: "Noto Sans",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  pokemon.typesToString,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: const TextStyle(
                    color: Color(0xff6b6b6b),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
