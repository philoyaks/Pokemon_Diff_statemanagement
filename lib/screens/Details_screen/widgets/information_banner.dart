import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_utils.dart';
import '../../../controller/pokemon_controller.dart';

class InfomationBannerDisplay extends StatelessWidget {
  const InfomationBannerDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemon = Get.find<PokemonController>().currentPokemon.value;
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top + kToolbarHeight,
        ),
        const Divider(
          thickness: 1,
        ),
        Container(
          height: 200,
          width: double.infinity,
          color: pokemon.bgColor[50],
          child: Stack(children: [
            Container(
              height: 200,
              padding: const EdgeInsets.only(left: 16, top: 23, bottom: 14),
              color: pokemon.bgColor[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon.name.toString(),
                    style: const TextStyle(
                      color: AppColors.textColorgrey,
                      fontSize: 32,
                      fontFamily: "Noto Sans",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    pokemon.typesToString,
                    style: const TextStyle(
                      color: AppColors.textColorgrey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Text(
                    '# ${addZerosToId(pokemon.id ?? 0)}',
                    style: const TextStyle(
                      color: AppColors.textColorgrey,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: -10,
              right: 0,
              child: SizedBox(
                height: 160,
                width: 124,
                child: SvgPicture.asset(
                  'assets/svgs/details_background_img.svg',
                  height: 160,
                  width: 124,
                  color: pokemon.bgColor[100],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 25,
              child: SizedBox(
                height: 136,
                width: 125,
                child: CachedNetworkImage(
                  imageUrl: pokemon.imageUrl.toString(),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
